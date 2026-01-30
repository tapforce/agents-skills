---
title: use svelte snippet with shadcn component
description: Use svelte snippet (svelte 5 feature) with shadcn component to avoid duplicate code.
tags: sveltekit, shadcn, snippet
---

Use svelte snippet (svelte 5 feature) with shadcn component to avoid duplicate code. Make sure you installed shadcn svelte version support Svelte 5.

**Example:**

```svelte
<script lang="ts">
 import * as DropdownMenu from "$lib/components/ui/dropdown-menu/index.js";
 import { Button } from "$lib/components/ui/button/index.js";
</script>
 
<DropdownMenu.Root>
 <DropdownMenu.Trigger>
  {#snippet child({ props })}
   <Button {...props} variant="outline">Open</Button>
  {/snippet}
 </DropdownMenu.Trigger>
```
