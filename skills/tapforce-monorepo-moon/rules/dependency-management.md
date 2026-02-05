---
name: dependency-management
description: Rule for running install and setup commands after dependency changes
tags: [dependencies, install, setup]
---

**ALWAYS** run `pnpm install` and `pnpm moon setup` every time you change dependencies of any application or package in the monorepo.
