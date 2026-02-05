---
name: class-array-syntax
description: Rule for using array syntax in HTML class attributes for better readability
tags: [svelte, html, class, syntax]
---

**ALWAYS** use array syntax for HTML `class` attributes when the class string exceeds 100 characters per line.

**ALWAYS** break long class strings into multiple lines using array syntax with line width not exceeding 100 characters.

**ALWAYS** use class array style whenever having classes that can be switched or toggled by condition.

**NEVER** use long single-line class strings that exceed 100 characters.

Examples:
```svelte
<!-- ✅ Good - Array syntax for long classes -->
<div class={[
  'base-class',
  'another-class',
  isActive && 'active-class',
  isLoading && 'loading-class'
]}>
  Content
</div>

<!-- ✅ Good - Array syntax for conditional classes -->
<button class={[
  'btn',
  'btn-primary',
  variant === 'large' && 'btn-lg',
  disabled && 'btn-disabled'
]}>
  Click me
</button>

<!-- ❌ Bad - Long class string over 100 characters -->
<div class="base-class another-class-very-long-name that-makes-this-line-way-too-long">
  Content
</div>
```

**EXPLANATION**: Svelte 5 supports class arrays natively, making it easier to manage conditional classes and keep code readable.
