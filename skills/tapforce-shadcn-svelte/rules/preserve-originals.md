---
name: preserve-originals
description: Never modify shadcn-svelte original components directly
tags: [components, preservation, upgrades, safety]
---

**NEVER** modify directly the code of shadcn-svelte components. This is required to ensure safe upgrades from shadcn-svelte can override whole components.

**ALWAYS** create new custom components when user requests functionality different from built-in shadcn components.

**ALWAYS** wrap shadcn components inside custom components or simulate similar behavior based on user requests.

**ALWAYS** place new custom components in the project's preferred folder structure.

**NEVER** edit files in $lib/components/ui/ directory directly.
