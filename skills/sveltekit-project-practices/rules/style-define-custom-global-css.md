---
title: Define global custom style within `@layer base`
description: Guide correct way to make style application with Tailwindcss and it's classes.
tags: sveltekit, svelte5, tailwindcss, styling
---

## Define global custom style within `@layer base`

When need to define global custom style, following instruction of tailwindcss version 4 that only use css to define global custom style.

```css
@layer base {
  /* define global custom style */
  .text-lead {
    @apply text-lg text-primary;
    line-height: 1.5;
  }
}
```