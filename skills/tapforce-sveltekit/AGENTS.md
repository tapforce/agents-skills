---
name: tapforce-sveltekit
description: Comprehensive guide for using SvelteKit in Tapforce projects.
---

# tapforce-sveltekit

Guide & best practices for using SvelteKit in Tapforce projects.

## When to use

Use this skill when user tell `tapforce` word, and request use SvelteKit, or when project need use SvelteKit to build web application.

## Instructions

Skill separated to rules under `./rules` with prefix, following priority:

| Priority | Rule    | prefix | Description                                              |
| -------- | ------- | ------ | -------------------------------------------------------- |
| 1        | prepare | `pr`   | Steps and practices to prepare project to use SvelteKit. |
| 2        | policy  | `pl`   | Practices to follow when use SvelteKit.                  |

Each rules have own name, description, and tags.
Rule can include **Incorrect**, **Correct**, or **Example** code block.

Full version of skill and rules represent with file AGENTS.md.

---
# pr-version | File: rules/pr-version.md

Understand what oldest Sveltekit version should be supported

sveltekit, version

## Only work with SvelteKit v2 or higher.

Carefully checking version of Sveltekit and Svelte from `package.json` after install.

- Sveltekit version must >= 2.0.0
- Svelte version must >= 5.0.0

If version of any package not meet above requirement, stop flow and asking user should manually update version of package.
---
# pr-setup | File: rules/pr-setup.md

Steps and practices to prepare project to use SvelteKit.

sveltekit, setup

## check project codebase, ensure it has `sveltekit` package installed.

Read the `package.json` file, check if `sveltekit` package is installed.

If `sveltekit` package is not installed in `package.json`, stop flow and asking user should manually install `Sveltekit` or start new project from scratch.

If `package.json` not exist, start new project with Sveltekit following document at: https://svelte.dev/docs/kit/creating-a-project.

Use package manager to user prefer to install Sveltekit. If user not specify, use `pnpm` as default.

When install via command, carefully check the path to root project. If current folder is root of project then command should replace project name to `.`:

**Example:**

```sh
pnpx sv create . # mean: install to current folder
```

If user specify path to root project, make sure it is absolute path.

```sh
pnpx sv create [path to root project] # root project is path to sub-folder of current folder
```

When install, Sveltekit command will show prompt, let's user answer prompts and install related packages user choosed.

## Reference

- [SvelteKit - Creating a project](https://svelte.dev/docs/kit/creating-a-project)
---
# pl-use-component-props | File: rules/pl-use-component-props.md

Guide correct way to define props in svelte 5 component.

sveltekit, svelte5, props, component

## Define props in svelte 5 component

- Avoid define component props by `export let propName: PropType;` (svelte 4).
- Always choose define component props following svelte 5 structure.
- Use `$props()` to get props in component.
- Always define typescript type for props.
- props need use destructuring assignment to get props value.
- props need use typescript type annotation to get props value.
- If prop is 2-ways binding, need use `$bindable(value)` as default value.
- If prop has default value, define type is optional use `?` to allow undefined value.

```svelte
<script>
  let { propName = defaultValue }: { propName?: PropType } = $props();
</script>
```

- Whenever need define slot props (snippet) need define with Svelte typescript `Snippet<>`.

```svelte
<script>
    import type { Snippet } from 'svelte';
    let { propName = defaultValue }: { propName?: Snippet<PropType> } = $props();
</script>
```

- Use `{@render propName()}` to render slot props.
- file `+layout.svelte` always define `{@render children()}` to render slot content, along with define prop `children` with type `Snippet`.

```svelte
<script>
    import type { Snippet } from 'svelte';
    let { children }: { children?: Snippet } = $props();
</script>

{@render children()}
```
---
# pl-undestructuring-store | File: rules/pl-undestructuring-store.md

avoid destructuring store instance

sveltekit, svelte5, store

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
---
# pl-store-nested | File: rules/pl-store-nested.md

practice use store inside other store

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
---
# pl-store-for-page | File: rules/pl-store-for-page.md

use store to serve single page

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
---
# pl-store-class | File: rules/pl-store-class.md

Best practice to define store in Sveltekit

sveltekit, store, class

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
---
# pl-reactive-variable | File: rules/pl-reactive-variable.md

Understand how to use reactive variable in SvelteKit

sveltekit, reactive-variable, $state, $derived

## always use $state and $derived to define reactive variable

- Use Rune mode for reactive variables whenever possible.
- Avoid using `$:` prefix for reactive variables.
- Avoid use `store` functions (`writable`, `readable`...) except really need for advance abstracts.
- Use `$state()` for variable mutatable.
  ex:

**Incorrect:**

```svelte
<script>
  let count = 0;
  let doubleCount = count * 2;
</script>

{count} x 2 = {doubleCount}
```

**Correct:**

```svelte
<script>
  let count = $state(0);
  let doubleCount = $derived(count * 2);
</script>

{count} x 2 = {doubleCount}
```

## Reference

- https://svelte.dev/blog/runes
---
# pl-condition-class-attr | File: rules/pl-condition-class-attr.md

Understand how to use condition class attribute in SvelteKit

sveltekit, condition class attr, array class

- Always use array to store condition class attribute in svelte component.
- each condition take one line in array.
- use ternary operator to define condition class. ex: `isActive ? 'bg-black text-white' : 'bg-white text-black'`
- use `??` if condition only check true/false. ex: `true ?? 'bg-black text-white'`

**Incorrect:**

```svelte
<div class="bg-white text-black {isActive ? 'bg-black text-white' : 'bg-white text-black'}">
</div>
```

**Correct:**

```svelte
<div class={[
    'bg-white text-black',
    'p-4 rounded-md shadow-md',
    isActive ? 'bg-black text-white' : 'bg-white text-black'
]}>
</div>
```
---
# pl-break-long-class-attr | File: rules/pl-break-long-class-attr.md

Understand how to break long class attribute to multi line in SvelteKit

sveltekit, svelte5, class, style

- when a html tag need define long `class=""` attribute, break into multi string and store in array.
- string length should be short and meanful, but not break into single class per line.

**Incorrect:**

```html
<div
  class="bg-white text-black p-4 rounded-md shadow-md flex items-center justify-center"
></div>
```

**Correct:**

```svelte
<div class={[
  'bg-white text-black',
  'p-4 rounded-md shadow-md',
  'flex items-center justify-center'
]}>
</div>
```

Reference: https://svelte.dev/docs/svelte/class
