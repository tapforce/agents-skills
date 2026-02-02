---
name: pr-setup
description: Shadcn UI setup for project
tags:
  - setup
  - prepare
---

## Init shadcn on the project

**CRITICAL**: **NEVER** install shadcn manually. **ALWAYS** use command: `pnpm dlx shadcn-svelte@latest init` to start init shadcn ui on the project.

**FORBIDDEN**: Do NOT manually:
- Install packages with `pnpm add`
- Create `tailwind.config.js` files
- Manually add CSS variables to HTML
- Create `components.json` manually
- Create `lib/utils.ts` manually

The CLI init command handles ALL configuration automatically including:
- Tailwind CSS v4 setup
- CSS variables configuration  
- Component aliases
- Utility functions
- Dependencies installation

## Remember shadcn version instead of `latest`

**CRITICAL**: remember shadcn version instead of `latest` to avoid unexpected behavior when update shadcn ui. ALWAYS use specific version instead of `latest` for future commands. Find this version in `packages.json` file.

## Add Shadcn component as needed

**CRITICAL**: when need use shadcn component but not exist in project, use command: `pnpm dlx shadcn-svelte@<shadcn version> add <component-name>` to add shadcn component to the project.

## Add package.json's script as shortcut

ALWAYS add shadcn command `add component` to `package.json` file as a script and define correct shadcn version into command help use it easily through terminal.
