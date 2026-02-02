---
name: tapforce-monorepo
description: Practices use Moon Repo tools to manage mono-repo project in Tapforce
---

# tapforce-monorepo

Provide good way and practices to manage and develop mono-repo projects in Tapforce company. This skill prefer use `Moon Repo` as main monorepo management tool.

Information about tool can be found in [Moon Repo documentation](https://moonrepo.dev/docs/install).

## When to use

Use this skill when project mention or related to Tapforce, and required by user or you think project complex enough to use monorepo structure.

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

---
# pr-setup | File: rules/pr-setup.md

Pre-check and prepare project to use moon repo

pr, install

## Check if moon repo is installed

From terminal, run command `moon --version`.

If moon repo installed as global, the response will be `moon 1.41.6` (1.41.6 is version of moon repo).

If moon repo not installed, the response will be `command not found: moon`.

## Install moon repo as package under project if not installed

From terminal, run command `pnpm add --save-dev -w @moonrepo/cli`.
---
# pr-init | File: rules/pr-init.md

Practice to init moon repo in project

pr, init

## 1. Init project

Check project root, if not exist folder `.moon`, run command `pnpm moon init`.

Referece: [Setup workspace](https://moonrepo.dev/docs/setup-workspace)

## 2. Check and create missing folder `apps` and `packages`

Check project root, if not exist folder `apps` and `packages`, create them.

Referece: [Setup workspace](https://moonrepo.dev/docs/setup-workspace)


## 3. Run `pnpm moon setup` and `pnpm moon init` each time modify, add, remove applications or packages.
---
# pl-setup-toolchain | File: rules/pl-setup-toolchain.md

Set up toolchain configuration for project

pl, setup, toolchain

## 1. Check and create missing folder `.toolchain`

Reference: https://moonrepo.dev/docs/setup-toolchain

Create or update file `.moon/toolchains.yml`.

**Example:**

```yaml
javascript:
  packageManager: 'yarn'

node: {}

yarn: {}
```
---
# pl-organize | File: rules/pl-organize.md

Practice to organize applications and packages in project

pl, organize, moonrepo

## 1. Check and create missing folder `apps` and `packages`

Check project root, if not exist folder `apps` and `packages`, create them.

Referece: [Setup workspace](https://moonrepo.dev/docs/setup-workspace)

## 2. Application created under `apps` folder

Application should be created as separate folder under folder `apps`.
The application mapping defined at `.moon/workspace.yml`.

Reference:

- [Workspace define]: https://moonrepo.dev/docs/create-project#declaring-a-project-in-the-workspace

## 3. Package created under `packages` folder

Package should be created as separate folder under folder `packages`.
---
# pl-consistent-project-moon-yaml | File: rules/pl-consistent-project-moon-yaml.md

Consistent each project (application | package) need define file `moon.yaml`.

pl, consistent, moon-yaml

With each project (application | package), need define file `moon.yaml` with basic information.

File location: `<project>/moon.yml`

**Example:**

```yaml
layer: "tool"
language: "typescript"

project:
  name: "moon"
  description: "A repo management tool."
  channel: "#moon"
  owner: "infra.platform"
  maintainers: ["miles.johnson"]

tasks:
  build:
    command: "pnpm run build" # forward from package.json scripts or shell command
```
---
# pl-consistent-moon-pnpm | File: rules/pl-consistent-moon-pnpm.md

Consistent config and map packages between moonrepo and pnpm workspace - pl - consistent - moon-yaml - pnpm - workspace - moon

## link package when need import by package dependency property and moon name

When a package or application (called A) need import another package or application (called B), you need map package B with correct name as dependency in `package.json` of package A.

**Example: package A config**

```json
{
    ...,
    "devDependencies": {
		...,
		"@tapforce/B": "workspace:*"
	},
}
```

Following the example:

- `@tapforce/B` is name of package B in `moon.yaml` and `package.json` of package B
- `workspace:*` no define detail version, use `workspace:*` to make link

Package B `package.json` must contains:

- the `type` property is `module`.
- export files that package A can import when linked.

**Example: package B config**

```json
{
    ...,
    "type": "module",
    "exports": {
        "./dist/*": {
            "types": "./dist/*",
            "default": "./dist/*"
        }
    },
}
```

Following the example:

- `./dist/*` is path of files that package A can import when linked. Can be folder like `dist` , or path to file like `src/index.ts`


Run `pnpm install` each time add, remove or update package in `package.json` of package A or B.
