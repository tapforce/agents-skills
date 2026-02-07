---
name: firebase-app-initialization
description: Ensure proper Firebase app initialization pattern
tags: [firebase, initialization, app-setup]
---

# Firebase App Initialization Rule

**ALWAYS** check if Firebase app is already initialized before creating a new instance using `getApps()[0]`.

**NEVER** create multiple Firebase app instances in the same project.

**ALWAYS** use the pattern `export const firebaseApp = getApps()[0] ?? initializeApp(firebaseConfig)` for safe initialization.

**ALWAYS** place `firebase-app.ts` in `/src/lib/firebase/` directory for consistency.
