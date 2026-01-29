---
title: Use `@utility` block when need define custom class
description: Guide correct way to make style application with Tailwindcss and it's classes.
tags: sveltekit, svelte5, tailwindcss, styling
---

## Use `@utility` block when need define custom class

When need to define custom class, following instruction of tailwindcss version 4 that only use css to define custom class.

```css
@utility text-lead {
  /* re-use built-in tailwindcss classes */
  @apply text-lg text-primary;
  /* define plain css */
  line-height: 1.5;
}

/* use .text-lead to apply style */
```
