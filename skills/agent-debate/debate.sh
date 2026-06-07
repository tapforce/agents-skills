#!/usr/bin/env bash
# debate.sh — shared cross-agent debate protocol engine.
#
# One markdown file is the shared channel between two agents (e.g. Claude Code
# and Codex). Each agent appends fenced blocks and polls for the other's reply.
# Format: human-readable markdown with HTML-comment delimiters (parseable + diff-able).
#
# Commands:
#   init   <topic> <me> <peer>        create the debate file (idempotent); caller becomes initiator
#   post   <topic> <me> [body|-]      append a message from <me> (body from arg or stdin via -)
#   ask    <topic> <me> [body|-]      ask the USER a question; pauses both agents
#   answer <topic> [body|-]           record the user's answer to the latest open question
#   decide <topic> <me> [body|-]      record the final agreed decision; ends the debate
#   wait   <topic> <me>               block until it's <me>'s turn / user is needed / converged
#   turn   <topic> <me>               print whose turn it is (no blocking)
#   status <topic>                    print machine-readable state line
#   show   <topic>                    print the whole debate file
#   path   <topic>                    print the resolved file path
#
# wait exit codes:  0 = your turn   20 = user input needed   30 = converged (decision posted)
#                   10 = timed out (only if AGENT_DEBATE_TIMEOUT > 0)
#
# Env: AGENT_DEBATE_DIR (default ~/.agent-debates)
#      AGENT_DEBATE_INTERVAL (poll seconds, default 180 = 3 min)
#      AGENT_DEBATE_TIMEOUT  (max wait seconds, 0 = forever, default 0)

set -euo pipefail

DEBATE_DIR="${AGENT_DEBATE_DIR:-$HOME/.agent-debates}"
INTERVAL="${AGENT_DEBATE_INTERVAL:-180}"
TIMEOUT="${AGENT_DEBATE_TIMEOUT:-0}"

err()  { printf '%s\n' "$*" >&2; }
die()  { err "debate: $*"; exit 2; }
now()  { date -u +%Y-%m-%dT%H:%M:%SZ; }

slug() {
  printf '%s' "$1" | tr '[:upper:]' '[:lower:]' \
    | sed -E 's/[^a-z0-9]+/-/g; s/^-+//; s/-+$//' | cut -c1-60
}

file_for() {
  case "$1" in
    /*|./*|../*|*/*) printf '%s' "$1" ;;
    *.md)           printf '%s/%s' "$DEBATE_DIR" "$1" ;;
    *)              printf '%s/%s.md' "$DEBATE_DIR" "$(slug "$1")" ;;
  esac
}

# body: use $1 if non-empty and not "-", else read stdin.
read_body() {
  if [ "${1:-}" = "-" ] || [ -z "${1:-}" ]; then cat; else printf '%s' "$1"; fi
}

lock() {
  local f="$1" n=0
  until mkdir "$f.lock" 2>/dev/null; do
    n=$((n+1)); [ "$n" -gt 200 ] && die "could not lock $f"
    sleep 0.2
  done
}
unlock() { rmdir "$1.lock" 2>/dev/null || true; }

attr() { grep -oE "$2=[^ >]+" <<<"$1" | head -1 | cut -d= -f2-; }

# ---- state queries -------------------------------------------------------
last_msg_from()     { grep '^<!--MSG '     "$1" 2>/dev/null | tail -1 | grep -oE 'from=[^ >]+' | cut -d= -f2; }
last_summary_from() { grep '^<!--SUMMARY ' "$1" 2>/dev/null | tail -1 | grep -oE 'from=[^ >]+' | cut -d= -f2; }
last_block_type() { grep -nE '^<!--(MSG|ASK|ANSWER|DECISION|SUMMARY|ACCEPT) ' "$1" 2>/dev/null | tail -1 | sed -E 's/.*<!--([A-Z]+) .*/\1/'; }
# Converged only while an ACCEPT or DECISION is the LAST block. Posting after it
# reopens the debate, so a finished thread can be resumed by continuing the file.
is_converged() { case "$(last_block_type "$1")" in DECISION|ACCEPT) return 0 ;; *) return 1 ;; esac; }
initiator()     { grep -m1 '^initiator:' "$1" 2>/dev/null | sed -E 's/^initiator:[[:space:]]*//'; }
participants()  { grep -m1 '^participants:' "$1" 2>/dev/null | sed -E 's/^participants:[[:space:]]*//'; }

peer_of() {
  local me="$1" p; p="$(participants "$2")"
  local a="${p%%,*}" b="${p##*,}"
  if [ "$me" = "$a" ]; then printf '%s' "$b"; else printf '%s' "$a"; fi
}

# true (0) if the last block is properly closed (or the file has no blocks).
# Guards against acting on a peer block that is still being written.
block_complete() {
  local f="$1" lo lc
  lo=$(grep -nE '^<!--(MSG|ASK|ANSWER|DECISION|SUMMARY|ACCEPT) ' "$f" 2>/dev/null | tail -1 | cut -d: -f1)
  [ -z "$lo" ] && return 0
  lc=$(grep -nE '^<!--/(MSG|ASK|ANSWER|DECISION|SUMMARY|ACCEPT)-->' "$f" 2>/dev/null | tail -1 | cut -d: -f1)
  [ -n "$lc" ] && [ "$lc" -gt "$lo" ]
}

# print the body of the LAST block of a given type (no markers). $1=file $2=TYPE
extract_last_block() {
  awk -v t="$2" '
    $0 ~ ("^<!--" t "( |-->)")   { cap=1; buf=""; next }
    cap && $0 ~ ("^<!--/" t "-->") { cap=0; last=buf; next }
    cap                         { buf = buf $0 "\n" }
    END                         { printf "%s", last }
  ' "$1"
}

# id of the latest ASK that has no matching ANSWER, else empty.
open_ask_id() {
  local f="$1" asks answered id open=""
  asks=$(grep '^<!--ASK ' "$f" 2>/dev/null | grep -oE 'id=[^ >]+' | cut -d= -f2 || true)
  answered=$(grep '^<!--ANSWER ' "$f" 2>/dev/null | grep -oE 'to=[^ >]+' | cut -d= -f2 || true)
  for id in $asks; do
    grep -qx "$id" <<<"$answered" || open="$id"
  done
  printf '%s' "$open"
}

# Whose turn: peer of last MSG author; if no MSG yet, the initiator.
whose_turn() {
  local f="$1" lf; lf="$(last_msg_from "$f")"
  if [ -z "$lf" ]; then initiator "$f"; else peer_of "$lf" "$f"; fi
}

require_file() { [ -f "$1" ] || die "no debate file at $1 (run: debate.sh init <topic> <me> <peer>)"; }

# ---- commands ------------------------------------------------------------
cmd_init() {
  local topic="$1" me="$2" peer="$3"; shift 3
  local brief=""; [ $# -ge 1 ] && brief="$(read_body "${1:-}")"
  local f; f="$(file_for "$topic")"
  mkdir -p "$(dirname "$f")"
  lock "$f"
  if [ ! -f "$f" ]; then
    {
      printf '# Debate: %s\n\n' "$topic"
      printf '<!--DEBATE\n'
      printf 'participants: %s,%s\n' "$me" "$peer"
      printf 'initiator: %s\n' "$me"
      printf 'created: %s\n' "$(now)"
      printf '%s\n' '-->'
      if [ -n "$brief" ]; then
        printf '\n<!--BRIEF-->\n%s\n%s\n' "$brief" '<!--/BRIEF-->'
      fi
    } > "$f"
  fi
  unlock "$f"
  printf '%s\n' "$f"
}

append_block() {            # open-marker content close-marker -> appends under lock
  local f="$1" open="$2" body="$3" close="$4"
  lock "$f"
  {
    printf '\n%s\n' "$open"
    printf '%s\n' "$body"
    printf '%s\n' "$close"
  } >> "$f"
  unlock "$f"
}

cmd_post() {
  local topic="$1" me="$2"; shift 2; local f; f="$(file_for "$topic")"
  require_file "$f"
  local body; body="$(read_body "${1:-}")"
  append_block "$f" "<!--MSG from=$me ts=$(now)-->" "$body" "<!--/MSG-->"
}

cmd_ask() {
  local topic="$1" me="$2"; shift 2; local f; f="$(file_for "$topic")"
  require_file "$f"
  local body; body="$(read_body "${1:-}")"
  local id="q$(date -u +%Y%m%d%H%M%S)"
  append_block "$f" "<!--ASK from=$me to=user id=$id ts=$(now)-->" "$body" "<!--/ASK-->"
  printf '%s\n' "$id"
}

cmd_answer() {
  local topic="$1"; shift; local f; f="$(file_for "$topic")"
  require_file "$f"
  local body; body="$(read_body "${1:-}")"
  local id; id="$(open_ask_id "$f")"
  [ -z "$id" ] && die "no open question to answer"
  append_block "$f" "<!--ANSWER to=$id from=user ts=$(now)-->" "$body" "<!--/ANSWER-->"
  printf '%s\n' "$id"
}

cmd_decide() {
  local topic="$1" me="$2"; shift 2; local f; f="$(file_for "$topic")"
  require_file "$f"
  local body; body="$(read_body "${1:-}")"
  append_block "$f" "<!--DECISION by=$me ts=$(now)-->" "$body" "<!--/DECISION-->"
}

# Propose (or revise) the conclusion. Passes the turn to the peer to review.
cmd_summarize() {
  local topic="$1" me="$2"; shift 2; local f; f="$(file_for "$topic")"
  require_file "$f"
  local body; body="$(read_body "${1:-}")"
  append_block "$f" "<!--SUMMARY from=$me ts=$(now)-->" "$body" "<!--/SUMMARY-->"
}

# Sign off on the peer's latest summary -> converges the debate.
cmd_accept() {
  local topic="$1" me="$2"; shift 2; local f; f="$(file_for "$topic")"
  require_file "$f"
  [ "$(last_block_type "$f")" = "SUMMARY" ] || die "nothing to accept: last block is not a summary"
  local body=""; [ $# -ge 1 ] && body="$(read_body "${1:-}")"
  [ -z "$body" ] && body="Summary reviewed and accepted."
  append_block "$f" "<!--ACCEPT from=$me ts=$(now)-->" "$body" "<!--/ACCEPT-->"
}

# Emit a clean standalone document from the accepted conclusion (no markers).
cmd_doc() {
  local f; f="$(file_for "$1")"; require_file "$f"
  local title brief summary acc
  title="$(sed -n 's/^# Debate: //p' "$f" | head -1)"
  brief="$(extract_last_block "$f" BRIEF)"
  summary="$(extract_last_block "$f" SUMMARY)"
  [ -z "$summary" ] && summary="$(extract_last_block "$f" DECISION)"
  acc="$(grep '^<!--ACCEPT ' "$f" 2>/dev/null | tail -1 | grep -oE 'from=[^ >]+' | cut -d= -f2)"
  printf '# %s\n\n' "${title:-Debate}"
  [ -n "$brief" ]   && printf '## Brief\n\n%s\n\n' "$brief"
  printf '## Conclusion\n\n%s\n' "${summary:-(no summary recorded)}"
  [ -n "$acc" ]     && printf '\n_Reviewed and accepted by %s._\n' "$acc"
}

cmd_status() {
  local f; f="$(file_for "$1")"; require_file "$f"
  local st="open" oid; oid="$(open_ask_id "$f")"
  if is_converged "$f"; then st="converged"; elif [ -n "$oid" ]; then st="awaiting-user"; fi
  printf 'status=%s turn=%s last_msg_from=%s open_ask=%s file=%s\n' \
    "$st" "$(whose_turn "$f")" "$(last_msg_from "$f")" "${oid:-none}" "$f"
}

# state -> exit code for `me`, without sleeping.
state_code() {
  local f="$1" me="$2"
  if is_converged "$f"; then return 30; fi          # 30 = accepted/decided -> stop
  if [ -n "$(open_ask_id "$f")" ]; then return 20; fi # 20 = user input needed
  block_complete "$f" || return 1                    # peer still writing -> wait
  if [ "$(last_block_type "$f")" = "SUMMARY" ]; then
    [ "$(last_summary_from "$f")" != "$me" ] && return 40  # peer drafted a summary; review it
    return 1                                          # my own draft; peer is reviewing
  fi
  if [ "$(whose_turn "$f")" = "$me" ]; then return 0; fi # 0 = your turn
  return 1                                            # 1 = keep waiting
}

cmd_turn() {
  local f; f="$(file_for "$1")"; require_file "$f"
  state_code "$f" "$2" && { echo "your-turn"; return 0; }
  case $? in
    20) echo "user-needed";   return 20 ;;
    30) echo "converged";     return 30 ;;
    40) echo "review-summary"; return 40 ;;
    *)  echo "peer-turn";     return 1  ;;
  esac
}

cmd_wait() {
  local f; f="$(file_for "$1")"; require_file "$f"; local me="$2"
  local waited=0 rc
  while true; do
    set +e; state_code "$f" "$me"; rc=$?; set -e
    case $rc in
      0)  err "[debate] your turn.";              cmd_show "$1"; return 0  ;;
      20) err "[debate] user input needed.";      cmd_show "$1"; return 20 ;;
      30) err "[debate] converged.";              cmd_show "$1"; return 30 ;;
      40) err "[debate] review peer's summary.";  cmd_show "$1"; return 40 ;;
    esac
    if [ "$TIMEOUT" -gt 0 ] && [ "$waited" -ge "$TIMEOUT" ]; then
      err "[debate] timed out after ${waited}s waiting for peer."; return 10
    fi
    sleep "$INTERVAL"; waited=$((waited+INTERVAL))
  done
}

cmd_show() { local f; f="$(file_for "$1")"; require_file "$f"; cat "$f"; }
cmd_path() { file_for "$1"; }
cmd_latest() { ls -t "$DEBATE_DIR"/*.md 2>/dev/null | head -1 || true; }
cmd_list()   { ls -t "$DEBATE_DIR"/*.md 2>/dev/null || true; }

main() {
  [ $# -ge 1 ] || die "usage: debate.sh <init|post|ask|answer|decide|wait|turn|status|show|path> ..."
  local cmd="$1"; shift
  case "$cmd" in
    init)   [ $# -ge 3 ] || die "init <topic> <me> <peer>";  cmd_init   "$@" ;;
    post)   [ $# -ge 2 ] || die "post <topic> <me> [body|-]"; cmd_post   "$@" ;;
    ask)    [ $# -ge 2 ] || die "ask <topic> <me> [body|-]";  cmd_ask    "$@" ;;
    answer) [ $# -ge 1 ] || die "answer <topic> [body|-]";    cmd_answer "$@" ;;
    decide)    [ $# -ge 2 ] || die "decide <topic> <me> [body|-]";    cmd_decide    "$@" ;;
    summarize) [ $# -ge 2 ] || die "summarize <topic> <me> [body|-]"; cmd_summarize "$@" ;;
    accept)    [ $# -ge 2 ] || die "accept <topic> <me> [body|-]";    cmd_accept    "$@" ;;
    doc)       [ $# -ge 1 ] || die "doc <topic>";                     cmd_doc       "$@" ;;
    wait)   [ $# -ge 2 ] || die "wait <topic> <me>";          cmd_wait   "$@" ;;
    turn)   [ $# -ge 2 ] || die "turn <topic> <me>";          cmd_turn   "$@" ;;
    status) [ $# -ge 1 ] || die "status <topic>";             cmd_status "$@" ;;
    show)   [ $# -ge 1 ] || die "show <topic>";               cmd_show   "$@" ;;
    path)   [ $# -ge 1 ] || die "path <topic>";               cmd_path   "$@" ;;
    latest) cmd_latest ;;
    list)   cmd_list ;;
    *)      die "unknown command: $cmd" ;;
  esac
}
main "$@"
