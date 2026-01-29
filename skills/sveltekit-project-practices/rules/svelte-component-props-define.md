---
title: Define props in svelte 5 component
description: Guide correct way to define props in svelte 5 component.
tags: sveltekit, svelte5, props, component
---

## Define props in svelte 5 component

- Avoid define component props by `export let propName: PropType;` (svelte 4).
- Always choose define component props following svelte 5 structure.
- Use `$props()` to get props in component.
- Always define typescript type for props.
- props need use destructuring assignment to get props value.
- props need use typescript type annotation to get props value.
- If prop is 2-ways binding, need use `$bindable(value)` as default value.
- If prop has default value, define type is optional use `?` to allow undefined value.

```svelte
<script>
  let { propName = defaultValue }: { propName?: PropType } = $props();
</script>
```

- Whenever need define slot props (snippet) need define with Svelte typescript `Snippet<>`.

```svelte
<script>
    import type { Snippet } from 'svelte';
    let { propName = defaultValue }: { propName?: Snippet<PropType> } = $props();
</script>
```

- Use `{@render propName()}` to render slot props.
- file `+layout.svelte` always define `{@render children()}` to render slot content, along with define prop `children` with type `Snippet`.

```svelte
<script>
    import type { Snippet } from 'svelte';
    let { children }: { children?: Snippet } = $props();
</script>

{@render children()}
```
