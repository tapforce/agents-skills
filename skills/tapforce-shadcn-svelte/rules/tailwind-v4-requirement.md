---
name: tailwind-v4-requirement
description: Critical requirement for TailwindCSS v4 before shadcn-svelte setup
tags: [tailwind, v4, requirement, critical]
---

**ALWAYS** verify TailwindCSS v4 is installed and configured before attempting shadcn-svelte setup.

**NEVER** proceed with shadcn-svelte initialization if TailwindCSS v3 is detected - this will cause setup failures.

**ALWAYS** check `package.json` for `tailwindcss` version 4.x before starting shadcn-svelte setup.

**ALWAYS** upgrade to TailwindCSS v4 first if v3 is detected in the project.

**NEVER** assume default SvelteKit templates use TailwindCSS v4 - they typically use v3 and require manual upgrade.

**ALWAYS** verify CSS files use v4 syntax (`@import "tailwindcss"`) instead of v3 directives before proceeding.
