---
title: pl-undestructuring-store
description: avoid destructuring store instance
tags:
  - sveltekit
  - svelte5
  - store
---

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
