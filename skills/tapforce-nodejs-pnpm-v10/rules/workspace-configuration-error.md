---
name: workspace-configuration-error
description: Mandatory rule for handling pnpm workspace configuration errors
tags: [pnpm, workspace, configuration, error-handling]
---

# MANDATORY: pnpm Workspace Configuration Error Handling

## Rule Statement

**ALWAYS** use `pnpm-workspace.yaml` for pnpm workspace configuration. **NEVER** use package.json workspaces or any alternative methods.

## Error Pattern

When encountering:
```
ERR_PNPM_INVALID_WORKSPACE_CONFIGURATION packages field missing or empty
```

## Required Action

**ONLY** this solution is permitted:

```bash
echo 'packages:\n  - "."' > pnpm-workspace.yaml
cat pnpm-workspace.yaml
```

## Forbidden Actions

- ❌ **NEVER** add `"workspaces": ["."]` to package.json
- ❌ **NEVER** use npm/yarn workspace configuration patterns
- ❌ **NEVER** skip workspace configuration
- ❌ **NEVER** use custom fixes not specified in this skill

## Rationale

- pnpm-workspace.yaml is the native pnpm method
- package.json workspaces are incompatible with pnpm
- Alternative fixes cause dependency resolution failures
- This approach has been validated through testing

## Enforcement

This rule must be applied as a high-priority behavioral bias for all agents using this skill.
