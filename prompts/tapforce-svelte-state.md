add or correct skill `tapforce-sveltekit-v2-state`

This skill guide correct way to use `store` strategy to gather data/state and share cross component level or page in sveltekit project. It use `svelte context` idea to store and retrieve data/state.

## Use this skill when:

- data/state on page or code structure become complex and need to gather data in a place to share cross component level or page.
- project require use `store` idea requested by user.
- a module, component need share state/data cross component level or page.
- high abstract data flow require centerlize state in one place and share to all sub-routes, example: `Authentication` state, `ALC` state, `Application` state.

## requirement

- project use `sveltekit v2` and `svelte v5`.
- project use `typescript`.

## before use skill, need:

- You MUST always respect other skills used in project that related to technicals, frameworks, or libraries. Keep in mind this skill is practices that guide you write code in correct way and consistency.
- When you started to use this skill, skill/rules within this skill MUST consistent cross the project, no exception.

## store structure:

- A store object is a JS Class defined in separate ts file. Class can assign `$state`, `$derived`, static value, other store instance, methods, etc.
- A store class designed focus to a single abstract. Ex: `Auth` store design focus on authenticate tasks.
- Class name and place where class file placed depend on purpose of store.
  1. If store store state of single route, define class with name `Store` and place in same route folder.
  2. If store store state of abstract (`Auth`, `App`, etc) define class with name match with abstract name, place in folder `/src/lib/<abstract name>/store.ts`.
- A store class use svelte context feature to store and share class instance. Use `setContext(sid, instance)` to init class instance with setup code, use `getContext(sid)` to retrieve class instance.
- A store require define unique `sid` variable and use it to init/retrieve class instance via context. `sid` MUST be `Symbol('<abstract name>')`.

### store snippet

**Example store class**

```typescript
export class Store {
  stateValue = $state(0);
  derivedValue = $derived(this.stateValue);

  static referenceParentStore = new ParentStore();

  method() {
    this.stateValue += 1;
  }
}

const sid = Symbol('Store');

export const createStore() {
    // define one-time set up code need for store instance.
    // example: define static value, define static method, define static property, define reactive update store value by listener, etc.

    return setContext(sid, new Store());
}

export const useStore() {
    const store = getContext(sid) as Store;
    if (!store) {
        throw new Error('<abstract name> store not found');
    }
    return store;
}
```

### store functions:

Store require 2 function `create<abstract name>`(A) and `use<abstract name>`(B) for init and retrieve store instance.

- `create<abstract name>`(A): function define one-time set up code need for store instance. Return store instance.
- `use<abstract name>`(B): function retrieve store instance. Return store instance.
- the `<abstract name>` should match the name of store targer designed.

Use function A to init store instance at page/layout. Store instance will be available at current route and all sub-routes.
Use function B to retrieve store instance at component level or page or sub-page, sub-layout, etc.

## Bias RULEs:

### `create<abstract name>`(A) function is only place can define pre-setup code need for store instance.

You MUST avoid define any pre-setup in class `constructor` or any other place except `create<abstract name>`(A) function.
the `create<abstract name>`(A) function allow define any svelte code include `$state`, `$derived`, `$effect`, etc as well as modify store value before assign to context.
Code inside `create<abstract name>`(A) function will run only once at page/layout init. And live within layout/page life-cycle that it called.

**Example: setup listen when page mount and remove when unmount**

```typescript
export const createStore() => {
    const store = new Store();

    $effect(() => {
        const onResize= () => {
            // code to run when resize
            store.value +=1;
        }

        window.addEventListener('resize', onResize); // listen resize event

        const unmount = () => {
            window.removeEventListener('resize', onResize); // remove resize event listener
        }
        return unmount;
    })

    return setContext(sid, store);
}
```

### `use<abstract name>`(B) function is only place can retrieve store instance.

You MUST add condition IF to checking store available before return store instance.

**Example:**

```typescript
export const useStore() {
    const store = getContext(sid) as Store;
    if (!store) {
        throw new Error('<abstract name> store not found');
    }
    return store;
}
```

### Never destructuring store instance

You MUST avoid destructuring store instance. When retrieve and use store instance, always reference from store object to target variable or method.

**Correct**

```svelte
<script lang="ts">
    import { useStore } from './store';
    const store = useStore();
    
    $effect(() => {
        store.value += 1; // assign value
        store.calculateDouble(); // call method
    })
</script>

<!-- reference reactive value -->
<span>{store.value}</span>
<span>{store.doubleValue}</span>
```

Generate incorrect sample.

### Always create `provider` component for init store.

- When attemp to init store in a layout/page, always create `provider` component and call create store inside.
- A `provider` component is svelte component include `create<abstract name>`(A) function, define props `children` and render children in body.
- `provider` component MUST keep simple, only define code related to store abstract. No other code.

**Example: page store provider**

```svelte
<script lang="ts">
    import { type Snippet, setContext } from 'svelte';
    import { createStore } from './store';

    interface Props {
        children: Snippet;
    }

    let { children }: Props = $props();

    const store = createStore();
</script>

{@render children()}
```

- `provider` component name MUST follow format `<abstract name>-provider.svelte`.
- `provider` component place depend on abstract target.
    1. if store is state of single page and store file placed same route folder. `provider` component also be placed same route folder.
    2. if store is high abstract that placed in `src/lib/<abstract name>/store.ts`.
        a. if store init only 1 route, place `provider` component same route folder.
        b. if store init multiple routes, place `provider` component to same store folder.
- set `provider` component inside layout/page or any component that definition as init scope of store. Use `provider` component to wrap children component that need use store.

**Example**

```svelte
<script lang='ts'>
    import { AuthProvider } from '$lib/auth/store-provider';

    interface Props {
        children: Snippet;
    }

    let { children }: Props = $props();
</script>

<AuthProvider>
    {@render children()}
</AuthProvider>