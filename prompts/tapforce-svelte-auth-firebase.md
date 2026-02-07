add skill `tapforce-svelte-auth-firebase`

This skill guide AI agent how to set up and develop authentication module on Sveltekit project use Firebase SDK.

## Use this skill when:

- project use `sveltekit v2` and `svelte v5`.
- project use `typescript`.
- project use `firebase` as authentication provider.
- project need centerize authentication state and share cross component level or page.

## requires:

- project must use SvelteKit version 2 or higher, and make sure use svelte verison 5 or higher.
- project must use typescript
- project must install and setup ready `firebase` package. If project not install package yet, find skill related to firbase, learn and setup firebase package first.
- highly recommend project should implement shadcn ui if avaialble.
- highly recommend project should use taiwindcss as main css framework.

## condition when working with skill:

- you need respect other skills related to technicals, frameworks, or libraries. Keep in mind this skill guide you idea to develop Authenticate domain code, not force you write correctly code-by-code.
- Reference skills related to `tailwindcss`, `css` to know guidelines and practices when develop with css frameworks.
- Reference skills related to `svelte state` to know guidelines and practices when develop with state management.
- Reference skills related to `firebase` to know guidelines and practices when develop with firebase.
- Reference skills related to `svelte practices` to know guidelines and practices when develop with svelte.
- Reference skills related to `shadcn-svelte` to know guidelines and practices when develop with shadcn-svelte.

## workflow:

### 1. define svelte store for auth state

The file store must respect `svelte store` practices.

The core of authenticaton module is svelte store. You need define svelte store for auth state. The auth state is reactive value that store current authentication state of user. You define it in `src/lib/auth/auth.ts` file.

Auth store can have more properties/methods depend on user requests or project requirements.

** Auth store **

```ts
import { setContext, getContext } from "svelte";
import {
  getAuth,
  onAuthStateChanged,
  signInWithEmailAndPassword,
  signOut,
  GoogleAuthProvider,
  signInWithPopup,
  type User,
} from "firebase/auth";
import { firebaseApp } from "$lib/firebase/firebase-init";

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
      const result = await signInWithEmailAndPassword(
        this.auth,
        email,
        password,
      );
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

// Create a new instance of Auth store
export function createAuth() {
  const auth = new Auth();

  // Listen to auth state changes
  onAuthStateChanged(auth.auth, (user) => {
    auth.user = user;
  });

  setContext(sid, auth);
  return auth;
}

// Use the Auth store instance
export function useAuth() {
  const auth = getContext(sid);
  if (!auth) {
    throw new Error("Auth context not found");
  }
  return auth as Auth;
}
```

### 2. Auth store scope.

Idea of auth store is centerize authenciation states cross project. You must consider auth store should be init auth store start from root layout of project (if project simple, no login or login use popup, etc), or you init at root route of `application level` (if project is complex with routes of app only allow authed request, login only allow unauthed request).

## REFERENCE

- [Set up firebase](https://firebase.google.com/docs/web/setup)
