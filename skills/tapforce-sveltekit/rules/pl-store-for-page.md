---
title: pl-store-for-page
description: use store to serve single page
---

## Create and init store at same level of the page that store only serve.

When need create a store that provide data and values only be used by a page, create store at same level of the page that store only serve.

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
