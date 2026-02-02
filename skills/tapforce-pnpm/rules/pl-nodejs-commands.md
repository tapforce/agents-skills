---
name: pl-nodejs-commands
description: Always use pnpm for any Node.js related commands
tags:
  - pnpm
  - commands
  - nodejs
  - policy
---

# Use pnpm for All Node.js Commands

**CRITICAL**: With any Node.js shell command used during project development, ALWAYS replace execution part with `pnpm`.

## Incorrect

```bash
# NEVER use npx for any commands
npx shadcn-svelte@latest add accordion
npx create-svelte@latest my-app
npx vite build
npm run dev
npm install
```

## Correct

```bash
# ALWAYS use pnpm for all Node.js commands
pnpm dlx shadcn-svelte@latest add accordion
pnpm dlx create-svelte@latest my-app
pnpm run build
pnpm dev
pnpm install
```

## Special Cases

**For CLI tools that have package.json scripts**:
```bash
# Use the script defined in package.json
pnpm shadcn add accordion  # if "shadcn" script exists
```

**For one-time CLI execution**:
```bash
# Use pnpm dlx instead of npx
pnpm dlx shadcn-svelte@latest add accordion
pnpm dlx create-vite@latest my-project
```

**For running packages**:
```bash
# Use pnpm exec instead of npx
pnpm exec typescript --version
```

## Reason

- Ensures consistent package manager usage across the project
- Avoids mixing package managers which can cause dependency conflicts
- Maintains pnpm's efficient disk usage and performance benefits
- Follows Tapforce's standardized development practices
