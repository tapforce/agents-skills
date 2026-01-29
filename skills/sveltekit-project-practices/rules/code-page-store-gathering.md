---
title: Gathering data under store of page
description: Guide to write and manage data sharing cross components within a page or shared cross multi level of page in svelte.
tags: sveltekit, svelte5, runes, store, data-gathering
---

## Gether state and derived values into store life witin page lifecycle

When page structure become complex with multi component (sibling or nested under page) and having states/derived values that need to be shared cross components, it's a good idea to gather them into a single store.

A store of page (call it `page store`) need satisfy following requirements:

- Store hold all states and derived values that need to be shared cross components within a page.
- Store must binned with page life-cycle, creted when page mount and remove when page unmount.
- A store must defined as a js class, export for type reference only.
- Store file must contains 2 functions:
  - `createStore()` : Create a new instance of store.
  - `useStore()` : Use the store instance.
- Each store should be only used by page or component of page at same level (same folder).
- Each store can be used by other store of child-pages that max 1 level deep.
- when store used by other store of child-page (called child-store), child-store must assign parent-store as property following:

**Example use parent store within child store or child page**

```typescript
import { useStore as useParentStore } from "./parent-store.svelte";

// child store
export class Store {
  parentStore = useParentStore();
}
```

## Create a store

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

## createStore()

- `createStore()` function exported from store file, represent logics to create a new instance of store via `setContext` function.
- `createStore()` function should call at the page scope want store available (ex: `+page.svelte`, `+layout.svelte`, `store-provider.svelte`), outside any reactive block.
- If store need adding logics (ex: fetching data, listen changes from outside to update store's value...) then define within `createStore()` function.

**Example createStore() function**

```typescript
import { setContext } from "svelte";

/* class store define in store.svelte.ts */

// create a new instance of store
export function createStore() {
  const store = new Store();
  setContext("store", store);
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

## useStore()

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
