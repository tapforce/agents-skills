---
name: pnpm-workspace-integration
description: Rule for using workspace:* syntax when linking packages in pnpm workspace projects
tags: [pnpm, workspace, dependencies]
---

**ALWAYS** use `workspace:*` syntax when linking packages to applications as dependencies in pnpm workspace projects. When `pnpm-workspace.yaml` exists and you need to import package A to application B, add the dependency using:

```json
"dependencies": {
    "package-a": "workspace:*"
}
```
