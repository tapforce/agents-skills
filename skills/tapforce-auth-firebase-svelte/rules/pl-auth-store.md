---
name: pl-auth-store
description: Best practices for creating Firebase authentication store in SvelteKit
tags:
  - firebase
  - auth
  - store
  - sveltekit
---

## Firebase Auth Store Setup

**Always** create a dedicated auth store following SvelteKit store patterns when implementing Firebase authentication.

## Auth Store Structure

**Always** create auth store in `src/lib/auth/auth.svelte.ts` with the following structure:

### 1. Auth Class Definition

```typescript
import { getAuth, type User } from "firebase/auth";
import { firebaseApp } from "$lib/firebase/firebase-init";

export class Auth {
  readonly auth = getAuth(firebaseApp);
  user = $state<User | null>(null);

  // Auth methods
  async signOut() {
    await this.auth.signOut();
  }
}
```

### 2. createAuth() Function

**ALWAYS** initialize reactive listeners in `createAuth()`, **NEVER** in constructor:

```typescript
import { setContext } from "svelte";
import { onAuthStateChanged } from "firebase/auth";

const sid = Symbol("auth");

export function createAuth() {
  const auth = new Auth();
  
  // ✅ CORRECT - Set up auth state listener here
  onAuthStateChanged(auth.auth, (user) => {
    auth.user = user;
  });
  
  setContext(sid, auth);
  return auth;
}
```

### 3. useAuth() Function

```typescript
import { getContext } from "svelte";
import invariant from "tiny-invariant";

export function useAuth() {
  const auth = getContext(sid);
  invariant(auth, "Auth context not found");
  return auth as Auth;
}
```

## Usage Patterns

### Initialize Auth (in +layout.svelte or root)

```typescript
import { createAuth } from '$lib/auth/auth.svelte';
const auth = createAuth();
```

### Access Auth in Components

```typescript
import { useAuth } from '$lib/auth/auth.svelte';
const auth = useAuth();

// Reactive access to user state
$: console.log(auth.user);

// Sign out
await auth.signOut();
```

## Important Rules

- **NEVER** use constructor for reactive operations like `onAuthStateChanged`
- **ALWAYS** use `createAuth()` for setting up listeners and reactive initialization
- **ALWAYS** use `$state()` for reactive properties in the Auth class
- **ALWAYS** export both `createAuth()` and `useAuth()` functions
- **ALWAYS** use `tiny-invariant` for context validation in `useAuth()`
