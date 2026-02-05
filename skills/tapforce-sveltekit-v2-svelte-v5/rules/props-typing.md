---
name: props-typing
description: Rule for proper TypeScript prop typing with destructuring in Svelte 5
tags: [svelte, props, typescript, typing]
---

**ALWAYS** define props using destructuring with proper TypeScript types.

**NEVER** use `any` or `unknown` types for props.

**ALWAYS** include real, specific types for all prop properties.

Examples:
```svelte
// ✅ Good - Proper typing with destructuring
let { 
  title: string, 
  items: string[], 
  onClick: (id: string) => void,
  isVisible = true 
} = $props();

// ❌ Bad - Missing types
let { title, items, onClick } = $props();

// ❌ Bad - Using any/unknown
let { data: any } = $props();
let { config: unknown } = $props();
```

**ALWAYS** prefer interface or type definitions for complex object props.
