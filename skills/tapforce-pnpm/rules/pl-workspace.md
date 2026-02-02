---
name: pl-workspace
description: Set up workspace for pnpm.
tags:
  - pnpm
  - env
  - prepare
---

## Add `pnpm-workspace.yaml`

**CRITICAL**: Always create `pnpm-workspace.yaml` file at root of monorepo project. This file is REQUIRED even when workspaces are defined in package.json.

For monorepo projects, include all workspace directories:

```yaml
packages:
  - "apps/*"
  - "packages/*" 
  - "tools/*"
```

For single package projects:

```yaml
packages:
  - '.'
```

**Common mistake**: Do NOT rely only on package.json workspaces field - pnpm-workspace.yaml is the authoritative configuration.