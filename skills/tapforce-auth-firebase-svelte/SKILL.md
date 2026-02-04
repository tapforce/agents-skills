---
name: tapforce-auth-firebase-svelte
description: Practices making authenticate flow use firebase on tapforce Svelte project web
---

# tapforce-auth-firebase-svelte

Comprehesive guide for making authenticate flow for web use firebase sdk on Svelte project.

## When to use

Use this skill when meet any of the following conditions:

- Specify use firebase sdk for authenticate flow on tapforce Svelte project web.
- When project related tapforce.
- When project need login / signup or manage user profile in convenience.

## Instructions

Skill separated to rules under `./rules` with prefix, following priority:

| Priority | Rule    | prefix | Description                                                 |
| -------- | ------- | ------ | ----------------------------------------------------------- |
| 1        | prepare | `pr`   | Steps and practices to prepare project to use firebase sdk. |
| 2        | policy  | `pl`   | Practices to follow when use firebase sdk.                  |

Each rules have own name, description, and tags.
Rule can include **Incorrect**, **Correct**, or **Example** code block.

Full version of skill and rules represent with file AGENTS.md.

## Reference

- [Set up web SDK](https://firebase.google.com/docs/web/setup)
- [Start firebase](https://firebase.google.com/docs/auth/web/start)
- [Start firebase admin](https://firebase.google.com/docs/auth/admin)
