---
name: pl-store-for-page
description: use store to serve single page
---

## Create and init store at same level of the page that store only serve.

When need create a store that provide data and values only be used by a page, create store at same level of the page that store only serve.

- Prefer use store provider component hold create store instance, separate store logic from page logic.
- Create new svelte component with name `store-provider.svelte`.
- In `store-provider.svelte`, import `createStore` function from store file.
- Define prop children that be slot content.
- Only define additional subscribes, listeners, or reactive blocks need for update store value, no UXUI logic.

## Provider Component Placement Options

### Option A: Provider same folder with store file
Use this option when store is high scope (application, authenticate, acl) that consider init 1 time and share all routes.

**File structure:**
```
src/lib/stores/
├── auth.svelte.ts
└── auth-provider.svelte
```

**Example auth-provider.svelte**
```svelte
<script>
  import { createAuth } from './auth.svelte';
  import type { Snippet } from 'svelte';

  let { children }: { children: Snippet } = $props();

  // create a new instance of store
  const auth = createAuth();
</script>

{@render children()}
```

**Usage in root layout:**
```svelte
<script>
  import AuthProvider from '$lib/stores/auth-provider.svelte';
</script>

<AuthProvider>
  <!-- app content -->
</AuthProvider>
```

### Option B: Provider same folder with route page/layout
Use this option when consider store init multi time in separate route page or layout, and shared to use only route or sub-routes that it initialized.

**File structure:**
```
src/routes/dashboard/
├── +page.svelte
├── store.svelte.ts
└── store-provider.svelte
```

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

**Usage in page:**
```svelte
<script>
  import StoreProvider from './store-provider.svelte';
</script>

<StoreProvider>
  <div>
    <h1>Dashboard Page</h1>
  </div>
</StoreProvider>
```
