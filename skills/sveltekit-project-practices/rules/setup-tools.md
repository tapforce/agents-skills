---
title: Setup tools
description: Review and suggest setup tools for project development.
tags: setup, tools
---

## Node.js

- Developer machine must install Node.js version 20 or higher.
- use `node -v` to check Node.js version.
- If current version < 20 then show message suggest install Node.js version 20 or higher.
- Reference: https://nodejs.org/en/download

## PNPM

- Developer machine must install PNPM package manager.
- PNPM version must be 10 or higher.
- use `pnpm -v` to check PNPM version.
- If PNPM is not installed then show message suggest install PNPM.
- If PNPM version < 10 then show message suggest upgrade PNPM to version 10 or higher.
- Reference: https://pnpm.io/installation
- Using `pnpm` for all commands related to package management. If command mention about `npm`, `yarn`.. then replace with `pnpm`.

## MoonRepo

- When application required setup following mono-repo structure, developer must install MoonRepo package manager.
- Reference: https://moonrepo.dev/docs/install
- Choose install MoonRepo via `pnpm`: https://moonrepo.dev/docs/install#npm

