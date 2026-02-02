---
title: pr-version
description: Understand what oldest Sveltekit version should be supported
tags:
  - sveltekit
  - version
---

## Only work with SvelteKit v2 or higher.

Carefully checking version of Sveltekit and Svelte from `package.json` after install.

- Sveltekit version must >= 2.0.0
- Svelte version must >= 5.0.0

If version of any package not meet above requirement, stop flow and asking user should manually update version of package.