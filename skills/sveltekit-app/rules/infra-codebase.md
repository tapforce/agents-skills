---
title: Set up code base
description: Use PNPM to setup code base for Sveltekit project from frameworks and packages.
tags: infrastructure, codebase, setup
---

## SvelteKit

Always reference information from [Official website](https://svelte.dev/docs/kit/creating-a-project) to know how to start new project from command. Do following:

- Use PNPM to install Sveltekit project.
- While command run step by step, let's user choose sub-prompt from terminal such as: `Yes` / `No`, `install sub-packages` etc.
- Create file `pnpm-workspace.yaml` with content:

```yaml
packages:
  - "."
```

- Run `pnpm i` to install all dependencies.
- Run `pnpm approve-build` to approve build.

## TailwindCSS

- ALways validate `package.json` to know if `tailwindcss` is installed.
- When `tailwindcss` not installed yet, reference [Install tailwindcss for sveltekit](https://tailwindcss.com/docs/installation/framework-guides/sveltekit) and follow exactly, skip install again Sveltekit steps.
- use tailwindcss version 4 or higher, never use version 3.

### How to use tailwindcss

Reference rule `code-tailwindcss.md`

## Shadcn svelte

- Always check official website [Shadcn svelte port](https://www.shadcn-svelte.com/docs/installation/sveltekit) to know how to install.
- After install and setup shadcn svelte to project, check file `package.json` to know shadcn version installed. Remember  version and append this version replace `@latest` in any shadcn command from now on.

Example: found version 0.1.0

*** origin command ***
```bash
# add button component to project
pnpm dlx shadcn-svelte@latest add button
```

*** correct command ***
```bash
# add button component to project
pnpm dlx shadcn-svelte@0.1.0 add button
```

- Always check component page from official site when need write UXUI, prefer use component from shadcn svelte if match requirements.
- Install component following component document page from official site.
- Keep Shadcn's component files as it is, never change content.

References:

- [Install shadcn svelte](https://www.shadcn-svelte.com/docs/installation/sveltekit)
- [Components](https://www.shadcn-svelte.com/docs/components)

### How to use shadcn svelte library