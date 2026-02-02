---
name: pl-setup-toolchain
description: Set up toolchain configuration for project
tags:
    - pl
    - setup
    - toolchain
---

## 1. Check and create missing folder `.toolchain`

Reference: https://moonrepo.dev/docs/setup-toolchain

Create or update file `.moon/toolchains.yml`.

**Example:**

```yaml
javascript:
  packageManager: 'yarn'

node: {}

yarn: {}
```