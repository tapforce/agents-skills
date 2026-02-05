---
name: svelte5-features
description: Rule for using Svelte 5 modern features like $state, $effect, $props, $derived
tags: [svelte, svelte5, features, reactivity]
---

**ALWAYS** write Svelte code using Svelte version >= 5 features including:
- `$state` for reactive state management
- `$effect` for side effects
- `$props()` for component props
- `$derived` for computed values
- `$bindable` for two-way bindings
- `{@render children()}` for rendering snippets

**NEVER** use legacy Svelte syntax like:
- `export let` for props (use `$props()` instead)
- `$:` reactive statements (use `$derived` or `$effect` instead)
- Traditional slot syntax (use snippets with `{@render}` instead)

**ALWAYS** use modern runes-based patterns in all component code.
