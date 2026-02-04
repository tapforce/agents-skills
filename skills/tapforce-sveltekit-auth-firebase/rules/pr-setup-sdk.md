---
name: pr-setup-sdk
description: Practices to prepare project to use firebase sdk
---

## Requirements

- The project must use SvelteKit
- The project must be developed with Node.js version 20 or higher
- Using shadcn is recommended

## Check and install `firebase` package

**Always** reference official document to understand how to install `firebase` package at https://firebase.google.com/docs/web/setup.

**Always** use prefered package manager to install `firebase` package, replace `[pkgm]` with the package manager project prefered

## step to install and setup

install `firebase` package. **Always** use `[pkgm] install firebase` to install `firebase` package.

## Initialize Firebase object in web

**Always** initialize Firebase object in a separate file named `firebase-init.ts`, save to folder `src/lib/firebase/`.

**Always** define env variables in `.env` file. Attention that project can have `.env` or any local/dev env file.

- .env.development: development file
- .env.local: local file
- .env: main file

Choose 1 file as top priority.

## Environment File Setup

**Always** check for existing env files in this priority order:
1. .env
2. .env.development  
3. .env.local

**If no env file exists**, create `.env` file with the required Firebase variables.

**Snippet: env file**

```bash
PUBLIC_API_ID=
PUBLIC_API_KEY=
PUBLIC_AUTH_DOMAIN=
PUBLIC_MEASUREMENT_ID=
PUBLIC_MESSAGING_SENDER_ID=
PUBLIC_PROJECT_ID=
PUBLIC_STORAGE_BUCKET=
GOOGLE_SERVICE_ACCOUNT='{
  [value get from firebase console]
}'
```

**Example: firebase-init.ts**

```typescript
import { initializeApp } from "firebase/app";
import {
  PUBLIC_API_ID,
  PUBLIC_API_KEY,
  PUBLIC_AUTH_DOMAIN,
  PUBLIC_MEASUREMENT_ID,
  PUBLIC_MESSAGING_SENDER_ID,
  PUBLIC_PROJECT_ID,
  PUBLIC_STORAGE_BUCKET,
} from "$env/static/public";

// TODO: Replace the following with your app's Firebase configuration
const firebaseConfig = {
  apiKey: PUBLIC_API_KEY,
  authDomain: PUBLIC_AUTH_DOMAIN,
  projectId: PUBLIC_PROJECT_ID,
  storageBucket: PUBLIC_STORAGE_BUCKET,
  messagingSenderId: PUBLIC_MESSAGING_SENDER_ID,
  appId: PUBLIC_API_ID,
  measurementId: PUBLIC_MEASUREMENT_ID,
};

export const firebaseApp = initializeApp(firebaseConfig);
```