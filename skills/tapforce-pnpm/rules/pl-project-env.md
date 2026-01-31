---
name: pl-project-env
description: Set up project environment for pnpm.
tags:
  - pnpm
  - env
  - prepare
---

## Check, update, or create file .env.local if project has not.

`.env.local` file must contain following variables:

```bash
PNPM_VERSION=10.x
NODE_ENV=local
ENABLE_EXPERIMENTAL_COREPACK=1 # Enable corepack to use pnpm as main package manager.
```

## set pnpm version on package.json

Check, update, or adding `pnpm` version requirement to `package.json` file. Version added on `package.json` must match with verson installed.

**Example**

```json
{
  "packageManager": "pnpm@10.x"
}
```
