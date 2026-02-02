---
name: pl-component-installation
description: Always use shadcn CLI to install components, never create manually
tags: [shadcn, components, cli, installation, policy]
---

**CRITICAL**: When adding shadcn components to a SvelteKit project, ALWAYS use the official shadcn CLI command instead of creating components manually.

## Correct Process

1. Run `npx shadcn-svelte@latest add [component-name]` from the app directory
2. The CLI will handle proper installation, dependencies, and file structure
3. Use namespace imports: `import * as Component from '$lib/components/ui/component'`
4. Follow the exact component structure from the installed files (check index.ts for available exports)

## Incorrect

```typescript
// NEVER create components manually
import * as Accordion from '$lib/components/ui/accordion';
// Then manually create accordion files - WRONG!
```

## Correct

```bash
# ALWAYS use CLI
npx shadcn-svelte@latest add accordion
npx shadcn-svelte@latest add button
npx shadcn-svelte@latest add card
```

```typescript
// Then use proper namespace imports
import * as Accordion from '$lib/components/ui/accordion';
import * as Button from '$lib/components/ui/button';
import * as Card from '$lib/components/ui/card';
```

## Important Notes

- Always check the component's `index.ts` file to see exactly which exports are available
- Some components don't have all parts (e.g., accordion doesn't have Header, Footer, etc.)
- Manual creation leads to broken functionality and inconsistent patterns
- shadcn components have complex internal implementations that must match official specification
