---
name: pr-consistent-manager
description: Use pnpm as main package manager for project.
tags:
  - pnpm
  - env
  - prepare
---

When pnpm is installed and correct version requirement, force all command used in flow from now on to use pnpm. When meet any command related to npm like install package, update package, run script, etc. Always replace other package manager with pnpm.