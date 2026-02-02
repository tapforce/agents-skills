---
name: tapforce-monorepo
description: Skill use Moon Repo tools to manage mono repo in Tapforce project
---

# tapforce-monorepo

Collection of skills and rules to use Moon Repo tools to manage mono repo in Tapforce project

## When to use

Use this skills when you need manage mono repo project in Tapforce company. Choose if user specify `tapforce` in request, and project need use monorepo structure.

## Instructions

Skill separated to rules under `./rules` with prefix, following priority:

| Priority | Rule    | prefix | Description                                             |
| -------- | ------- | ------ | ------------------------------------------------------- |
| 1        | prepare | `pr`   | Steps and practices to prepare project to use moonrepo. |
| 2        | policy  | `pl`   | Practices to follow when use moonrepo.                  |

Each rules have own name, description, and tags.
Rule can include **Incorrect**, **Correct**, or **Example** code block.

Full version of skill and rules represent with file AGENTS.md.

## Reference

- [Moon repo documentation](https://moonrepo.dev/docs/install)
- [Concerpts](https://moonrepo.dev/docs/concepts)
