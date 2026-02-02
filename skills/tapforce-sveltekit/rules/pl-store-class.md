---
name: pl-store-class
description: Best practice to define store in Sveltekit
tags:
  - sveltekit
  - store
  - class
---

## When use store

When data in a page become complex and need share cross components at any nested level, gather data into a `store`.

## A store should be a JS class

A `store` is a JS class that initialized (new Class) and store in `svelte context`.

- Create new file name `store.svelte.ts` under same folder with the page it binned to.
- export a class named `Store` that hold all data.
- Use `$state()` for variable mutatable, assign as property.
- Use `$derived()` for variable derived from other variables, assign as property.
- Define class method as shared function.
- Avoid use constructor as place to initialize data, use `createStore()` function to initialize data.

**Example class store**

```typescript
export class Store {
  count = $state(0);
  doubleCount = $derived(this.count * 2);

  increment() {
    this.count++;
  }
}
```

## createStore() function

- `createStore()` function exported from store file, represent logics to create a new instance of store via `setContext` function.
- `createStore()` function should call at the page scope want store available (ex: `+page.svelte`, `+layout.svelte`, `store-provider.svelte`), outside any reactive block.
- If store need adding logics (ex: fetching data, listen changes from outside to update store's value...) then define within `createStore()` function.

**Example createStore() function**

```typescript
import { setContext } from "svelte";

const sid = Symbol("store");

/* class store define in store.svelte.ts */

// create a new instance of store
export function createStore() {
  const store = new Store();
  setContext(sid, store);
  return store;
}
```

**Example use createStore() function**

```typescript
// +page.svelte, +layout.svelte, store-provider.svelte
import { createStore } from "./store.svelte";

// create a new instance of store
const store = createStore();
```

## useStore() function

- `useStore()` function exported from store file.
- Use `useStore()` function to get the store instance at any component within the page.

**Example useStore() function**

```typescript
import { getContext } from "svelte";
import invariant from "tiny-invariant";

/* class store define in store.svelte.ts */

// use the store instance
export function useStore() {
  const store = getContext("store");
  invariant(store, "Store context not found");
  return store;
}
```

## Create store used cross multi level of page.

When a store must shared cross multi level of page, ex: application store, authentication store, etc:

- Move store to define at folder `[root project]/lib/stores`.
- Set file name match with scope's title that store serves to, example:
  - `app.svelte.ts`: application store
  - `auth.svelte.ts`: authentication store
  - `acl.svelte.ts`: access control list store
- Rename js class to match with file name, example:
  - `App` for `app.svelte.ts`
  - `Auth` for `auth.svelte.ts`
  - `Acl` for `acl.svelte.ts`
- Rename `createStore` and `useStore` match with name conversion:
  - `createApp` for `app.svelte.ts`
  - `createAuth` for `auth.svelte.ts`
  - `createAcl` for `acl.svelte.ts`