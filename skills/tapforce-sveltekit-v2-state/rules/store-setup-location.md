---
name: store-setup-location
description: Enforces that create function is the only place for pre-setup code
tags: [store, setup, svelte, context]
---

# Store Setup Location Rule

## Rule Statement

**ALWAYS** define pre-setup code only in the `create<abstract name>` function. **NEVER** define pre-setup code in class constructor or any other place.

## Rationale

The `create<abstract name>` function is specifically designed for one-time setup code that needs to run when the store instance is created. This ensures:

- Setup code runs only once at page/layout initialization
- Setup code lives within the layout/page lifecycle where it's called
- Clear separation between store definition and store initialization
- Proper access to Svelte's reactive system during setup

## What Constitutes Pre-Setup Code

Pre-setup code includes:
- Static value definitions
- Static method definitions  
- Static property definitions
- Reactive update listeners using `$effect`
- Event listeners setup
- Initial data fetching
- Store value modifications before context assignment

## Correct Implementation

```typescript
export const createStore() => {
    const store = new Store();

    // ✅ CORRECT: Pre-setup code here
    $effect(() => {
        const onResize = () => {
            store.value += 1;
        }

        window.addEventListener('resize', onResize);

        const unmount = () => {
            window.removeEventListener('resize', onResize);
        }
        return unmount;
    });

    // ✅ CORRECT: Initial value modification
    store.initialValue = computeInitialValue();

    return setContext(sid, store);
}
```

## Incorrect Implementation

```typescript
export class Store {
    constructor() {
        // ❌ INCORRECT: Pre-setup in constructor
        $effect(() => {
            // This won't work properly
        });
        
        window.addEventListener('resize', this.handleResize);
    }
}

export const createStore() => {
    // ❌ INCORRECT: No setup code here
    return setContext(sid, new Store());
}
```

## Enforcement

When implementing stores:
1. **ALWAYS** place all setup logic in the `create<abstract name>` function
2. **NEVER** put setup logic in class constructors
3. **NEVER** put setup logic in other methods or properties
4. **ALWAYS** use `$effect` for reactive setup within the create function
5. **ALWAYS** return cleanup functions from `$effect` when needed

## Benefits

- Predictable initialization timing
- Proper lifecycle management
- Clear separation of concerns
- Consistent behavior across all stores
