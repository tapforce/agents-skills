---
name: firebase-environment-variables
description: Ensure proper Firebase environment variable setup
tags: [firebase, environment, configuration]
---

# Firebase Environment Variables Rule

**ALWAYS** use `PUBLIC_` prefix for client-side Firebase configuration variables.

**NEVER** expose sensitive Firebase credentials in client-side code.

**ALWAYS** provide placeholder values with descriptive comments when setting up initial environment variables.

**ALWAYS** include all required Firebase configuration variables: API_ID, API_KEY, AUTH_DOMAIN, MEASUREMENT_ID, MESSAGING_SENDER_ID, PROJECT_ID, STORAGE_BUCKET.
