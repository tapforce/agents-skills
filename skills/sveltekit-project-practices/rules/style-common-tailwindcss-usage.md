---
title: Common Tailwindcss Usage
description: Common tailwindcss usage that must follow tailwind version 4.
tags: sveltekit, svelte5, tailwindcss, styling
---

## All tailwindcss configuration must following tailwind version 4

When need to change default tailwindcss configuration, following instruction of tailwind version 4 that only use css to define configuration.

## Set cursor pointer to button by default

If project implemented shadcn library, add style default cursor-pointer to button in css file if it not added yet:

```css
@layer base {
  /* force cursor pointer on buttons */
  button:not(:disabled),
  [role="button"]:not(:disabled) {
    cursor: pointer;
  }
}
```

## Prefer use tailwindcss classes to present custom UI

## use arbitraty values to present custom UI

- When need add custom css style, use class customize strategy from tailwindcss, avoid use inline css style.
- Reference: https://tailwindcss.com/docs/styling-with-utility-classes#using-arbitrary-values
- Reference: https://tailwindcss.com/docs/adding-custom-styles#arbitrary-properties
- Reference: https://tailwindcss.com/docs/adding-custom-styles#arbitrary-variants
