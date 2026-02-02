---
name: tapforce-pnpm
description: Consistent practice of using pnpm as main package manager for project
---

# tapforce-pnpm

Guide effective and fast way to use pnpm as main package manager for project when working base on Node.js, aim to improve development, speed install packages and reduce disk space usage. Pnpm can be used to manage monorepo project or combine with higher monorepo management tool like Moon Repo.

## When to use

Use this skill when user tell `tapforce` word, and request use pnpm, or when project need use monorepo style to manage codebase.

## Instructions

Skill separated to rules under `./rules` with prefix, following priority:

| Priority | Rule    | prefix | Description                                         |
| -------- | ------- | ------ | --------------------------------------------------- |
| 1        | prepare | `pr`   | Steps and practices to prepare project to use pnpm. |
| 2        | policy  | `pl`   | Practices to follow when use pnpm.                  |

Each rules have own name, description, and tags.
Rule can include **Incorrect**, **Correct**, or **Example** code block.

Full version of skill and rules represent with file AGENTS.md.
