# agent-debate

A shared skill that lets two AI agents (e.g. **Claude Code** and **Codex**) hold
a structured debate over **one markdown file**, take turns, poll every ~3 minutes,
pause to ask the human when stuck, and conclude with a peer-reviewed summary.

- `SKILL.md` — the protocol both agents read (this is the skill).
- `debate.sh` — the engine: locking, turn-taking, polling, summary/review, export.
- `install.sh` — symlinks this repo into Claude Code and Codex skill dirs.

## Install (each machine)

This skill lives in the `tapforce/agents-skills` monorepo under
`skills/agent-debate/`. Clone the repo once, then run this skill's installer:

```bash
git clone https://github.com/tapforce/agents-skills
agents-skills/skills/agent-debate/install.sh
```

`install.sh` symlinks this folder into Claude Code's and Codex's skill dirs. The
files update in place on `git pull` (the skill dirs just point here); only re-run
`install.sh` if you move the clone.

## Use — how to prompt the agents

You don't run `debate.sh` by hand. You talk to the two agents in plain English;
they invoke the skill and drive the script. Open **two sessions** — one Claude
Code, one Codex — and prompt each. Always give both the **same topic slug**.

The topic is a short slug (it becomes the shared filename). The paragraph of
detail goes in the **brief**, which only the starting agent provides.

### 1. Start a debate

**Claude (starter — gives the brief):**
```
Use the agent-debate skill. You are claude, peer is codex.
Topic: modal-vs-selfhost
Brief: Decide whether datalabs lessons run on Modal or self-hosted.
Budget < $200/mo, cold-start < 3s, must keep the CSP/allow_root sandbox.
Start the debate.
```

**Codex (joiner — same topic, no brief needed):**
```
Use the agent-debate skill. You are codex, peer is claude.
Topic: modal-vs-selfhost. Join the debate and respond.
```

> Forgot to pass the topic to the joiner? Just say *"join the latest debate"* and
> it finds it via `debate.sh latest`.

### 2. Answer when they ask you

When the agents need a human call, the question appears in whichever session
asked it. Just reply in plain English in that session — the agent records your
answer and both resume:
```
Latency matters more than memory here.
```

### 3. Let them conclude

They converge on a peer-reviewed summary and stop on their own. To nudge:
```
If you two agree, write the summary and have codex review it.
```

### 4. Export the decision as a file
```
Export the agent-debate conclusion for topic modal-vs-selfhost to docs/decision.md
```

### 5. Resume a finished debate later

A finished debate stops cleanly, so re-engage **both** agents on the same topic:

**Claude:**
```
Resume the agent-debate on topic modal-vs-selfhost — new cost data changed
things. Reopen it and continue.
```
**Codex:**
```
Resume the agent-debate on topic modal-vs-selfhost and continue.
```

### Custom names

Default identities are `claude` and `codex`, but you can name them per debate
(e.g. roles). Give each agent **its own** name and the **peer's** name:
```
Use the agent-debate skill. You are architect, peer is reviewer.
Topic: cache-strategy. Brief: ... Start the debate.
```
(Tell the other session: *"You are reviewer, peer is architect. Topic:
cache-strategy. Join."*)

### Tips
- Same **topic slug** on both sides — that's how they meet on one file.
- Keep both sessions open while a debate is active; a turn only happens while
  that agent's session is running.
- They pause for you only on genuine human calls; routine reasoning they settle
  between themselves.

## Config

- `AGENT_DEBATE_DIR` — where debate files live (default `~/.agent-debates`).
- `AGENT_DEBATE_INTERVAL` — poll seconds (default `180`).
- `AGENT_DEBATE_TIMEOUT` — max wait before giving up (default `0` = forever).

## Notes

- Debate files (`~/.agent-debates/`) are runtime data and are **not** part of this
  repo — set `AGENT_DEBATE_DIR` to a repo path if you want to commit decision records.
- Requires `bash`, `grep`, `sed`, `awk` (standard on macOS/Linux).
