---
name: tapforce-sveltekit-v2-svelte-v5
description: Use when project mentions using SvelteKit or creating new SvelteKit projects. Handles SvelteKit v2+ and Svelte v5+ setup, installation, and development with modern Svelte 5 features.
license: Apache-2.0
metadata:
  author: tapforce
  version: "1.0"
compatibility: Requires Node.js 18+, SvelteKit v2+, Svelte v5+
allowed-tools: Bash Read Write
---

# SvelteKit v2 + Svelte v5 Skill

This skill helps you set up and work with SvelteKit v2 and Svelte v5 projects, ensuring modern Svelte 5 features and best practices.

## Reference Documentation

Based on the official SvelteKit LLM documentation: https://svelte.dev/docs/kit/llms.txt

## Workflow

### 1. Check Project Status

First, check if SvelteKit is already installed in the current project:

```bash
# Check if package.json exists and has SvelteKit dependencies
if [ -f "package.json" ]; then
  grep -q "@sveltejs/kit" package.json && echo "SvelteKit found" || echo "SvelteKit not found"
  grep -q "svelte" package.json && echo "Svelte found" || echo "Svelte not found"
else
  echo "No package.json found"
fi
```

### 2. Version Requirements

**If SvelteKit is installed:**
Check specific versions and ensure they meet requirements:

```bash
# Check SvelteKit version
npm list @sveltejs/kit

# Check Svelte version  
npm list svelte

# Extract version numbers for comparison
KIT_VERSION=$(npm list @sveltejs/kit --depth=0 | grep '@sveltejs/kit' | sed 's/.*@//' | sed 's/ .*//')
SVELTE_VERSION=$(npm list svelte --depth=0 | grep 'svelte' | sed 's/.*@//' | sed 's/ .*//')

echo "SvelteKit version: $KIT_VERSION"
echo "Svelte version: $SVELTE_VERSION"
```

**If versions don't match requirements (SvelteKit >= 2.0.0, Svelte >= 5.0.0):**

```bash
# Update to latest compatible versions
npm install @sveltejs/kit@latest svelte@latest

# Or update specific versions
npm install @sveltejs/kit@^2.0.0 svelte@^5.0.0

# Verify updates
npm list @sveltejs/kit svelte
```

### 3. Installation

**If SvelteKit is not installed:**
Create a new SvelteKit project in the current folder:

```bash
npx sveltekit@latest create .
```

**During installation:**
- The CLI will ask about optional packages
- Let the user choose which packages to install
- Common options include:
  - `tailwindcss` for styling
  - `adapter-vercel` for Vercel deployment
  - `eslint` for linting
  - `prettier` for code formatting

### 4. Project Setup

After installation, ensure the project uses modern Svelte 5 features:

```bash
# Install dependencies
npm install

# Start development server
npm run dev
```

## Svelte 5 Development Guidelines

### Core Features to Use

**Always use Svelte 5 runes and modern syntax:**

```svelte
<script>
  // Use $state for reactive state
  let count = $state(0);
  
  // Use $derived for computed values
  let doubled = $derived(count * 2);
  
  // Use $effect for side effects
  $effect(() => {
    console.log('Count changed:', count);
  });
  
  // Use $props for component props with destructuring
  let { name: string, age: number, isActive = true } = $props();
  
  // Use $bindable for two-way bindings
  let value = $bindable('');
</script>

<!-- Use {@render} for snippets -->
{#snippet child()}
  <p>Child content</p>
{/snippet}

{@render child()}
```

### Props Definition Guidelines

**Always define props with proper TypeScript types using destructuring:**

```svelte
<script lang="ts">
  // ✅ Good - Proper typing with destructuring
  let { 
    title: string, 
    items: string[], 
    onClick: (id: string) => void,
    isVisible = true 
  } = $props();
  
  // ❌ Bad - No typing or using any/unknown
  let { title, items, onClick } = $props(); // Missing types
  let { data: any } = $props(); // Using any
  let { config: unknown } = $props(); // Using unknown
</script>
```

### Class Attribute Guidelines

**For long class attributes (over 100 characters), use array syntax:**

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

<!-- ❌ Bad - Long single-line class string -->
<div class="base-class another-class active-class loading-class">
  Content
</div>

<!-- ❌ Bad - Long class string over 100 characters -->
<div class="base-class another-class-very-long-name that-makes-this-line-way-too-long">
  Content
</div>
```

**Explanation:** Svelte 5 supports class arrays natively, making it easier to manage conditional classes and keep code readable.

**Always use class-array style whenever having classes that can be switched or toggled by condition:**

```svelte
<script>
  let { isActive, isLoading, variant } = $props();
</script>

<!-- ✅ Good - Array syntax for conditional classes -->
<button class={[
  'btn',
  'btn-primary',
  isActive && 'btn-active',
  isLoading && 'btn-loading',
  variant === 'large' && 'btn-large'
]}>
  Button
</button>
```

### Component Structure

**Always use modern Svelte 5 patterns:**

```svelte
<script lang="ts">
  // Props with proper typing and destructuring
  let { 
    user: { name: string, email: string },
    onUpdate: (user: User) => void 
  } = $props();
  
  // Reactive state
  let isLoading = $state(false);
  let error = $state<string | null>(null);
  
  // Derived values
  let displayName = $derived(user.name.trim());
  
  // Effects
  $effect(() => {
    if (error) {
      console.error('Component error:', error);
    }
  });
  
  // Event handlers
  async function handleSubmit() {
    isLoading = $state(true);
    try {
      await onUpdate(user);
    } catch (err) {
      error = $state(err.message);
    } finally {
      isLoading = $state(false);
    }
  }
</script>

<!-- Template with modern syntax -->
<div class="user-card">
  <h2 class={displayName ? 'user-name' : 'user-name-empty'}>
    {displayName || 'No name'}
  </h2>
  
  {#if isLoading}
    <div class="loading">Loading...</div>
  {:else if error}
    <div class="error">{error}</div>
  {/if}
  
  <button onclick={handleSubmit}>
    Update User
  </button>
</div>

<style>
  .user-card {
    padding: 1rem;
    border-radius: 8px;
  }
  
  .user-name {
    font-weight: 600;
    color: var(--color-primary);
  }
  
  .loading {
    opacity: 0.6;
  }
  
  .error {
    color: var(--color-error);
  }
</style>
```

## Rules

This skill includes the following behavioral rules in the `rules/` directory:

### Installation
- **Rule**: Install SvelteKit in current directory using specific command
- **File**: `rules/installation.md`
- **Details**: Always use `npx sveltekit@latest create .` and let users choose optional packages

### Svelte 5 Features
- **Rule**: Always use Svelte 5 modern features and syntax
- **File**: `rules/svelte5-features.md`
- **Details**: Use $state, $effect, $props(), $derived, $bindable, and {@render} snippets

### Props Typing
- **Rule**: Use proper TypeScript prop typing with destructuring
- **File**: `rules/props-typing.md`
- **Details**: Always define props with specific types, never use any/unknown

### Class Array Syntax
- **Rule**: Use array syntax for long and conditional class attributes
- **File**: `rules/class-array-syntax.md`
- **Details**: Use array syntax for classes over 100 characters or with conditions

These rules provide behavioral bias for agents using this skill and should be applied as high-priority guidelines.

## Common Patterns

### Form Handling

```svelte
<script lang="ts">
  let { onSubmit } = $props();
  
  let formData = $state({
    name: '',
    email: ''
  });
  
  let isSubmitting = $state(false);
  
  async function handleSubmit() {
    isSubmitting = $state(true);
    try {
      await onSubmit(formData);
      formData = $state({ name: '', email: '' });
    } finally {
      isSubmitting = $state(false);
    }
  }
</script>

<form onsubmit={handleSubmit}>
  <input 
    type="text" 
    bind:value={formData.name}
    placeholder="Name"
    class={['form-input', !formData.name && 'required']}
  />
  <input 
    type="email" 
    bind:value={formData.email}
    placeholder="Email"
    class={['form-input', !formData.email && 'required']}
  />
  <button 
    type="submit"
    disabled={isSubmitting || !formData.name || !formData.email}
    class={['btn', 'btn-primary', isSubmitting && 'loading']}
  >
    {isSubmitting ? 'Submitting...' : 'Submit'}
  </button>
</form>
```

### Conditional Rendering

```svelte
<script lang="ts">
  let { status, user } = $props();
  
  let isLoading = $state(status === 'loading');
  let isError = $state(status === 'error');
</script>

<div class="container">
  {#if isLoading}
    <div class={['status', 'loading']}>Loading...</div>
  {:else if isError}
    <div class={['status', 'error']}>Error occurred</div>
  {:else if user}
    <div class={['status', 'success', 'user-profile']}>
      Welcome, {user.name}
    </div>
  {/if}
</div>
```

## Best Practices

1. **Always use TypeScript** for better type safety
2. **Prefer array syntax** for classes with conditions or long strings
3. **Use proper typing** for all props and state with destructuring
4. **Leverage Svelte 5 runes** ($state, $derived, $effect, $props)
5. **Keep components focused** on single responsibilities
6. **Use semantic HTML** elements
7. **Implement proper error handling** with try-catch blocks
8. **Follow consistent naming conventions** (kebab-case for files, PascalCase for components)

## Migration Notes

If migrating from older versions:
- Replace `export let` with `$props()` using destructuring
- Replace `$:` with `$derived` or `$effect`
- Replace `let` reactive statements with `$state`
- Update event handling to use modern syntax
- Replace slots with snippets using `{@render}`

## Testing

Always test your components:
```bash
npm run test        # Run unit tests
npm run test:ui     # Run tests with UI
npm run build       # Test production build
```
