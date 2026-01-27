---
title: Prepare PNPM
description: Make sure user have PNPM installed.
tags: environment, tools, nodejs, pnpm
---

## Check PNPM version

PNPM version must be 10 or higher. Using command `pnpm -v` to check current version.

```bash
pnpm -v
```

Result must response with version 10 or higher.

**Incorrect:**

```bash
v7.30.1
```

**Correct:**

```bash
v10.24.0
```

When current version < 10 then show message suggest install PNPM version 10 or higher.

Example: `PNPM version must be 10 or higher. Please install PNPM version 10 or higher.`

Run command to install or upgrade PNPM if user accept.

Reference to [PNPM official download page](https://pnpm.io/installation) to install or upgrade PNPM.

## Always run command as need with PNPM

Everytime when command choosed use npm prefix like `npm...` or `npx...` then replace with pnpm prefix like `pnpm...` or `pnpx...`.

Example:

```bash
npx sv create my-app
cd my-app
npm run dev
```

change to

```bash
pnpx sv create my-app
cd my-app
pnpm run dev
```
