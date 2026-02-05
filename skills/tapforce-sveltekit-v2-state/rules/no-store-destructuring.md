---
name: no-store-destructuring
description: Prevents destructuring of store instances to maintain reactivity
tags: [store, destructuring, reactivity, svelte]
---

# No Store Destructuring Rule

## Rule Statement

**NEVER** destructure store instances. **ALWAYS** reference from store object to target variables or methods.

## Rationale

Store destructuring breaks Svelte's reactivity system because:

- `$state` and `$derived` properties lose their reactivity when destructured
- Store methods become disconnected from the reactive instance
- Component updates are not triggered when store values change
- Debugging becomes difficult due to detached references

## Correct Usage Pattern

```svelte
<script lang="ts">
    import { useStore } from './store';
    const store = useStore();
    
    $effect(() => {
        store.value += 1; // ✅ CORRECT: Direct reference
        store.calculateDouble(); // ✅ CORRECT: Method call
    })
</script>

<!-- ✅ CORRECT: Reference reactive values -->
<span>{store.value}</span>
<span>{store.doubleValue}</span>
```

## Incorrect Usage Patterns

### Property Destructuring
```svelte
<script lang="ts">
    import { useStore } from './store';
    const store = useStore();
    
    // ❌ INCORRECT: Property destructuring
    const { value, doubleValue } = store;
    
    $effect(() => {
        value += 1; // This won't trigger reactivity
    })
</script>

<!-- ❌ INCORRECT: Destructured values -->
<span>{value}</span> <!-- Won't update when store changes -->
<span>{doubleValue}</span> <!-- Won't update when store changes -->
```

### Method Destructuring
```svelte
<script lang="ts">
    import { useStore } from './store';
    const store = useStore();
    
    // ❌ INCORRECT: Method destructuring
    const { calculateDouble, updateData } = store;
    
    $effect(() => {
        calculateDouble(); // Method loses store context
    })
</script>
```

### Mixed Destructuring
```svelte
<script lang="ts">
    import { useStore } from './store';
    
    // ❌ INCORRECT: Complete destructuring
    const { value, loading, error, loadData, reset } = useStore();
</script>
```

## Reactive Property Examples

### $state Properties
```typescript
export class Store {
  value = $state(0);
  loading = $state(false);
  user = $state<User | null>(null);
}

// ✅ CORRECT: Direct access
const store = useStore();
console.log(store.value); // Reactive
console.log(store.loading); // Reactive

// ❌ INCORRECT: Destructuring
const { value, loading } = useStore();
console.log(value); // NOT reactive
console.log(loading); // NOT reactive
```

### $derived Properties
```typescript
export class Store {
  value = $state(0);
  doubled = $derived(this.value * 2);
  isValid = $derived(this.value > 0);
}

// ✅ CORRECT: Direct access
const store = useStore();
console.log(store.doubled); // Reactive
console.log(store.isValid); // Reactive

// ❌ INCORRECT: Destructuring
const { doubled, isValid } = useStore();
console.log(doubled); // NOT reactive
console.log(isValid); // NOT reactive
```

## Method Access Patterns

### Instance Methods
```typescript
export class Store {
  value = $state(0);
  
  increment() {
    this.value += 1;
  }
  
  calculateTotal() {
    return this.value * 2;
  }
}

// ✅ CORRECT: Method calls through store
const store = useStore();
store.increment(); // Maintains context
const total = store.calculateTotal(); // Uses current state

// ❌ INCORRECT: Destructured methods
const { increment, calculateTotal } = useStore();
increment(); // Loses store context
const total = calculateTotal(); // May use stale state
```

## Common Destructuring Pitfalls

### 1. Template Destructuring
```svelte
<script lang="ts">
    const store = useStore();
    const { user, loading } = store; // ❌ INCORRECT
</script>

{#if loading} <!-- Won't react to loading changes -->
    <p>Loading...</p>
{:else if user}
    <p>Hello {user.name}</p> <!-- Won't react to user changes -->
{/if}
```

### 2. Computed Properties
```svelte
<script lang="ts">
    const store = useStore();
    const { items } = store; // ❌ INCORRECT
    
    const itemCount = items.length; // Won't update when items change
</script>
```

### 3. Event Handlers
```svelte
<script lang="ts">
    const store = useStore();
    const { addItem, removeItem } = store; // ❌ INCORRECT
</script>

<button on:click={addItem}>Add</button> <!-- Method loses context -->
```

## Correct Alternatives

### 1. Direct Store Access
```svelte
<script lang="ts">
    const store = useStore();
    
    function handleClick() {
        store.addItem(); // ✅ CORRECT
    }
    
    $effect(() => {
        if (store.loading) {
            console.log('Loading state changed');
        }
    });
</script>

{#if store.loading}
    <p>Loading...</p>
{/if}
```

### 2. Computed Values with Store
```svelte
<script lang="ts">
    const store = useStore();
    
    const itemCount = $derived(store.items.length); // ✅ CORRECT
</script>

<p>Items: {itemCount}</p>
```

### 3. Event Handlers with Store
```svelte
<script lang="ts">
    const store = useStore();
</script>

<button on:click={() => store.addItem()}>Add</button> <!-- ✅ CORRECT -->
```

## Migration Guide

### From Destructured to Direct Access

**Before (Incorrect):**
```svelte
<script lang="ts">
    const { user, loading, login, logout } = useAuth();
</script>

{#if loading}
    <Loading />
{:else if user}
    <UserProfile user={user} />
{/if}
```

**After (Correct):**
```svelte
<script lang="ts">
    const store = useAuth();
</script>

{#if store.loading}
    <Loading />
{:else if store.user}
    <UserProfile user={store.user} />
{/if}
```

## Enforcement Checklist

For every component using stores:
- [ ] Store instance assigned to `store` variable
- [ ] All property access uses `store.property` syntax
- [ ] All method calls use `store.method()` syntax
- [ ] No destructuring assignment from store instance
- [ ] Template references use `store.property` syntax
- [ ] Event handlers reference methods through store

## Benefits of Compliance

- **Reactive Updates**: Components automatically update when store changes
- **Predictable Behavior**: Consistent reactivity across all components
- **Easier Debugging**: Clear relationship between store and component
- **Better Performance**: Efficient reactivity tracking by Svelte
