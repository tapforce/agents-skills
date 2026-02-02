---
name: pl-consistent-project-moon-yaml
description: Consistent each project (application | package) need define file `moon.yaml`.
tags:
  - pl
  - consistent
  - moon-yaml
---

With each project (application | package), need define file `moon.yaml` with basic information.

File location: `<project>/moon.yml`

**CRITICAL**: When defining tasks that forward to package.json scripts, ALWAYS use `pnpm run [script-name]` format.

**Correct**:
```yaml
tasks:
  dev:
    command: "pnpm run dev"
  build:
    command: "pnpm run build"
```

**Incorrect**:
```yaml
tasks:
  dev:
    command: "mastra dev"  # WRONG - direct command execution
  build:
    command: "mastra build"  # WRONG - bypasses package.json
```

**Reason**: Using `pnpm run` ensures proper environment setup, dependency resolution, and consistency with package.json scripts. Direct commands bypass pnpm's package management and can cause dependency issues.

**Example:**

```yaml
layer: "tool"
language: "typescript"

project:
  name: "moon"
  description: "A repo management tool."
  channel: "#moon"
  owner: "infra.platform"
  maintainers: ["miles.johnson"]

tasks:
  build:
    command: "pnpm run build" # ALWAYS use "pnpm run [script-name]" to forward from package.json scripts
```
