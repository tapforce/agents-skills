---
name: pl-svelte5-syntaxs
description: Practice svelte5 syntaxs
---

# Svelte 5 Syntax Enforcement Rule

## Primary Directive
**ALWAYS** use Svelte 5 syntax when working with any Svelte project or writing components. No exceptions.

## Mandatory Requirements

### 1. Svelte 5 Syntax Usage
- Use modern Svelte 5 runes (`$state`, `$derived`, `$effect`)
- Implement event handlers as attributes (`onclick` instead of `on:click`)
- Use `<script>` tags without `context="module"` for component logic
- Utilize Svelte 5 component composition patterns
- Apply new reactivity model with runes

### 2. Component Compatibility
- **IMMEDIATELY REJECT** any component or package that doesn't support Svelte 5
- Verify Svelte 5 compatibility before adding any dependencies
- Check package documentation for Svelte 5 support
- Avoid legacy Svelte components that require migration

### 3. Project Standards
- All new components must be written using Svelte 5 syntax
- Existing components should be migrated to Svelte 5 when modified
- Use TypeScript with Svelte 5 type definitions
- Follow Svelte 5 best practices and patterns

## Rejection Criteria
Reject any of the following:
- Components using Svelte 4 or earlier syntax
- Packages without explicit Svelte 5 support
- Legacy event handler syntax (`on:click`)
- Old reactivity patterns (`export let`, `$:`)
- Components requiring `context="module"`

## Implementation Examples

### ✅ Correct (Svelte 5)
```svelte
<script lang="ts">
  let count = $state(0);
  let doubled = $derived(() => count * 2);
  
  function increment() {
    count += 1;
  }
</script>

<button onclick={increment}>Count: {count}</button>
<p>Doubled: {doubled}</p>
```

### ❌ Incorrect (Legacy Svelte)
```svelte
<script lang="ts">
  export let count = 0;
  $: doubled = count * 2;
</script>

<button on:click={() => count += 1}>Count: {count}</button>
<p>Doubled: {doubled}</p>
```

## Verification Checklist
- [ ] Using `$state`, `$derived`, or `$effect` runes
- [ ] Event handlers use attribute syntax (`onclick`, `onchange`)
- [ ] No `context="module"` in script tags
- [ ] Package explicitly supports Svelte 5
- [ ] Component follows Svelte 5 patterns

## Enforcement
This rule is **strictly enforced**. Any violation results in immediate rejection and requires correction before proceeding.

