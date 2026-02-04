---
name: pl-component-installation
description: Always use shadcn CLI to install components, never create manually
tags: [shadcn, components, cli, installation, policy]
---

**CRITICAL**: When adding shadcn components to a SvelteKit project, ALWAYS use the official shadcn CLI command instead of creating components manually.

## Rule: Check Before Use

**Before using any shadcn component in your code, you MUST verify it exists in the project:**

1. **Check if component exists**: Look in `$lib/components/ui/[component-name]` directory
2. **If missing**: Install using CLI immediately before attempting to use the component
3. **Never import non-existent components**: This will cause runtime errors

## Correct Process

1. **Check existence**: Verify `$lib/components/ui/[component-name]` exists
2. **Find correct version**: Check package.json for the exact shadcn-svelte version
3. **If missing**: Run `pnpm dlx shadcn-svelte@<VERSION_FROM_PACKAGE.JSON> add [component-name]` from the app directory
4. **Verify installation**: Check the component's `index.ts` for available exports
5. **Use namespace imports**: `import * as Component from '$lib/components/ui/component'`
6. **Follow exact structure**: Use only the exports available in the installed files

## Incorrect

```typescript
// NEVER import components without checking if they exist first
import * as DropdownMenu from '$lib/components/ui/dropdown-menu';
// This will fail if dropdown-menu wasn't installed via CLI

// NEVER create components manually
import * as Accordion from '$lib/components/ui/accordion';
// Then manually create accordion files - WRONG!
```

## Correct

```bash
# ALWAYS use CLI with specific version from package.json
pnpm dlx shadcn-svelte@1.1.1 add dropdown-menu
pnpm dlx shadcn-svelte@1.1.1 add accordion
pnpm dlx shadcn-svelte@1.1.1 add button
pnpm dlx shadcn-svelte@1.1.1 add card
```

```typescript
// Then use proper namespace imports AFTER installation
import * as DropdownMenu from '$lib/components/ui/dropdown-menu';
import * as Accordion from '$lib/components/ui/accordion';
import * as Button from '$lib/components/ui/button';
import * as Card from '$lib/components/ui/card';
```

## Important Notes

- **Always check existence first**: Look in `$lib/components/ui/[component-name]` before importing
- **Use specific version**: Always check package.json for the exact shadcn-svelte version, never use `@latest`
- **Install immediately**: If component doesn't exist, run CLI command before writing any code that uses it
- Always check the component's `index.ts` file to see exactly which exports are available
- Some components don't have all parts (e.g., accordion doesn't have Header, Footer, etc.)
- Manual creation leads to broken functionality and inconsistent patterns
- shadcn components have complex internal implementations that must match official specification
- Importing non-existent components will cause runtime errors and build failures
