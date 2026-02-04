---
name: pl-break-long-class-attr
description: Understand how to break long class attribute to multi line in SvelteKit
tags:
  - sveltekit
  - svelte5
  - class
  - style
---

- **MUST** use array syntax when class attribute becomes long (more than 3-4 classes or exceeds 80 characters)
- break into multi string and store in array.
- string length should be short and meanful, but not break into single class per line.
- **NEVER** use utility functions like `cn()` or similar libraries to merge classes
- **SVELTE 5**: Built-in array-to-string conversion works like `cn()` - no need for `.filter(Boolean).join(' ')`

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

**Svelte 5 Built-in Support:**
```svelte
<!-- Svelte 5 automatically converts arrays to class strings -->
<div class={['flex', 'flex-col', 'gap-6', className]}>
<!-- No need for .filter(Boolean).join(' ') - Svelte handles it natively -->
```

Reference: https://svelte.dev/docs/svelte/class
