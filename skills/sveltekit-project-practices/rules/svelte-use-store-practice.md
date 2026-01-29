---
title: Use store in components
description: Guide to use store in effective way.
tags: sveltekit, svelte5, store
---

## Initialize store at page scope

- Prefer use store provider component hold create store instance, separate store logic from page logic.
- Create new svelte component with name `store-provider.svelte` under same folder with the page it binned to.
- In `store-provider.svelte`, import `createStore` function from store file.
- Define prop children that be slot content.
- Only define additional subscribes, listeners, or reactive blocks need for update store value, no UXUI logic.

**Example store-provider.svelte**

```svelte
<script>
  import { createStore } from './store.svelte';
  import type { Snippet } from 'svelte';

  let { children }: { children: Snippet } = $props();

  // create a new instance of store
  const store = createStore();
</script>

{@render children()}
```

- Use provider component at the page or component of page want to implement store.

**Example use store-provider.svelte**

```svelte
<script>
  import StoreProvider from './store-provider.svelte';
</script>

<StoreProvider>
  <div>
    <h1>Hello World</h1>
  </div>
</StoreProvider>
```

## Avoid destructuring store instance in component

- When use store in component, avoid destructuring store instance in component.
- Assign store instance to a const variable, keep reference from const whenever use properties or methods.
- Const variable name should match with store name:
  - `useStore` -> `const store = useStore();`
  - `useApp` -> `const app = useApp();`

**Incorrect:**

```svelte
<script>
  import { useStore } from './store.svelte';

  // destructuring store instance
  const { count, doubleCount } = useStore();
</script>

<h1>{count} x 2 = {doubleCount}</h1>
```

**Correct:**

```svelte
<script>
  import { useStore } from './store.svelte';

  // assign store instance to a const variable
  const store = useStore();
</script>

<h1>{store.count} x 2 = {store.doubleCount}</h1>
```
