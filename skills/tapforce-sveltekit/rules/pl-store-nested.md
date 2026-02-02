---
name: pl-store-nested
description: practice use store inside other store
---

Follow this rule when need reference or modify value from other store (store B) from inside current store (store A).

## Kinds of store can be used inside other store

- Global stores: stores defined and inited at top layout of application
- Parent stores: stores define and inited at closest parent layout of current store. Usually called `ParentStore`.

## How references defined

- define store want to be used as constructor parameters, prefix with `private` syntax.
- Set default constructor parameter by calling `useStore*` function.
- add same parameter to `createStore*` function and pass params to `new Store()`.

**Example: define store**

```typescript
import { useApp } from "$lib/stores/app";

const sid = Symbol("store");

// where: [app] is application store
export class Store {
  constructor(private app: App = useApp()) {}
}

export const createStore = (app?: App) => {
  return setContext(sid, new Store(app));
};
```

## Parent store

A store can be used as parent store by cloest child layout/page.

If parent store (store B) is only one store of parent layout, the `parent` word need prepend to property name assigned, the import line:

**Example**

```typescript
import {useStore as useParentStore} from "./parent-store";

export class Store {
    constructor(private parentStore: ParentStore = useParentStore()) {}
}
```