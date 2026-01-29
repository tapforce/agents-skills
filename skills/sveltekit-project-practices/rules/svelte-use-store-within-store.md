---
title: Use store within other store
description: Practice use a store inside sub-store in svelte.
---

When need use variable or method from a store from inside current store, need:

- define store want to be used as constructor parameters, prefix with `private` syntax.
- Set default constructor parameter by calling `useStore*` function.
- add same parameter to `createStore*` function and pass params to `new Store()`.

**Example define store**

```typescript
import { useApp } from '$lib/stores/app';

const sid = Symbol('store');

// where: [app] is application store
export class Store {
    constructor(private app: App = useApp()) {
    }
}

export const createStore = (app?: App) => {
    return setContext(sid, new Store(app));
}
```