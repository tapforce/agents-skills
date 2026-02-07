---
name: modern-features
description: Rules for using Svelte ^5 and SvelteKit ^2 modern features
---

# Modern Features Rules

## Svelte ^5 Modern Features

### Required Modern Features

**ALWAYS** use these Svelte ^5 features in new code:

#### Reactive State
```svelte
<script>
  // Modern Svelte 5 syntax
  let count = $state(0);
  
  function increment() {
    count += 1;
  }
</script>

<button onclick={increment}>
  Count: {count}
</button>
```

#### Modern Event Handling
```svelte
<script>
  // Modern Svelte 5 event handling
  let count = $state(0);
  
  function increment() {
    count += 1;
  }
  
  function handleSubmit(event) {
    event.preventDefault();
    console.log('Form submitted');
  }
  
  function handleInput(event) {
    console.log('Input value:', event.target.value);
  }
</script>

<!-- Modern event syntax -->
<button onclick={increment}>Click me</button>
<form onsubmit={handleSubmit}>...</form>
<input oninput={handleInput} />
<div onmouseover={() => console.log('Hovered')}>Hover me</div>
```

#### Effects
```svelte
<script>
  let data = $state([]);
  
  // Modern effect syntax
  $effect(() => {
    console.log('Data changed:', data);
  });
</script>
```

#### Inspection
```svelte
<script>
  let value = $state('test');
  
  // Modern inspection
  $inspect(value);
</script>
```

### Legacy Features to Avoid

**NEVER** use these deprecated features:

#### Old Reactive Syntax
```svelte
<!-- WRONG - Legacy syntax -->
<script>
  export let count = 0;
  
  $: doubled = count * 2;
</script>
```

#### Old Event Handling Syntax
```svelte
<!-- WRONG - Legacy event syntax -->
<button on:click={handleClick}>Click me</button>
<form on:submit={handleSubmit}>...</form>
<input on:input={handleInput} />
<div on:mouseover={handleHover}>Hover me</div>
```

#### Old Store Syntax
```svelte
<!-- WRONG - Legacy store pattern -->
<script>
  import { writable } from 'svelte/store';
  
  let count = writable(0);
</script>
```

### Correct Migration Examples

#### From Legacy to Modern
```svelte
<!-- Legacy (WRONG) -->
<script>
  export let name = '';
  $: greeting = `Hello, ${name}!`;
</script>

<!-- Modern (CORRECT) -->
<script>
  let name = $state('');
  let greeting = $derived(`Hello, ${name}!`);
</script>
```

## SvelteKit ^2 Modern Features

### Routing Modernization

#### File-Based Routing
Use SvelteKit ^2 file-based routing patterns:

```
src/routes/
├── +page.svelte          # Root page
├── about/
│   └── +page.svelte      # About page
├── blog/
│   ├── [slug]/
│   │   └── +page.svelte  # Dynamic blog post
│   └── +page.svelte      # Blog listing
└── api/
    └── posts/
        └── +server.ts    # API endpoint
```

#### Layout Modernization
```svelte
<!-- src/routes/+layout.svelte -->
<script>
  import { enhance } from '$app/forms';
</script>

<main>
  <slot />
</main>

<style>
  main {
    max-width: 1200px;
    margin: 0 auto;
    padding: 2rem;
  }
</style>
```

### Modern Form Handling

#### Progressive Enhancement
```svelte
<script>
  import { enhance } from '$app/forms';
  
  let { form } = $props();
</script>

<form method="POST" use:enhance>
  <input name="message" value={form?.message || ''} />
  <button type="submit">Send</button>
</form>
```

### Modern State Management

#### Universal State
```svelte
<!-- src/lib/stores/user.svelte.ts -->
<script lang="ts">
  import { browser } from '$app/environment';
  
  let user = $state(null);
  
  export function setUser(userData) {
    user = userData;
    if (browser) {
      localStorage.setItem('user', JSON.stringify(userData));
    }
  }
  
  export function getUser() {
    return user;
  }
</script>
```

## Feature Adoption Checklist

### Svelte ^5 Features
- [ ] Use `$state()` instead of `export let`
- [ ] Use `$effect()` instead of `$:`
- [ ] Use `$derived()` for computed values
- [ ] Use `$inspect()` for debugging
- [ ] Use modern event handlers (`onclick`, `onsubmit`, etc.)
- [ ] Avoid legacy event handlers (`on:click`, `on:submit`, etc.)
- [ ] Avoid legacy reactive statements

### SvelteKit ^2 Features
- [ ] Use modern file-based routing
- [ ] Implement progressive enhancement
- [ ] Use modern form handling with `enhance`
- [ ] Leverage universal state patterns
- [ ] Follow modern layout patterns

## Migration Guidelines

### Upgrading from Svelte ^4

1. **Replace reactive statements**:
   ```svelte
   // Old
   $: value = computed();
   
   // New
   let value = $derived(computed());
   ```

2. **Update component props**:
   ```svelte
   // Old
   export let prop = 'default';
   
   // New
   let { prop = 'default' } = $props();
   ```

3. **Migrate effects**:
   ```svelte
   // Old
   $: console.log(value);
   
   // New
   $effect(() => console.log(value));
   ```

4. **Update event handlers**:
   ```svelte
   // Old
   <button on:click={handleClick}>Click</button>
   <form on:submit={handleSubmit}>...</form>
   
   // New
   <button onclick={handleClick}>Click</button>
   <form onsubmit={handleSubmit}>...</form>
   ```

### Upgrading from SvelteKit ^1

1. **Update routing structure** if needed
2. **Migrate form handling** to use `enhance`
3. **Update layout patterns** for modern syntax
4. **Adopt new error handling** patterns

## Testing Modern Features

### Feature Detection
```typescript
// Test for Svelte ^5 features
if (typeof $state !== 'undefined') {
  // Modern Svelte available
}

// Test for SvelteKit ^2 features
import { version } from '@sveltejs/kit';
if (version.startsWith('2.')) {
  // Modern SvelteKit available
}
```

### Compatibility Testing
Always test code with:
- Latest Svelte ^5 and SvelteKit ^2
- Modern browsers
- Different deployment environments
