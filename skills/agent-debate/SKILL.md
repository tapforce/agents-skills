---
name: agent-debate
description: Debate and reach a decision with another AI agent (e.g. Claude Code <-> Codex) over one shared markdown file. Use when the user asks two agents to discuss, debate, cross-check, or jointly decide a topic, when the user says "talk to the other agent / Codex / Claude about X", or hands you a name and a topic to debate. Agents take turns, poll every ~3 minutes, and pause to ask the user when stuck.
---

# Agent Debate

Two agents hold a structured debate by appending to **one shared markdown file**.
You write your turn, then poll until the other agent replies. When you genuinely
need a human decision, you ask the user and *both* agents pause until they answer.

The engine that handles the file, locking, turn-taking, and polling is
`debate.sh` next to this file. **Always go through it** — never hand-edit the
debate file (concurrent edits corrupt it; the script locks).

```
SKILL_DIR="$(dirname "$(readlink -f ~/.claude/skills/agent-debate 2>/dev/null || echo ~/.agents/skills/agent-debate)")/agent-debate"
# Simpler: the script lives beside this SKILL.md. Resolve it once:
D="$HOME/.agents/skills/agent-debate/debate.sh"
```

## Your identity

The user gives you **your name**, the **peer's name**, and a **topic**
(default names: `claude` and `codex`). If the user only gives a topic, assume
you are `claude` (Claude Code) or `codex` (Codex) per whichever tool you are,
and the peer is the other.

## Topic vs. brief — IMPORTANT

The **topic** is a *short slug* (a few words) — it becomes the shared filename,
so keep it short and stable. Both agents MUST pass the **same topic** so they
land on the same file (e.g. `modal-vs-selfhost`).

The actual subject — the paragraph of detail, requirements, constraints — is the
**brief**, written *into* the file at `init` time, not the filename. The agent
the user told to start passes it:

```bash
"$D" init "<short-topic>" <me> <peer> -   <<'EOF'
<the full paragraph(s): what we're deciding, context, constraints, success criteria>
EOF
```

If the user hands you a long paragraph, distill a short topic slug from it and
put the paragraph in the brief. The joining agent just runs
`"$D" init "<short-topic>" <me> <peer>` (no brief) and reads it via `show`.

## Protocol (follow in order)

1. **Open the channel.** Create (or join) the file (idempotent; first caller is
   the initiator):
   - If you are the one the user told to *start*, init **with the brief**, then
     `show` to confirm, then post your opening position:
     ```bash
     "$D" init "<short-topic>" <me> <peer> -   <<'EOF'
     <the full brief: what we're deciding, context, constraints>
     EOF
     "$D" post "<short-topic>" <me> -   <<'EOF'
     <your opening argument>
     EOF
     ```
   - If you are *joining*, init without a brief, read the brief, then go to **wait**:
     ```bash
     "$D" init "<short-topic>" <me> <peer>
     "$D" show "<short-topic>"     # read the brief + any messages so far
     ```

2. **Wait for your turn.** Block until it's your turn / a human is needed / it's done:
   ```bash
   "$D" wait "<topic>" <me>
   ```
   - **Claude Code:** run this with `run_in_background: true`. The harness
     re-invokes you when it exits — don't block the foreground (`sleep` is
     blocked there anyway). It polls every 3 min internally.
   - **Codex:** run it as a normal blocking shell command. It sleeps internally
     and returns when there's something to do.
   - Exit code tells you what happened: **0** = your turn (peer replied),
     **20** = a question for the user is open, **30** = converged/done,
     **40** = peer posted a draft summary for you to review.
     `wait` also prints the full debate so you have fresh context.

3. **Act on the result:**
   - **Your turn (0):** Read the peer's latest argument. Think hard, look at the
     actual code/files if relevant, then respond — agree, refute, refine, or
     propose. Be a real debater: concede good points, push back on weak ones,
     converge toward the *correct* answer, not just a fast one.
     ```bash
     "$D" post "<topic>" <me> -   <<'EOF'
     <your response>
     EOF
     ```
     Then go back to step 2 (**wait**).
   - **User needed (20):** A question for the human is open. **Surface it to the
     user verbatim** (it's in the printed file under an `ASK` block) and stop to
     wait for their reply. When the user answers you, record it:
     ```bash
     "$D" answer "<topic>" -   <<'EOF'
     <what the user said>
     EOF
     ```
     Then go back to step 2 (**wait**). Both agents see the answer and resume.
   - **Review summary (40):** The peer posted a draft `SUMMARY` (the proposed
     conclusion). **Review it critically** against the whole debate: is anything
     missing, mis-stated, or unsupported? List concrete gaps.
     - Gaps found → `post` them (turn returns to the summarizer to revise).
     - It's complete and correct → `accept` it (this converges the debate):
       ```bash
       "$D" accept "<topic>" <me> -m "Reviewed — complete and accurate."
       ```
     Then continue: after gaps you go to **wait**; after `accept` you STOP.
   - **Converged (30):** An `ACCEPT` (or `DECISION`) is the last block. Summarize
     the outcome to the user and **STOP**. Do **not** start another `wait`, do
     not loop, do not keep polling. The debate is over until the user explicitly
     tells you to resume it (see "Stopping & resuming").
     - If the user wants the conclusion as a file: `"$D" doc "<topic>"` prints a
       clean standalone document (brief + accepted conclusion); redirect it where
       they want, e.g. `"$D" doc "<topic>" > decision.md`.

4. **When YOU need the human** (irreconcilable disagreement, missing requirement,
   a values/priorities call only the user can make) — instead of posting a
   message, ask the user:
   ```bash
   "$D" ask "<topic>" <me> -   <<'EOF'
   <a crisp question, with the options and the trade-off>
   EOF
   ```
   Surface the same question to your user, then go to step 2 (**wait**). Both
   agents pause on `awaiting-user` until someone records the answer.

5. **Concluding.** Two ways, depending on how formal the outcome needs to be:

   **(a) Quick decision** — for a simple agreed call. The agent whose turn it is:
   ```bash
   "$D" decide "<topic>" <me> -m "<the agreed decision + one line of rationale>"
   ```

   **(b) Reviewed summary (recommended for anything you'll act on)** — the
   conclusion gets peer-reviewed before it's final:
   - The agent whose turn it is when consensus is reached **writes the draft
     summary** (this is the "who summarizes" rule — the proposer summarizes):
     ```bash
     "$D" summarize "<topic>" <me> -   <<'EOF'
     <the full conclusion: what was decided, why, key trade-offs, follow-ups>
     EOF
     ```
   - Go to **wait**. The peer gets code 40, reviews, and either sends gaps back
     (you revise with another `summarize`) or `accept`s it.
   - On `accept` the debate converges. Both agents STOP. `"$D" doc "<topic>"`
     turns the accepted summary into a clean document on demand.

   After concluding (either way), summarize to the user and stop — do not `wait`
   again. The peer's `wait` returns 30 and it stops too.

## Stopping & resuming

- **Finishing means stopping.** When the debate converges (a `DECISION` is the
  last block) both agents summarize and stop. Neither agent re-arms `wait` or
  keeps polling. Stay stopped until the user says otherwise — do not resume on
  your own.
- **Resuming later.** Only when the user explicitly asks to continue a previous
  debate, re-open the **same file** and pick up where it left off:
  ```bash
  "$D" latest                 # or use the topic the user names
  "$D" show "<topic>"         # re-read the full history incl. the decision
  "$D" post "<topic>" <me> -  <<'EOF'
  Reopening per the user: <what they want to revisit / new info>.
  EOF
  ```
  Posting after a `DECISION` reopens the thread (the decision is no longer the
  last block), and normal turn-taking resumes. The user must re-engage the peer
  too — don't assume the other agent is still listening after a finished debate.

## Rules of engagement

- **One turn at a time.** Only `post` when `wait` says it's your turn. The engine
  enforces turn order (turn = the agent who didn't write the last message), so
  trust it rather than posting twice.
- **Don't end the debate unilaterally.** Use `decide` only when there's genuine
  agreement or the user has settled it. If you think you're done but the peer
  hasn't agreed, `post` "I propose we conclude with X — agree?" and wait.
- **Ask the user sparingly but decisively.** Debate the things you can reason
  about. Escalate (`ask`) only for genuine human calls. When you do, make the
  question and trade-offs concrete.
- **Stay grounded.** This is a real working session — read the files, run the
  checks, cite specifics. Don't debate in the abstract when you can verify.
- **Keep going until resolved.** Don't drop the thread after one exchange; loop
  wait → act → wait until `decide` (30) or the user stops you.

## Inspecting state (optional)

```bash
"$D" status "<topic>"   # status= turn= last_msg_from= open_ask= file=
"$D" turn   "<topic>" <me>
"$D" show   "<topic>"   # print the whole debate
"$D" path   "<topic>"   # the resolved file path (under ~/.agent-debates/)
"$D" latest             # most recently created debate file (joiner shortcut)
"$D" list               # all debate files, newest first
"$D" doc    "<topic>"   # clean standalone document from the accepted conclusion
```

If the user starts the *other* agent and doesn't repeat the topic to you, you can
find the active debate with `"$D" latest` and derive the topic from its filename
(strip the dir and `.md`). Prefer an explicit topic when the user gives one.

## File format (for reference — don't edit by hand)

```markdown
# Debate: <topic>

<!--DEBATE
participants: architect,reviewer
initiator: architect
created: 2026-06-07T10:00:00Z
-->

<!--BRIEF-->
Decide whether datalabs runs lessons on Modal or self-hosted. Constraints:
budget < $X/mo, cold-start < 3s, must keep CSP/allow_root setup. Success =
cheaper at our scale without losing isolation.
<!--/BRIEF-->

<!--MSG from=architect ts=2026-06-07T10:00:00Z-->
I think we should use approach A because ...
<!--/MSG-->

<!--MSG from=reviewer ts=2026-06-07T10:03:00Z-->
Disagree — approach B handles edge case X ...
<!--/MSG-->

<!--ASK from=architect to=user id=q20260607100500 ts=2026-06-07T10:05:00Z-->
Do we prioritize latency or memory here?
<!--/ASK-->

<!--ANSWER to=q20260607100500 from=user ts=2026-06-07T10:09:00Z-->
Latency.
<!--/ANSWER-->

<!--SUMMARY from=architect ts=2026-06-07T10:12:00Z-->
Decision: approach A, latency-tuned. Rationale, trade-offs, follow-ups ...
<!--/SUMMARY-->

<!--ACCEPT from=reviewer ts=2026-06-07T10:15:00Z-->
Reviewed — complete and accurate.
<!--/ACCEPT-->
```

Block types: `BRIEF` (the subject), `MSG` (a turn), `ASK`/`ANSWER` (human
interjection), `SUMMARY` (proposed conclusion, peer-reviewed), `ACCEPT` (sign-off,
converges), `DECISION` (quick one-line conclusion, converges). The conversation
(`MSG`) and the conclusion (`SUMMARY`/`ACCEPT`) live in the same file as distinct
blocks; `doc` extracts just the conclusion.

## Tuning

- `AGENT_DEBATE_INTERVAL` — poll seconds (default `180` = 3 min).
- `AGENT_DEBATE_TIMEOUT` — max seconds `wait` blocks before returning code 10
  (default `0` = wait forever). Useful to cap Codex foreground waits.
- `AGENT_DEBATE_DIR` — where debate files live (default `~/.agent-debates`).
