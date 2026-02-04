---
name: pl-condition-class-attr
description: Understand how to use condition class attribute in SvelteKit
tags:
  - sveltekit
  - condition class attr
  - array class
---

- **MUST** use array syntax when class attribute contains conditional logic
- Always use array to store condition class attribute in svelte component.
- each condition take one line in array.
- use ternary operator to define condition class. ex: `isActive ? 'bg-black text-white' : 'bg-white text-black'`
- use `??` if condition only check true/false. ex: `true ?? 'bg-black text-white'`
- **NEVER** use utility functions like `cn()` or similar libraries to merge classes
- **SVELTE 5**: Built-in array-to-string conversion works like `cn()` - no need for `.filter(Boolean).join(' ')`

**Incorrect:**

```svelte
<div class="bg-white text-black {isActive ? 'bg-black text-white' : 'bg-white text-black'}">
</div>
```

**Correct:**

```svelte
<div class={[
    'bg-white text-black',
    'p-4 rounded-md shadow-md',
    isActive ? 'bg-black text-white' : 'bg-white text-black'
]}>
</div>
```

**Svelte 5 Built-in Support:**
```svelte
<!-- Svelte 5 automatically converts arrays to class strings -->
<div class={['flex', 'flex-col', 'gap-6', className]}>
<!-- No need for .filter(Boolean).join(' ') - Svelte handles it natively -->
```
