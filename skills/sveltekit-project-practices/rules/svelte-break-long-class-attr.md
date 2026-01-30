---
title: Break long class attribute to multi line
description: use svelte 5 feature to break long string class attribute html to multi line via array
tags: sveltekit, svelte5, class, style
---

## break long class attribute to multi line

- when a html tag need define long `class=""` attribute, break into multi string and store in array.
- string length should be short and meanful, but not break into single class per line.

**Incorrect:**

```html
<div
  class="bg-white text-black p-4 rounded-md shadow-md flex items-center justify-center"
></div>
```

**Correct:**

```svelte
<div class={[
  'bg-white text-black',
  'p-4 rounded-md shadow-md',
  'flex items-center justify-center'
]}>
</div>
```

Reference: https://svelte.dev/docs/svelte/class
