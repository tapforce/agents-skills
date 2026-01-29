---
title: Use runes mode in svelte 5
description: Guide to use runes correct way in Svelte 5.
tags: sveltekit, svelte5, runes
---

## Always use runes mode in svelte 5

- Use Rune mode for reactive variables whenever possible.
- Avoid using `$:` prefix for reactive variables.
- Avoid use `store` functions (`writable`, `readable`...) except really need for advance abstracts.
- Use `$state()` for variable mutatable.
  ex:

**Incorrect:**

```svelte
<script>
  let count = 0;
  let doubleCount = count * 2;
</script>

{count} x 2 = {doubleCount}
```

**Correct:**

```svelte
<script>
  let count = $state(0);
  let doubleCount = $derived(count * 2);
</script>

{count} x 2 = {doubleCount}
```

## Reference

- https://svelte.dev/blog/runes
