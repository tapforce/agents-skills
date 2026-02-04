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

  /* Reactive state for authentication */
  user = $state<User | null | undefined>(undefined);

  /* Derived computed properties for auth state */
  isAuthed = $derived.by(() => !!this.user);

  /* Derived computed property for guest state */
  isGuest = $derived.by(() => this.user === null);

  /**
   * Authenticates a user with email and password credentials
   * @param email - User's email address
   * @param password - User's password
   * @returns The authenticated user object
   * @throws Error if authentication fails
   */
  async loginWithCredentials(email: string, password: string) {
    try {
      const result = await signInWithEmailAndPassword(this.auth, email, password);
      return result.user;
    } catch (error) {
      // Handle authentication errors
      throw error;
    }
  }

  /**
   * Signs out the currently authenticated user
   * @throws Error if logout fails
   */
  async logout() {
    try {
      await signOut(this.auth);
    } catch (error) {
      // Handle logout errors
      throw error;
    }
  }

  /**
   * Authenticates a user using Google OAuth popup
   * @returns The authenticated user object
   * @throws Error if Google sign-in fails
   */
  async loginByGoogle() {
    try {
      const provider = new GoogleAuthProvider();
      const result = await signInWithPopup(this.auth, provider);
      return result.user;
    } catch (error) {
      // Handle Google sign-in errors
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

// Check auth state using derived properties
console.log('Is authenticated:', auth.isAuthed);
console.log('Is guest:', auth.isGuest);

// Or check user state directly
console.log('Current user:', auth.user);

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
