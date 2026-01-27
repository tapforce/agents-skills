---
title: Tailwindcss coding style
description: Guide how to use tailwindcss in sveltekit project.
tags: sveltekit, tailwindcss
---

## Respect tailwindcss classes

Respect tailwindcss classes, try to use exists tailwindcss's classes to write UI. Classes and styles should follow tailwindcss's documentation, info can get from linkes inside [this page](https://tailwindcss.com/docs/preflight).

## Avoid custom styles inside svelte's component

Avoid custom styles inside svelte's component as much as possible. If need to add new custom style/class, add to `/src/layout.css` file.

## prefer use @utility class to add new custom style

If need to add new style that shared to multi places, prefer use tailwindcss ver 4 `@utility` class to add new custom style.

example css code

```tailwindcss
@utility example {
  $code
}
```

## customize color palette in separate `:root {}` block

When project use `Shadcn` library, and requirements need to customize color palette, custom color values should be following `Shadcn` color configuration.

New color values should defined in to other `:root {}` block (for light theme) and other `.dark {}` block for dark theme, put under origin `:root {}` block and `.dark {}` block.

Put comment on top:

```tailwindcss
/* custom color for project */
...
```

**Incorrect:**

```tailwindcss
:root {
    ... shadcn origin code ...
    --radius: 0.625rem;
    --background: oklch(1 0 0);
    --foreground: oklch(0.129 0.042 264.695);

    /* custom color for project */
    --background: oklch(0 0 0);
    --foreground: oklch(0 0 0);
}

.dark {
    ... shadcn origin code ...
    --background: oklch(0.129 0.042 264.695);
    --foreground: oklch(0.984 0.003 247.858);

    /* custom color for project */
    --background: oklch(0 0 0);
    --foreground: oklch(0 0 0);
}
```

**Correct:**

```tailwindcss
:root {
    ... shadcn origin code ...
    --radius: 0.625rem;
    --background: oklch(1 0 0);
    --foreground: oklch(0.129 0.042 264.695);
}

.dark {
    ... shadcn origin code ...
    --background: oklch(0.129 0.042 264.695);
    --foreground: oklch(0.984 0.003 247.858);
}

/* custom color for project */

:root {
    --background: oklch(0 0 0);
    --foreground: oklch(0 0 0);
}

.dark {
    --background: oklch(0 0 0);
    --foreground: oklch(0 0 0);
}
```

## Color palette respect tailwindcss v4 is oklch color space

Respect tailwindcss and Shadcn color v4 is oklch color space.

**Incorrect:**

```
oklch(0.208, 0.042, 265.755); <- incorrect, between values should only 1 space

okl(0.208 0.042 265.755); <- incorrect, prefix should be oklch

hsl(265.755, 0.042, 0.208); <- incorrect, color space should be oklch
```

**Correct:**

```
oklch(0.208 0.042 265.755);
```

## use asterisk (single, double) to styling child elements instead of custom css

When need style closest or deeper child elements, try use tailwindcss asterisk instead of write custom css inline component or in `layout.css`.

Reference:

- [Child selectors](https://tailwindcss.com/docs/hover-focus-and-other-states#child-selectors)
- [Styling direct children](https://tailwindcss.com/docs/hover-focus-and-other-states#styling-direct-children)
- [Styling all descendants](https://tailwindcss.com/docs/hover-focus-and-other-states#styling-all-descendants)

## Prefer use custom class syntax for custom style

When need write custom style for a specific element, prefer use custom class syntax instead of write custom css inline component.

Reference: [Use custom value](https://tailwindcss.com/docs/font-size#using-a-custom-value)

**Example:**

```html
<!-- use custom value  -->
<p class="text-[14px] ...">
  Lorem ipsum dolor sit amet...
</p>
```

## When same custom value used more than 3 times, prefer define custom css variable on `layout.css` file

When same custom value used more than 3 times, prefer define custom css variable on `layout.css` file instead of write custom value inline component.

**Example:**

```html
<!-- use custom value is css variable. `--my-text-size` is custom css variable defined on `layout.css` file -->
<p class="text-(length:--my-text-size) ...">
  Lorem ipsum dolor sit amet...
</p>
```
