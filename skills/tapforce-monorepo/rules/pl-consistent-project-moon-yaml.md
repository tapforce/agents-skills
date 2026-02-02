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
    command: "pnpm run build" # forward from package.json scripts or shell command
```
