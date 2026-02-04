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

**CRITICAL**: Always use specific shadcn version instead of `latest` to avoid unexpected behavior when updating shadcn ui.

### How to find the correct version:

1. **Check package.json**: Look in `devDependencies` for `"shadcn-svelte": "^x.x.x"`
2. **Check package.json scripts**: Look for the `"shadcn"` script which shows the exact version
3. **Use the exact version**: Always use the version number found in package.json

### Example:
If package.json contains:
```json
"devDependencies": {
  "shadcn-svelte": "^1.1.1"
},
"scripts": {
  "shadcn": "pnpm dlx shadcn-svelte@1.1.1"
}
```
Then use `shadcn-svelte@1.1.1` (NOT `@latest`) in all commands.

## Add Shadcn component as needed

**CRITICAL**: When you need to use a shadcn component that doesn't exist in the project, use the specific version from package.json:

**CORRECT**: `pnpm dlx shadcn-svelte@<VERSION_FROM_PACKAGE.JSON> add <component-name>`

**WRONG**: `pnpm dlx shadcn-svelte@latest add <component-name>`

## Add package.json's script as shortcut

ALWAYS add shadcn command `add component` to `package.json` file as a script and define correct shadcn version into command help use it easily through terminal.
