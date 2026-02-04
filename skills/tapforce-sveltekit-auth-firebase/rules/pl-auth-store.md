---
name: pl-auth-store
description: Firebase authentication store implementation for SvelteKit
tags:
  - firebase
  - auth
  - store
  - sveltekit
---

## Firebase Auth Store

Create auth store in `src/lib/auth/auth.svelte.ts` following SvelteKit store patterns.

## Complete Auth Store Implementation

```typescript
import { setContext, getContext } from "svelte";
import { getAuth, onAuthStateChanged, signInWithEmailAndPassword, signOut, GoogleAuthProvider, signInWithPopup, type User } from "firebase/auth";
import { firebaseApp } from "$lib/firebase/firebase-init";
import invariant from "tiny-invariant";

const sid = Symbol("auth");

export class Auth {
  readonly auth = getAuth(firebaseApp);
  user = $state<User | null>(null);

  async loginWithCredentials(email: string, password: string) {
    try {
      const result = await signInWithEmailAndPassword(this.auth, email, password);
      return result.user;
    } catch (error) {
      throw error;
    }
  }

  async logout() {
    try {
      await signOut(this.auth);
    } catch (error) {
      throw error;
    }
  }

  async loginByGoogle() {
    try {
      const provider = new GoogleAuthProvider();
      const result = await signInWithPopup(this.auth, provider);
      return result.user;
    } catch (error) {
      throw error;
    }
  }
}

export function createAuth() {
  const auth = new Auth();
  
  onAuthStateChanged(auth.auth, (user) => {
    auth.user = user;
  });
  
  setContext(sid, auth);
  return auth;
}

export function useAuth() {
  const auth = getContext(sid);
  invariant(auth, "Auth context not found");
  return auth as Auth;
}
```

## Usage

### Initialize (in +layout.svelte)

```typescript
import { createAuth } from '$lib/auth/auth.svelte';
const auth = createAuth();
```

### Access in Components

```typescript
import { useAuth } from '$lib/auth/auth.svelte';
const auth = useAuth();

// Check user state
$: isLoggedIn = !!auth.user;

// Login with email/password
try {
  const user = await auth.loginWithCredentials(email, password);
} catch (error) {
  console.error('Login failed:', error);
}

// Login with Google
try {
  const user = await auth.loginByGoogle();
} catch (error) {
  console.error('Google login failed:', error);
}

// Logout
await auth.logout();
```
