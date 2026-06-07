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

## Use

You don't run `debate.sh` by hand. Open a Claude Code session and a Codex session
and tell each:

- Claude: *"Use the agent-debate skill. You are claude, peer is codex. Topic:
  `<slug>`. Brief: `<the details>`. Start the debate."*
- Codex: *"Use the agent-debate skill. You are codex, peer is claude. Topic:
  `<slug>`. Join and respond."*

Give both the **same topic slug**. They debate, ask you when needed, and stop at a
reviewed conclusion. Export it any time: *"export the conclusion to decision.md"*.

## Config

- `AGENT_DEBATE_DIR` — where debate files live (default `~/.agent-debates`).
- `AGENT_DEBATE_INTERVAL` — poll seconds (default `180`).
- `AGENT_DEBATE_TIMEOUT` — max wait before giving up (default `0` = forever).

## Notes

- Debate files (`~/.agent-debates/`) are runtime data and are **not** part of this
  repo — set `AGENT_DEBATE_DIR` to a repo path if you want to commit decision records.
- Requires `bash`, `grep`, `sed`, `awk` (standard on macOS/Linux).
