---
title: pl-break-long-class-attr
description: Understand how to break long class attribute to multi line in SvelteKit
tags:
  - sveltekit
  - svelte5
  - class
  - style
---

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
