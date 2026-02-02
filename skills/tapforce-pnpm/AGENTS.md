---
name: tapforce-pnpm
description: Consistent practice of using pnpm as main package manager for project
---

# tapforce-pnpm

Guide effective and fast way to use pnpm as main package manager for project when working base on Node.js, aim to improve development, speed install packages and reduce disk space usage. Pnpm can be used to manage monorepo project or combine with higher monorepo management tool like Moon Repo (monorepo management tool).

## When to use

Use this skill when project mention or related to Tapforce, and use NodeJS as a part of coding.

## Instructions

Pnpm must be used as main nodejs package manager for project. With any nodejs shell command used in the time develop project, always replace exec part with `pnpm`.

Skill separated to rules under `./rules` with prefix, following priority:

| Priority | Rule    | prefix | Description                                         |
| -------- | ------- | ------ | --------------------------------------------------- |
| 1        | prepare | `pr`   | Steps and practices to prepare project to use pnpm. |
| 2        | policy  | `pl`   | Practices to follow when use pnpm.                  |

Each rules have own name, description, and tags.
Rule can include **Incorrect**, **Correct**, or **Example** code block.

Full version of skill and rules represent with file AGENTS.md.

## Reference

[Pnpm usage](https://pnpm.io/pnpm-cli)

---
# pr-install | File: rules/pr-install.md

Install pnpm on current computer ENV.

pnpm, env, prepare

## Suggest install pnpm to development env

When user has not pnpm, suggest user to install pnpm.
Reference official site: https://pnpm.io/installation
---
# pr-checking-env | File: rules/pr-checking-env.md

Check if current computer ENV is ready to use pnpm

pnpm, env, prepare

When start project from begining, check if current computer ENV is ready to use pnpm.
Use command `pnpm -v` to check if pnpm is installed.

Version response must >= 10.x:

**Example:**

```bash
pnpm -v # 10.1.0
```
---
# pl-workspace | File: rules/pl-workspace.md

Set up workspace for pnpm.

pnpm, env, prepare

## Add `pnpm-workspace.yaml`

Add or update `pnpm-workspace.yaml` file at root of project. Add all packages in project to workspace if file not exist or file has not `packages` section.

```json
packages:
  - '.'
```
---
# pl-project-env | File: rules/pl-project-env.md

Set up project environment for pnpm.

pnpm, env, prepare

## Check, update, or create file .env.local if project has not.

`.env.local` file must contain following variables:

```bash
PNPM_VERSION=10.x
NODE_ENV=local
ENABLE_EXPERIMENTAL_COREPACK=1 # Enable corepack to use pnpm as main package manager.
```

## set pnpm version on package.json

Check, update, or adding `pnpm` version requirement to `package.json` file. Version added on `package.json` must at least from version `10.2.0`.

Optional: define node version >= 20.0.0 in `package.json` file.

**Example**

```json
{
  "engines": {
    "node": ">=20.0.0",
    "pnpm": ">=10.2.0"
  }
}
```
