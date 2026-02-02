---
name: pr-setup
description: Steps and practices to prepare project to use Mastra.AI.
tags:
  - setup
---

## Support base framworks

Mastra support install into existing project with 

- Next.js
- React
- SvelteKit
- Astro
- Nuxt
- Express
- Hono

## Prefer monorepo setup

If project is new or empty (not install any framework before), we prefer to use monorepo setup with pnpm workspace.

In monorepo setup, the Mastra project will be `application`, NOT `package`.

## Create new Mastra application

**For new projects in monorepo**: ALWAYS use `pnpm create mastra@latest [app-name]`

**Correct Process**:
```bash
# Navigate to apps directory
cd apps/

# Create new Mastra application
pnpm create mastra@latest [app-name]

# The CLI will handle:
# - Interactive setup (provider selection, API key)
# - Dependency installation
# - Project structure creation
# - Mastra CLI installation
```

**Incorrect**: Manual npm init, manual dependency installation, or manual file creation.

**Reason**: The Mastra CLI handles complex setup including provider configuration, environment setup, and proper project structure that manual setup cannot replicate.

## Install to exist project

If project is not empty and installed one of base frameworks, install mastra following correct guideline from official site.

- [Next.js](https://mastra.ai/guides/getting-started/next-js)
- [React](https://mastra.ai/guides/getting-started/vite-react)
- [SvelteKit](https://mastra.ai/guides/getting-started/sveltekit)
- [Astro](https://mastra.ai/guides/getting-started/astro)
- [Nuxt](https://mastra.ai/guides/getting-started/nuxt)
- [Express](https://mastra.ai/guides/getting-started/express)
- [Hono](https://mastra.ai/guides/getting-started/hono)

