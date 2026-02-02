---
name: pr-install
description: Practice to install moon repo in project
tags:
    - pr
    - install
---

## 1. Project must use pnpm and ready `pnpm-workspace.yaml`

Check codebase, to use moon repo, project must use pnpm and ready `pnpm-workspace.yaml`. and use `pnpm` as default package manager.

If file `pnpm-workspace.yaml` not exist, reference skill `tapforce-pnpm` to install pnpm and create `pnpm-workspace.yaml`.

## 2. Check if moon repo is installed

From terminal, run command `moon --version`.

If moon repo installed as global, the response will be `moon 1.41.6` (1.41.6 is version of moon repo).

If moon repo not installed, the response will be `command not found: moon`.

## 3. Install moon repo as package under project if not installed

From terminal, run command `pnpm add --save-dev -w @moonrepo/cli`.

