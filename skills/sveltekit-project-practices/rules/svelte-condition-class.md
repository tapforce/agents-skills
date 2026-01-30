---
title: Use svelte class value (array) for define long, complex class name
description: Use array to store multi lines of css class when need define long, condition class name in html.
tags: sveltekit, svelte5, class, style
---

- Always use array to store condition class attribute in svelte component.
- each condition take one line in array.
- use ternary operator to define condition class. ex: `isActive ? 'bg-black text-white' : 'bg-white text-black'`
- use `??` if condition only check true/false. ex: `true ?? 'bg-black text-white'`

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
