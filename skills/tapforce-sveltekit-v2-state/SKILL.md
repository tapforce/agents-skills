---
name: tapforce-sveltekit-v2-state
description: Guide for implementing store strategy to gather data/state and share across component levels or pages in SvelteKit v2 projects using Svelte context. Use when data/state becomes complex and needs centralization, or when store pattern is required.
license: Apache-2.0
metadata:
  author: tapforce
  version: "1.0"
  compatibility: Requires SvelteKit v2 and Svelte v5 with TypeScript
allowed-tools: Bash Read Write
---

# tapforce-sveltekit-v2-state

This skill provides comprehensive guidance for implementing store strategy to gather data/state and share across component levels or pages in SvelteKit projects using Svelte context.

## When to Use This Skill

Use this skill when:
- Data/state on page or code structure becomes complex and needs to be gathered in one place to share across component levels or pages
- Project requires store strategy as requested by user
- A module or component needs to share state/data across component levels or pages
- High-level abstract data flow requires centralizing state in one place and sharing to all sub-routes (e.g., Authentication state, ACL state, Application state)

## Requirements

- **SvelteKit v2**: Project must use SvelteKit v2
- **Svelte v5**: Project must use Svelte v5 with modern runes (`$state`, `$derived`, `$effect`)
- **TypeScript**: Project must use TypeScript

## Before Using This Skill

- **ALWAYS** respect other skills used in project that are related to technicals, frameworks, or libraries
- **CONSISTENCY**: When you start using this skill, skill/rules within this skill MUST be consistent across the project, no exception

## Store Structure

### Store Class Definition

A store object is a JavaScript Class defined in a separate TypeScript file:

```typescript
export class Store {
  stateValue = $state(0);
  derivedValue = $derived(this.stateValue);

  static referenceParentStore = new ParentStore();

  method() {
    this.stateValue += 1;
  }
}
```

**Key Principles:**
- Class can assign `$state`, `$derived`, static values, other store instances, methods, etc.
- Store class is designed to focus on a single abstract concept
- Example: `Auth` store focuses on authentication tasks

### Store Naming and Placement

**Class naming and file placement depend on store purpose:**

1. **Single Route Store**: 
   - Define class with name `Store`
   - Place in same route folder

2. **Abstract Store** (Auth, App, etc):
   - Define class with name matching the abstract name
   - Place in folder `/src/lib/<abstract name>/store.ts`

### Context Integration

A store class uses Svelte context feature to store and share class instances:

```typescript
const sid = Symbol('<abstract name>');

export const createStore() {
    // Define one-time setup code needed for store instance
    // Example: define static values, static methods, static properties,
    // define reactive updates, etc.
    
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

**Requirements:**
- Store requires unique `sid` variable using `Symbol('<abstract name>')`
- Use `setContext(sid, instance)` to initialize class instance
- Use `getContext(sid)` to retrieve class instance

## Store Functions

Every store requires 2 functions: `create<abstract name>` and `use<abstract name>`

### `create<abstract name>` Function
- **Purpose**: Define one-time setup code needed for store instance
- **Returns**: Store instance
- **Usage**: Initialize store instance at page/layout level
- **Scope**: Store instance available at current route and all sub-routes

### `use<abstract name>` Function
- **Purpose**: Retrieve store instance
- **Returns**: Store instance
- **Usage**: Retrieve store instance at component level, page, sub-page, sub-layout, etc.

**Example naming:**
- `createAuth()` and `useAuth()` for authentication store
- `createStore()` and `useStore()` for page-specific store

## Rules

This skill includes the following behavioral rules in the `rules/` directory:

### Store Setup Location (CRITICAL)
- **Rule**: `create<abstract name>` function is the only place for pre-setup code
- **File**: `rules/store-setup-location.md`
- **Details**: Never define pre-setup in class constructor or other places

### Store Retrieval Validation (CRITICAL)
- **Rule**: `use<abstract name>` function must validate store availability
- **File**: `rules/store-retrieval-validation.md`
- **Details**: Always check if store exists before returning instance

### No Store Destructuring (CRITICAL)
- **Rule**: Never destructure store instances
- **File**: `rules/no-store-destructuring.md`
- **Details**: Always reference from store object to target variables or methods

### Provider Component Requirement (CRITICAL)
- **Rule**: Always create provider component for store initialization
- **File**: `rules/provider-component-requirement.md`
- **Details**: Use provider components to wrap children that need store access

## Implementation Patterns

### Store Setup with Effects

```typescript
export const createStore() => {
    const store = new Store();

    $effect(() => {
        const onResize = () => {
            store.value += 1;
        }

        window.addEventListener('resize', onResize);

        const unmount = () => {
            window.removeEventListener('resize', onResize);
        }
        return unmount;
    })

    return setContext(sid, store);
}
```

### Store Usage in Components

```svelte
<script lang="ts">
    import { useStore } from './store';
    const store = useStore();
    
    $effect(() => {
        store.value += 1; // Assign value
        store.calculateDouble(); // Call method
    })
</script>

<!-- Reference reactive values -->
<span>{store.value}</span>
<span>{store.doubleValue}</span>
```

### Provider Component Structure

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

**Provider Component Requirements:**
- Name MUST follow format `<abstract name>-provider.svelte`
- Keep simple, only define code related to store abstract
- Define props `children` and render children in body

### Provider Component Placement

**Placement depends on abstract target:**

1. **Page-specific store** (store file in route folder):
   - Provider component also placed in same route folder

2. **Abstract store** (store in `/src/lib/<abstract name>/store.ts`):
   - If store init only for one route: place provider in same route folder
   - If store init for multiple routes: place provider in same store folder

### Provider Usage in Layouts

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
```

## Store Examples

### Authentication Store Example

**File: `/src/lib/auth/store.ts`**
```typescript
import { setContext, getContext } from 'svelte';

export class AuthStore {
  user = $state<User | null>(null);
  isAuthenticated = $derived(this.user !== null);

  login(credentials: LoginCredentials) {
    // Login logic
  }

  logout() {
    this.user = null;
  }
}

const sid = Symbol('Auth');

export const createAuth() => {
    const store = new AuthStore();
    
    // One-time setup code
    $effect(() => {
        // Check authentication on mount
        this.checkAuth();
    });
    
    return setContext(sid, store);
}

export const useAuth() {
    const store = getContext(sid) as AuthStore;
    if (!store) {
        throw new Error('Auth store not found');
    }
    return store;
}
```

**File: `/src/lib/auth/auth-provider.svelte`**
```svelte
<script lang="ts">
    import { type Snippet } from 'svelte';
    import { createAuth } from './store';

    interface Props {
        children: Snippet;
    }

    let { children }: Props = $props();

    createAuth();
</script>

{@render children()}
```

### Page-Specific Store Example

**File: `/src/routes/dashboard/store.ts`**
```typescript
import { setContext, getContext } from 'svelte';

export class Store {
  data = $state<DashboardData[]>([]);
  loading = $state(false);
  error = $state<string | null>(null);

  async loadData() {
    this.loading = true;
    try {
      // Load data logic
    } catch (err) {
      this.error = err.message;
    } finally {
      this.loading = false;
    }
  }
}

const sid = Symbol('Store');

export const createStore() => {
    return setContext(sid, new Store());
}

export const useStore() {
    const store = getContext(sid) as Store;
    if (!store) {
        throw new Error('Dashboard store not found');
    }
    return store;
}
```

**File: `/src/routes/dashboard/+layout.svelte`**
```svelte
<script lang="ts">
    import { type Snippet } from 'svelte';
    import { createStore } from './store';

    interface Props {
        children: Snippet;
    }

    let { children }: Props = $props();

    createStore();
</script>

{@render children()}
```

## Best Practices

### Store Design Principles
- **Single Responsibility**: Each store focuses on one abstract concept
- **Reactive State**: Use `$state` for reactive properties
- **Computed Values**: Use `$derived` for computed properties
- **Side Effects**: Use `$effect` for side effects and lifecycle management

### Error Handling
- Always validate store availability in `use<abstract name>` functions
- Provide meaningful error messages for missing stores
- Handle async operations with proper loading and error states

### Performance Considerations
- Minimize store size and complexity
- Use derived properties instead of computed functions when possible
- Avoid unnecessary re-renders by proper state management

## Integration with Other Skills

This skill is designed to work alongside other Tapforce skills:

- **tapforce-sveltekit-v2**: Core SvelteKit v2 patterns
- **tapforce-shadcn-svelte**: UI component integration
- **tapforce-nodejs-pnpm-v10**: Package management

Ensure consistency with all skills used in the project.
