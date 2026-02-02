---
name: pr-init
description: Practice to init moon repo in project
tags:
  - pr
  - init
---

## 1. Init project

Check project root, if not exist folder `.moon`, run command `pnpm moon init`.

Referece: [Setup workspace](https://moonrepo.dev/docs/setup-workspace)

## 2. Check and create missing folder `apps` and `packages`

Check project root, if not exist folder `apps` and `packages`, create them.

Referece: [Setup workspace](https://moonrepo.dev/docs/setup-workspace)


## 3. ALWAYS run `pnpm moon setup` after creating new applications or packages

**CRITICAL:** After creating any new application (under `apps/`) or package (under `packages/`), you MUST run `pnpm moon setup` to:
- Register the new project in MoonRepo's workspace
- Generate necessary configuration files
- Ensure proper task mapping

Run `pnpm moon setup` and `pnpm moon init` each time modify, add, remove applications or packages.