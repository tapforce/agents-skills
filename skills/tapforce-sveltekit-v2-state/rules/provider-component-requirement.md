---
name: provider-component-requirement
description: Enforces creation of provider components for store initialization
tags: [provider, component, store, initialization]
---

# Provider Component Requirement Rule

## Rule Statement

**ALWAYS** create a provider component for store initialization. **NEVER** initialize stores directly in layout or page components. Provider components **MUST** follow specific naming and structural requirements.

## Rationale

Provider components ensure:
- Clean separation between store initialization and component logic
- Reusable store initialization patterns
- Consistent store setup across different contexts
- Proper component composition and hierarchy

## Provider Component Requirements

### 1. Naming Convention
- **MUST** follow format: `<abstract name>-provider.svelte`
- Examples: `auth-provider.svelte`, `app-provider.svelte`, `dashboard-provider.svelte`

### 2. Component Structure
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

### 3. Structural Requirements
- **MUST** import `type Snippet` from 'svelte'
- **MUST** define `Props` interface with `children: Snippet`
- **MUST** destructure `children` from props
- **MUST** call `create<abstract name>()` function
- **MUST** render children with `{@render children()}`
- **MUST** keep component simple and focused on store logic

## Provider Component Placement

### Page-Specific Stores
**Store Location**: `/src/routes/<route>/store.ts`
**Provider Location**: `/src/routes/<route>/<route>-provider.svelte`

**Example Structure:**
```
src/routes/dashboard/
├── store.ts
├── dashboard-provider.svelte
├── +layout.svelte
└── +page.svelte
```

### Abstract Stores (Single Route Usage)
**Store Location**: `/src/lib/<abstract name>/store.ts`
**Provider Location**: `/src/routes/<route>/<abstract name>-provider.svelte`

**Example Structure:**
```
src/lib/auth/
└── store.ts

src/routes/login/
├── auth-provider.svelte
└── +page.svelte
```

### Abstract Stores (Multiple Route Usage)
**Store Location**: `/src/lib/<abstract name>/store.ts`
**Provider Location**: `/src/lib/<abstract name>/<abstract name>-provider.svelte`

**Example Structure:**
```
src/lib/auth/
├── store.ts
└── auth-provider.svelte

src/routes/
├── +layout.svelte (uses AuthProvider)
├── login/
└── dashboard/
```

## Correct Implementation Examples

### Page-Specific Provider
```svelte
<!-- src/routes/dashboard/dashboard-provider.svelte -->
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

### Abstract Provider
```svelte
<!-- src/lib/auth/auth-provider.svelte -->
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

## Provider Usage in Layouts

### Layout Integration
```svelte
<!-- src/routes/dashboard/+layout.svelte -->
<script lang='ts'>
    import { DashboardProvider } from './dashboard-provider';

    interface Props {
        children: Snippet;
    }

    let { children }: Props = $props();
</script>

<DashboardProvider>
    {@render children()}
</DashboardProvider>
```

### Root Layout Integration
```svelte
<!-- src/routes/+layout.svelte -->
<script lang='ts'>
    import { AuthProvider } from '$lib/auth/auth-provider';

    interface Props {
        children: Snippet;
    }

    let { children }: Props = $props();
</script>

<AuthProvider>
    {@render children()}
</AuthProvider>
```

## Incorrect Implementation Examples

### Direct Store Initialization (FORBIDDEN)
```svelte
<!-- ❌ INCORRECT: Direct initialization in layout -->
<script lang='ts'>
    import { createAuth } from '$lib/auth/store';
    import { type Snippet } from 'svelte';

    let { children }: Props = $props();

    createAuth(); // ❌ WRONG: Direct call
</script>

{@render children()}
```

### Missing Provider Component (FORBIDDEN)
```svelte
<!-- ❌ INCORRECT: No provider component -->
<script lang='ts'>
    import { createStore } from './store';
    import { type Snippet } from 'svelte';

    let { children }: Props = $props();

    createStore(); // ❌ WRONG: Should be in provider
</script>

{@render children()}
```

### Incorrect Provider Structure
```svelte
<!-- ❌ INCORRECT: Wrong structure -->
<script lang="ts">
    import { createStore } from './store';
    
    // ❌ WRONG: Missing Snippet import and Props interface
    let { children } = $props(); // ❌ WRONG: Not typed as Snippet
    
    createStore();
    
    // ❌ WRONG: Additional logic not related to store
    function someOtherLogic() {
        // This shouldn't be here
    }
</script>

{@render children()}
```

### Wrong Naming Convention
```svelte
<!-- ❌ INCORRECT: Wrong naming -->
<!-- file: store-wrapper.svelte (should be dashboard-provider.svelte) -->
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

## Provider Component Best Practices

### 1. Keep It Simple
Provider components should only contain:
- Store initialization code
- Props definition and destructuring
- Children rendering

### 2. No Additional Logic
**NEVER** add:
- Business logic unrelated to store
- UI elements or styling
- Event handlers not related to store
- Computed properties not related to store

### 3. Single Responsibility
Each provider should initialize only one store:
- ✅ `AuthProvider` initializes only auth store
- ❌ `AppProvider` initializes auth, user, and app stores (should be separate)

### 4. Consistent Imports
Always use the same import pattern:
```typescript
import { type Snippet } from 'svelte';
import { create<AbstractName> } from './store';
```

## Multiple Providers Composition

When multiple stores are needed, compose providers:

```svelte
<script lang='ts'>
    import { AuthProvider } from '$lib/auth/auth-provider';
    import { AppProvider } from '$lib/app/app-provider';
    import { type Snippet } from 'svelte';

    interface Props {
        children: Snippet;
    }

    let { children }: Props = $props();
</script>

<AuthProvider>
    <AppProvider>
        {@render children()}
    </AppProvider>
</AuthProvider>
```

## Provider Component Template

Use this template for all provider components:

```svelte
<script lang="ts">
    import { type Snippet } from 'svelte';
    import { create<AbstractName> } from './store';

    interface Props {
        children: Snippet;
    }

    let { children }: Props = $props();

    create<AbstractName>();
</script>

{@render children()}
```

## Enforcement Checklist

For every store implementation:
- [ ] Provider component created with correct naming
- [ ] Provider follows required structure
- [ ] Provider placed in correct location
- [ ] Store initialization only in provider
- [ ] Provider used in layout/page components
- [ ] No direct store initialization in layouts
- [ ] Provider keeps simple and focused

## Benefits of Compliance

- **Consistency**: Uniform store initialization pattern
- **Reusability**: Providers can be used in multiple contexts
- **Maintainability**: Clear separation of concerns
- **Composition**: Easy to combine multiple providers
- **Testing**: Isolated store initialization logic
