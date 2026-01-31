---
name: pl-workspace
description: Set up workspace for pnpm.
tags:
  - pnpm
  - env
  - prepare
---

## Add `pnpm-workspace.yaml`

Add or update `pnpm-workspace.yaml` file at root of project. Add all packages in project to workspace if file not exist or file has not `packages` section.

```json
packages:
  - '.'
```