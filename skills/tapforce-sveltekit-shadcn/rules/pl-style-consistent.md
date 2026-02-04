---
name: pl-style-consistent
description: Keep shadcn's style consistent with project's style guide.
tags:
  - sveltekit
  - shadcn
  - style
---

After install Shadcn svelte to project, it shipped with default style defined in `/src/routes/layout.css`. Depend on project requirement, you can override the style include:

- Update shadcn color config inside `layout.css`, respect color value scheme (default is oklch()).
- respect color scheme format: oklch() with 3 values: lightness, chroma, hue. Values separate by space.
- Understand and update color correct with the scope that color variable used in scadcn components.
ex:
    `--foreground` applied to text color default, button variant default etc.

## always customize shadcn style or add new css variable in separate `:root` and `.dark` block:

**Example:**

```css
:root {
    /* default shadcn style */
    --foreground: oklch(0.145 0 0);
}

.dark {
    --foreground: oklch(0.985 0 0);
}

/* customize color */
:root {
  --foreground: oklch(0.145 1 1);
}

.dark {
    --foreground: oklch(0.985 1 1);
}


