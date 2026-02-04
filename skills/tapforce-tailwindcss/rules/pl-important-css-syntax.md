---
name: pl-important-css-syntax
description: Guide correct important CSS syntax following tailwindcss version 4 standards.
tags:
  - sveltekit
  - svelte5
  - tailwindcss
  - styling
  - important
---

## Use suffix `!` for important CSS in Tailwind CSS 4

Starting from Tailwind CSS 4, the important modifier syntax has changed from prefix to suffix format.

### Incorrect (Old Tailwind CSS 3 syntax)
```svelte
<!-- Don't use prefix ! -->
<div class="!transition-all !scale-100 !opacity-100">
```

### Correct (Tailwind CSS 4 syntax)
```svelte
<!-- Use suffix ! -->
<div class="transition-all! scale-100! opacity-100!">
```

## When to use important modifier

Use the important modifier (`!`) sparingly and only when:

1. **Overriding conflicting styles** - When third-party CSS or inline styles need to be overridden
2. **Specific utility priority** - When you need to ensure a utility takes precedence over other utilities
3. **Component isolation** - When creating isolated components that shouldn't be affected by external styles

### Examples

```svelte
<!-- Correct usage for transition priority -->
<SunIcon class="h-[1.2rem] w-[1.2rem] scale-100 rotate-0 transition-all! dark:scale-0 dark:-rotate-90" />

<!-- Correct usage for display override -->
<div class="block! md:hidden">
  <!-- Always show on mobile, hide on desktop -->
</div>

<!-- Correct usage for z-index priority -->
<div class="relative z-50!">
  <!-- Ensure this element stays on top -->
</div>
```

## Migration from prefix to suffix

When updating existing code:

1. **Find all prefix `!` usage**: Search for `!"` or `!'` patterns
2. **Move `!` to end**: Move the important marker to the end of the utility class
3. **Update variants**: Ensure variants (hover:, focus:, dark:) come before the `!`

### Migration examples

```svelte
<!-- Before -->
<div class="!transition-all hover:!scale-105 dark:!hidden">

<!-- After -->
<div class="transition-all! hover:scale-105! dark:hidden!">
```

## Best practices

1. **Avoid overuse** - Important modifiers should be exceptions, not the rule
2. **Document usage** - Add comments when using `!` for non-obvious reasons
3. **Consider alternatives** - Use more specific selectors or CSS cascade before reaching for `!`
4. **Test thoroughly** - Important styles can have unintended side effects

## Implementation checklist

- [ ] Replace all prefix `!` with suffix `!` format
- [ ] Update variant ordering (variant:utility!)
- [ ] Test affected components for visual regressions
- [ ] Document any complex important usage scenarios
- [ ] Run build to ensure no CSS conflicts
