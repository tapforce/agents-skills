---
name: pl-setup-toolchain
description: Set up toolchain configuration for project
tags:
    - pl
    - setup
    - toolchain
---

## 1. Check and create missing file `.moon/toolchains.yml`

Reference: https://moonrepo.dev/docs/setup-toolchain

ALWAYS create this file when setting up MoonRepo - it's required for proper toolchain configuration.

Create or update file `.moon/toolchains.yml`.

**Example:**

```yaml
javascript:
  packageManager: 'yarn'

node: {}

yarn: {}
```