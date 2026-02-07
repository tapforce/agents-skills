---
name: firebase-version-requirement
description: Enforce minimum Firebase SDK version for compatibility
tags: [firebase, version, compatibility]
---

# Firebase Version Requirement Rule

**ALWAYS** ensure Firebase SDK version is >= 12.0.0 for compatibility with modern SvelteKit projects.

**NEVER** use Firebase SDK versions below 12.0.0 as they may have compatibility issues with SvelteKit ^2 and Svelte ^5.

**ALWAYS** check existing Firebase version before setup and update if necessary using `<package manager> install firebase@latest`.
