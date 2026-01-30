---
name: sveltekit-project-practices
description: Guideline setup and develop application base on SvelteKit, tailwindcss, shadcn-svelte framework.
metadata:
  author: Tapforce<office@tapforce.com>
  version: "1.0.0"
---

# SvelteKit Project Practices

Comprehensive guide setup and develop application base on SvelteKit, tailwindcss, shadcn-svelte framework.

## When to apply

Reference these guidelines when:

- Start or develop a project application with Sveltekit, Tailwindcss, Shadcn-svelte as base framework.

## Rule Categories by Priority

| Priority | Category | Prefix    | Description                                                       |
| -------- | -------- | --------- | ----------------------------------------------------------------- |
| 1        | setup    | `setup-`  | Set up project with base packages, modules, or frameworks.        |
| 2        | styling  | `style-`  | Practices styling application with Tailwindcss and shadcn-svelte. |
| 3        | Svelte   | `svelte-` | Practices using Sveltekit features.                               |
| 4        | Abstract | `abs-`    | Abstract practices for Sveltekit project.                         |

## Quick Reference

## How to Use

Read individual rule files for detailed explanations and code examples:

```
rules/async-parallel.md
rules/bundle-barrel-imports.md
```

Each rule file contains:

- Brief explanation of why it matters
- Incorrect code example with explanation
- Correct code example with explanation
- Additional context and references

## Full Compiled Document

For the complete guide with all rules expanded: `AGENTS.md`


---
# File: rules/svelte-use-store-within-store.md
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
---
# File: rules/svelte-use-runes.md
---
title: Use runes mode in svelte 5
description: Guide to use runes correct way in Svelte 5.
tags: sveltekit, svelte5, runes
---

## Always use runes mode in svelte 5

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
# File: rules/svelte-undestructuring-store.md
---
title: Avoid destructuring store instance in component
description: When use store in component, avoid destructuring store instance in component. Assign store instance to a const variable, keep reference from const whenever use properties or methods.
tags: sveltekit, store, practice
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

---
# File: rules/svelte-page-store-gathering.md
---
title: Gathering data under store of page
description: Guide to write and manage data sharing cross components within a page or shared cross multi level of page in svelte.
tags: sveltekit, svelte5, runes, store, data-gathering
---

## Gether state and derived values into store life witin page lifecycle

When page structure become complex with multi component (sibling or nested under page) and having states/derived values that need to be shared cross components, it's a good idea to gather them into a single store.

A store of page (call it `page store`) need satisfy following requirements:

- Store hold all states and derived values that need to be shared cross components within a page.
- Store instance stored inside Svelte's context feature, with key is `sid` (symbol).
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

---
# File: rules/svelte-keep-store-within-page.md
---
title: Keep store at page scope
description: Prefer use store provider component hold create store instance, separate store logic from page logic.
tags: sveltekit, svelte5, store
---

## Keep store at page scope

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
# File: rules/svelte-condition-class.md
---
title: Use svelte class value (array) for define long, complex class name
description: Use array to store multi lines of css class when need define long, condition class name in html.
tags: sveltekit, svelte5, class, style
---

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
# File: rules/svelte-component-props-define.md
---
title: Define props in svelte 5 component
description: Guide correct way to define props in svelte 5 component.
tags: sveltekit, svelte5, props, component
---

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
# File: rules/svelte-break-long-class-attr.md
---
title: Break long class attribute to multi line
description: use svelte 5 feature to break long string class attribute html to multi line via array
tags: sveltekit, svelte5, class, style
---

## break long class attribute to multi line

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

---
# File: rules/style-use-tailwindcss-utility-block.md
---
title: Use `@utility` block when need define custom class
description: Guide correct way to make style application with Tailwindcss and it's classes.
tags: sveltekit, svelte5, tailwindcss, styling
---

## Use `@utility` block when need define custom class

When need to define custom class, following instruction of tailwindcss version 4 that only use css to define custom class.

```css
@utility text-lead {
  /* re-use built-in tailwindcss classes */
  @apply text-lg text-primary;
  /* define plain css */
  line-height: 1.5;
}

/* use .text-lead to apply style */
```

---
# File: rules/style-define-custom-global-css.md
---
title: Define global custom style within `@layer base`
description: Guide correct way to make style application with Tailwindcss and it's classes.
tags: sveltekit, svelte5, tailwindcss, styling
---

## Define global custom style within `@layer base`

When need to define global custom style, following instruction of tailwindcss version 4 that only use css to define global custom style.

```css
@layer base {
  /* define global custom style */
  .text-lead {
    @apply text-lg text-primary;
    line-height: 1.5;
  }
}
```
---
# File: rules/style-common-tailwindcss-usage.md
---
title: Common Tailwindcss Usage
description: Common tailwindcss usage that must follow tailwind version 4.
tags: sveltekit, svelte5, tailwindcss, styling
---

## All tailwindcss configuration must following tailwind version 4

When need to change default tailwindcss configuration, following instruction of tailwind version 4 that only use css to define configuration.

## Set cursor pointer to button by default

If project implemented shadcn library, add style default cursor-pointer to button in css file if it not added yet:

```css
@layer base {
  /* force cursor pointer on buttons */
  button:not(:disabled),
  [role="button"]:not(:disabled) {
    cursor: pointer;
  }
}
```

## Prefer use tailwindcss classes to present custom UI

## use arbitraty values to present custom UI

- When need add custom css style, use class customize strategy from tailwindcss, avoid use inline css style.
- Reference: https://tailwindcss.com/docs/styling-with-utility-classes#using-arbitrary-values
- Reference: https://tailwindcss.com/docs/adding-custom-styles#arbitrary-properties
- Reference: https://tailwindcss.com/docs/adding-custom-styles#arbitrary-variants

---
# File: rules/shadcn-use-snippet.md
---
title: use svelte snippet with shadcn component
description: Use svelte snippet (svelte 5 feature) with shadcn component to avoid duplicate code.
tags: sveltekit, shadcn, snippet
---

Use svelte snippet (svelte 5 feature) with shadcn component to avoid duplicate code. Make sure you installed shadcn svelte version support Svelte 5.

**Example:**

```svelte
<script lang="ts">
 import * as DropdownMenu from "$lib/components/ui/dropdown-menu/index.js";
 import { Button } from "$lib/components/ui/button/index.js";
</script>
 
<DropdownMenu.Root>
 <DropdownMenu.Trigger>
  {#snippet child({ props })}
   <Button {...props} variant="outline">Open</Button>
  {/snippet}
 </DropdownMenu.Trigger>
```

---
# File: rules/shadcn-untouch-components.md
---
title: Unchange shadcn components code
description: Never change shadcn components code, keep them origin as it is to support update/overwrite when shadcn release new version.
tags: sveltekit, shadcn, components
---

## Avoid change code of shadcn components

When shadcn component installed to project, never change their code, keep them origin as it is to support update/overwrite when shadcn release new version.

---
# File: rules/shadcn-style-consistent.md
---
title: Consistent Shadcn Style Guide
description: Keep shadcn's style consistent with project's style guide.
tags: sveltekit, shadcn, style
---

After install Shadcn svelte to project, it shipped with default style defined in `/src/routes/layout.css`. Depend on project requirement, you can override the style include:

- Update shadcn color config inside `layout.css`, respect color value scheme (default is oklch()).
- respect color scheme format: oklch() with 3 values: lightness, chroma, hue. Values separate by space.
- Understand and update color correct with the scope that color variable used in scadcn components.
ex:
    `--foreground` applied to text color default, button variant default etc.

## always customize shadcn style or add new css variable in separate `:root` and `.dark` block:

**Example:**

```css
:root {
    /* default shadcn style */
    --foreground: oklch(0.145 0 0);
}

.dark {
    --foreground: oklch(0.985 0 0);
}

/* customize color */
:root {
  --foreground: oklch(0.145 1 1);
}

.dark {
    --foreground: oklch(0.985 1 1);
}



---
# File: rules/setup-tools.md
---
title: Setup tools
description: Review and suggest setup tools for project development.
tags: setup, tools
---

## Node.js

- Developer machine must install Node.js version 20 or higher.
- use `node -v` to check Node.js version.
- If current version < 20 then show message suggest install Node.js version 20 or higher.
- Reference: https://nodejs.org/en/download

## PNPM

- Developer machine must install PNPM package manager.
- PNPM version must be 10 or higher.
- use `pnpm -v` to check PNPM version.
- If PNPM is not installed then show message suggest install PNPM.
- If PNPM version < 10 then show message suggest upgrade PNPM to version 10 or higher.
- Reference: https://pnpm.io/installation
- Using `pnpm` for all commands related to package management. If command mention about `npm`, `yarn`.. then replace with `pnpm`.

## MoonRepo

- When application required setup following mono-repo structure, developer must install MoonRepo package manager.
- Reference: https://moonrepo.dev/docs/install
- Choose install MoonRepo via `pnpm`: https://moonrepo.dev/docs/install#npm


---
# File: rules/setup-sveltekit.md
---
title: Set up SvelteKit Framework for New Project
description: Step by step set up SvelteKit framework to a folder as base for new project.
tags: sveltekit, framework, setup, infrastructure
---

## Use common, extractly command to install SvelteKit.

- Install SvelteKit direct to current folder, use extractly command: `pnpx sv create .`.
- Sveltekit should installed to current folder, not create new sub-folder for project.
- Dont append more arguments to command, keep use correct command: `pnpx sv create .`.
---
# File: rules/setup-packages-base.md
---
title: Setup packages base
description: Review and suggest setup packages base for project development.
tags: setup, packages
---

## Install packages via `pnpm`.

always try install project packages via `pnpm`.

- Install SvelteKit packages via `pnpm`. Use command: `pnpm install`.
- When terminal prompt approve build, suggest developer run `pnpm approve-build`.

## Create environment file

- Create file `.env.local` at root folder of project. Define pair key=value below:
- Reference: https://svelte.dev/docs/kit/creating-a-project

```bash
NODE_ENV=local
```

## Create pnpm workspace file

- Create file `pnpm-workspace.yaml` at root folder of project. Define content below:

```yaml
packages:
  - "."
```

## Tailwindcss

- Reference: https://tailwindcss.com/docs/installation/framework-guides/sveltekit
- Validate current project, if `package.json` has tailwincss package then skip, if not then install tailwindcss following official documentation.
- Make sure tailwindcss version must 4 or higher.
- Avoid use tailwind config file, since tailwindcss version 4 use single css file as config and definition.
- Main css file should be `src/routes/layout.css` include tailwindcss default config and custom styles in future.
- No use postcss config file, since tailwindcss version 4 use single css file as config and definition.

## Shadcn Svelte

- Reference: https://www.shadcn-svelte.com/docs/installation/sveltekit
- Use command: `pnpm dlx shadcn-svelte@latest init` to initialize shadcn-svelte in current project.
- Follow the guide to install shadcn-svelte packages.
- Pre-install default packages used almost of time. Each component installed need following individual official documentation page:
  - `Alert Dialog`: https://www.shadcn-svelte.com/docs/components/alert-dialog1
  - `Alert`: https://www.shadcn-svelte.com/docs/components/alert
  - `Button`: https://www.shadcn-svelte.com/docs/components/button
  - `Card`: https://www.shadcn-svelte.com/docs/components/card
  - `Sonner`: https://www.shadcn-svelte.com/docs/components/sonner
- If component's documentation mention extra setup steps, follow the steps to setup component in current project.

## tiny-invariant

- Reference: https://www.npmjs.com/package/tiny-invariant
- Install tiny-invariant package via `pnpm`. Use command: `pnpm add -D tiny-invariant`.

---
# File: rules/code-predict-truly.md
---
title: Validate truly value
description: Guide to validate a value predict truly in code.
tags: typescript, exception, error, validate, tiny-invariant, truly
---

## use tiny-invariant for check and throw exception/Error

- Use tiny-invariant whenever checking value predict truly that no care about catch the exception.
- Avoid check with `if` statement and throw Error manually.

**Incorrect:**

```typescript
function divide(a: number, b: number): number {
  if (b === 0) {
    throw new Error("Divisor must not be zero");
  }
  return a / b;
}
```

**Correct:**

```typescript
import { invariant } from "tiny-invariant";

function divide(a: number, b: number): number {
  invariant(b !== 0, "Divisor must not be zero");
  return a / b;
}
```

## Reference:

- https://www.npmjs.com/package/tiny-invariant

