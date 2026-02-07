add skill `tapforce-svelte-firebase`

This skill guide AI best practices to install and develop SvelteKit project use Firebase SDK.

Use this skill when user mention need authenticate feature with Firebase. To use this skill, project must based on SvelteKit, Svelte 5, typescript.

## requirement

- Project must based on SvelteKit ^2
- Project must based on Svelte ^5

## REFERENCE

- [Set up firebase](https://firebase.google.com/docs/web/setup)
- [Config firebase object](https://firebase.google.com/docs/web/learn-more#config-object)

## SETUP

You must read and understand content from [Set up firebase](https://firebase.google.com/docs/web/setup) to know how to setup firebase SDK.

### 1. setup firebase sdk

`firebase` is nodejs package provided by Google. This is main sdk for communicate between firebase services and project. You need check project if `firebase` package installed or not.

if `firebase` package not installed then you need install it use command

```bash
<package manager> install firebase@latest
```

The `firebase` version must >= 12.0.0. If version lower than 12.0.0 then you need update it use command

```bash
<package manager> install firebase@latest
```

### 2. setup default ENV variables

The firebase configuration can be read from: https://firebase.google.com/docs/web/learn-more#config-object. You must read this document to know how to get firebase configuration values.

You need check firebase configuration values in env file `.env.*` or `.env` file.  
If file not contains fireabse configuration then you need put values with empty/placeholder value and leave comment:

**Snippet firebase configuration in .env as placeholder**

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

### 3. setup firebase app

You need check project to sure know project init firebase app before or not. If firebase app found in project then you can skip this step.
If not, you need create firebase app in project.

Create file `firebase-app.ts` placed in `/src/lib/firebase/` directory.
The content of file described at `https://firebase.google.com/docs/web/setup#add-sdks-initialize`. The similar the snippet bellow:

```ts
import { getApps, initializeApp } from "firebase/app";

// TODO: Replace the following with your app's Firebase configuration
const firebaseConfig = {
  //...
};

export const firebaseApp = getApps()[0] ?? initializeApp(firebaseConfig);
```

**firebase-app.ts usage**

The `firebaseApp` exported from `firebase-app.ts` is a firebase app instance that initialized with firebase configuration. You can use it to init firebase services. Ex: auth store can use firebaseApp to init firebase auth init within store file.
