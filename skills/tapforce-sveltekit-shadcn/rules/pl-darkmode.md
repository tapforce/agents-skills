---
name: pl-darkmode
description: Practice set up darkmode use shadcn-svelte
---

# Dark Mode Setup with shadcn-svelte

## Prerequisites

**IMPORTANT**: Your project must have shadcn-svelte installed before setting up dark mode. If you haven't installed shadcn-svelte yet, follow the installation guide first.

## Setup Steps

### 1. Install mode-watcher

Install the `mode-watcher` package which handles dark mode functionality:

```bash
pnpm i mode-watcher
# or
npm i mode-watcher
# or  
yarn install mode-watcher
# or
bun install mode-watcher
```

### 2. Add the ModeWatcher Component

Import and add the `ModeWatcher` component to your root layout file (usually `src/routes/+layout.svelte` in SvelteKit):

```svelte
<script lang="ts">
	import "../app.css";
	import { ModeWatcher } from "mode-watcher";
	let { children } = $props();
</script>

<ModeWatcher />
{@render children?.()}
```

### 3. Create Dark Mode Toggle Components

**IMPORTANT**: Component implementations may change over time. Always check the official shadcn-svelte documentation for the most current component examples:

📖 **Official Documentation**: https://www.shadcn-svelte.com/docs/dark-mode/svelte

Create the following components in `lib/components/darkmode/` folder:

#### Simple Toggle Button (`lib/components/darkmode/simple-toggle.svelte`)
- Refer to the "Add a mode toggle" section in the official docs
- Uses `toggleMode` from `mode-watcher`
- Includes sun/moon icons with smooth transitions

#### Dropdown Menu Toggle (`lib/components/darkmode/dropdown-toggle.svelte`)  
- Refer to the dropdown example in the official docs
- Uses `setMode` and `resetMode` from `mode-watcher`
- Provides Light/Dark/System options

**Note**: Copy the exact component code from the official documentation to ensure you have the latest implementation with proper styling and functionality.

### 4. Use the Components

Import and use either toggle component in your app:

```svelte
<script lang="ts">
	import SimpleToggle from "$lib/components/darkmode/simple-toggle.svelte";
	// or
	import DropdownToggle from "$lib/components/darkmode/dropdown-toggle.svelte";
</script>

<!-- Simple toggle button -->
<SimpleToggle />

<!-- Or dropdown menu toggle -->
<DropdownToggle />
```

## Summary

1. Install `mode-watcher` package
2. Add `ModeWatcher` to root layout
3. Create toggle components in `lib/components/darkmode/`
4. Import and use the toggle components where needed

The dark mode will now work automatically with smooth transitions and proper system preference detection.

