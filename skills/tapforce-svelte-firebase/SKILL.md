---
name: tapforce-svelte-firebase
description: Guide AI best practices to install and develop SvelteKit projects using Firebase SDK. Use when user needs Firebase authentication features. Project must be based on SvelteKit ^2, Svelte ^5, and TypeScript.
license: Apache-2.0
metadata:
  author: tapforce
  version: "1.0"
compatibility: Requires SvelteKit ^2, Svelte ^5, TypeScript
---

# Tapforce Svelte Firebase Skill

This skill guides AI best practices for installing and developing SvelteKit projects using Firebase SDK.

## When to Use

Use this skill when the user mentions needing authentication features with Firebase. The project must be based on:
- SvelteKit ^2
- Svelte ^5  
- TypeScript

## Requirements

- Project must be based on SvelteKit ^2
- Project must be based on Svelte ^5
- Project must use TypeScript

## References

- [Set up firebase](https://firebase.google.com/docs/web/setup)
- [Config firebase object](https://firebase.google.com/docs/web/learn-more#config-object)

## Setup Process

You must read and understand the content from [Set up firebase](https://firebase.google.com/docs/web/setup) to know how to setup Firebase SDK.

### 1. Setup Firebase SDK

`firebase` is the Node.js package provided by Google. This is the main SDK for communication between Firebase services and your project. You need to check if the `firebase` package is installed in the project.

If `firebase` package is not installed, install it using:

```bash
<package manager> install firebase@latest
```

The `firebase` version must be >= 12.0.0. If the version is lower than 12.0.0, update it using:

```bash
<package manager> install firebase@latest
```

### 2. Setup Default Environment Variables

The Firebase configuration can be read from: https://firebase.google.com/docs/web/learn-more#config-object. You must read this document to understand how to get Firebase configuration values.

Check for Firebase configuration values in `.env.*` or `.env` files. If the file doesn't contain Firebase configuration, add placeholder values with comments:

**Firebase configuration snippet for .env as placeholder:**

```bash
# Firebase Configuration
# Get these values from your Firebase project settings
PUBLIC_API_ID=your-app-id
PUBLIC_API_KEY=your-api-key
PUBLIC_AUTH_DOMAIN=your-project-id.firebaseapp.com
PUBLIC_MEASUREMENT_ID=your-measurement-id
PUBLIC_MESSAGING_SENDER_ID=your-sender-id
PUBLIC_PROJECT_ID=your-project-id
PUBLIC_STORAGE_BUCKET=your-project-id.appspot.com

# Service account for server-side Firebase operations (optional)
GOOGLE_SERVICE_ACCOUNT='{"type":"service_account","project_id":"your-project-id",...}'
```

### 3. Setup Firebase App

Check if the project has already initialized a Firebase app. If a Firebase app is found in the project, skip this step. If not, create a Firebase app in the project.

Create a file `firebase-app.ts` in the `/src/lib/firebase/` directory. The content is described at https://firebase.google.com/docs/web/setup#add-sdks-initialize. Similar to the snippet below:

```ts
import { getApps, initializeApp } from "firebase/app";

// TODO: Replace the following with your app's Firebase configuration
const firebaseConfig = {
  //...
};

export const firebaseApp = getApps()[0] ?? initializeApp(firebaseConfig);
```

**firebase-app.ts Usage**

The `firebaseApp` exported from `firebase-app.ts` is a Firebase app instance initialized with Firebase configuration. You can use it to initialize Firebase services. For example, an auth store can use `firebaseApp` to initialize Firebase auth within the store file.

## Rules

This skill includes the following behavioral rules in the `rules/` directory:

### Firebase Version Requirement
- **Rule**: Always ensure Firebase SDK version is >= 12.0.0 for compatibility
- **File**: `rules/firebase-version.md`
- **Details**: Enforce minimum Firebase SDK version for modern SvelteKit compatibility

### Firebase App Initialization
- **Rule**: Always use safe initialization pattern to prevent multiple app instances
- **File**: `rules/firebase-initialization.md`
- **Details**: Ensure proper Firebase app initialization using `getApps()[0] ?? initializeApp()`

### Environment Variables
- **Rule**: Always use proper environment variable naming and structure
- **File**: `rules/environment-variables.md`
- **Details**: Ensure proper Firebase environment variable setup with PUBLIC_ prefix
