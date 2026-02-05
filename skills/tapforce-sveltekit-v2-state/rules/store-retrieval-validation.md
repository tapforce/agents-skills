---
name: store-retrieval-validation
description: Enforces validation of store availability in use functions
tags: [store, validation, context, error-handling]
---

# Store Retrieval Validation Rule

## Rule Statement

**ALWAYS** add conditional validation to check store availability before returning store instance in `use<abstract name>` functions. **NEVER** return store instance without validation.

## Rationale

Store validation ensures that:
- Components fail fast and clearly when store is not available
- Developers get meaningful error messages for debugging
- Store dependencies are explicit and traceable
- Runtime errors are prevented from undefined store access

## Required Validation Pattern

```typescript
export const useStore() {
    const store = getContext(sid) as Store;
    if (!store) {
        throw new Error('<abstract name> store not found');
    }
    return store;
}
```

## Validation Requirements

### 1. Type Assertion
- Use `as Store` type assertion after `getContext()`
- This provides TypeScript typing while still allowing runtime validation

### 2. Null/Undefined Check
- **ALWAYS** check `if (!store)` 
- This covers both `null` and `undefined` cases

### 3. Error Throwing
- **ALWAYS** throw an error when store is not found
- Error message must include the abstract name for clarity
- Use consistent error message format: `'<abstract name> store not found'`

### 4. Return After Validation
- **ONLY** return store instance after successful validation
- **NEVER** return store before validation

## Correct Implementation Examples

### Basic Store
```typescript
export const useAuth() {
    const store = getContext(sid) as AuthStore;
    if (!store) {
        throw new Error('Auth store not found');
    }
    return store;
}
```

### Page-Specific Store
```typescript
export const useStore() {
    const store = getContext(sid) as Store;
    if (!store) {
        throw new Error('Dashboard store not found');
    }
    return store;
}
```

### Abstract Store
```typescript
export const useApp() {
    const store = getContext(sid) as AppStore;
    if (!store) {
        throw new Error('App store not found');
    }
    return store;
}
```

## Incorrect Implementation Examples

### No Validation
```typescript
export const useStore() {
    // ❌ INCORRECT: No validation
    return getContext(sid) as Store;
}
```

### Weak Validation
```typescript
export const useStore() {
    const store = getContext(sid) as Store;
    if (store === null) {
        // ❌ INCORRECT: Only checks null, not undefined
        throw new Error('Store not found');
    }
    return store;
}
```

### No Error Throwing
```typescript
export const useStore() {
    const store = getContext(sid) as Store;
    if (!store) {
        // ❌ INCORRECT: Returns null instead of throwing
        return null;
    }
    return store;
}
```

### Generic Error Message
```typescript
export const useStore() {
    const store = getContext(sid) as Store;
    if (!store) {
        // ❌ INCORRECT: Generic error message
        throw new Error('Store not found');
    }
    return store;
}
```

## Error Message Guidelines

### Format Requirements
- **MUST** include abstract name: `'<abstract name> store not found'`
- **MUST** be specific to the store type
- **MUST** be consistent across all stores

### Examples of Correct Error Messages
- `'Auth store not found'`
- `'App store not found'`
- `'Dashboard store not found'`
- `'User store not found'`

### Examples of Incorrect Error Messages
- `'Store not found'` (too generic)
- `'Store is undefined'` (implementation detail)
- `'Cannot access store'` (vague)
- `'Error: no store'` (inconsistent format)

## Common Causes of Store Not Found

1. **Missing Provider Component**: Store not initialized in parent layout
2. **Incorrect Context Symbol**: `sid` mismatch between create and use functions
3. **Component Hierarchy**: Component trying to use store outside provider scope
4. **Multiple Store Instances**: Conflicting context keys

## Debugging Store Issues

When encountering "store not found" errors:

1. **Check Provider**: Ensure provider component is wrapping the component
2. **Verify Symbol**: Confirm `sid` is identical in create and use functions
3. **Trace Hierarchy**: Verify component is within provider's scope
4. **Check Imports**: Ensure correct store file is imported

## Enforcement Checklist

For every `use<abstract name>` function:
- [ ] Uses `getContext(sid) as StoreType`
- [ ] Checks `if (!store)` condition
- [ ] Throws error with specific abstract name
- [ ] Returns store only after validation
- [ ] Has consistent error message format
