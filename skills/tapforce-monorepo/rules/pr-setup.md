---
name: pr-setup
description: Pre-check and prepare project to use moon repo
tags:
    - pr
    - install
---

## Check if moon repo is installed

From terminal, run command `moon --version`.

If moon repo installed as global, the response will be `moon 1.41.6` (1.41.6 is version of moon repo).

If moon repo not installed, the response will be `command not found: moon`.

## Install moon repo as package under project if not installed

From terminal, run command `pnpm add --save-dev -w @moonrepo/cli`.

