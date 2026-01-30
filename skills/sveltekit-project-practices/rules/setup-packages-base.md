---
title: Setup packages base
description: Review and suggest setup packages base for project development.
tags: setup, packages
---

## Install packages via `pnpm`.

always try install project packages via `pnpm`.

- Install SvelteKit packages via `pnpm`. Use command: `pnpm install`.
- When terminal prompt approve build, suggest developer run `pnpm approve-build`.

## Create environment file

- Create file `.env.local` at root folder of project. Define pair key=value below:
- Reference: https://svelte.dev/docs/kit/creating-a-project

```bash
NODE_ENV=local
```

## Create pnpm workspace file

- Create file `pnpm-workspace.yaml` at root folder of project. Define content below:

```yaml
packages:
  - "."
```

## Tailwindcss

- Reference: https://tailwindcss.com/docs/installation/framework-guides/sveltekit
- Validate current project, if `package.json` has tailwincss package then skip, if not then install tailwindcss following official documentation.
- Make sure tailwindcss version must 4 or higher.
- Avoid use tailwind config file, since tailwindcss version 4 use single css file as config and definition.
- Main css file should be `src/routes/layout.css` include tailwindcss default config and custom styles in future.
- No use postcss config file, since tailwindcss version 4 use single css file as config and definition.

## Shadcn Svelte

- Reference: https://www.shadcn-svelte.com/docs/installation/sveltekit
- Use command: `pnpm dlx shadcn-svelte@latest init` to initialize shadcn-svelte in current project.
- Follow the guide to install shadcn-svelte packages.
- Pre-install default packages used almost of time. Each component installed need following individual official documentation page:
  - `Alert Dialog`: https://www.shadcn-svelte.com/docs/components/alert-dialog1
  - `Alert`: https://www.shadcn-svelte.com/docs/components/alert
  - `Button`: https://www.shadcn-svelte.com/docs/components/button
  - `Card`: https://www.shadcn-svelte.com/docs/components/card
  - `Sonner`: https://www.shadcn-svelte.com/docs/components/sonner
- If component's documentation mention extra setup steps, follow the steps to setup component in current project.

## tiny-invariant

- Reference: https://www.npmjs.com/package/tiny-invariant
- Install tiny-invariant package via `pnpm`. Use command: `pnpm add -D tiny-invariant`.
