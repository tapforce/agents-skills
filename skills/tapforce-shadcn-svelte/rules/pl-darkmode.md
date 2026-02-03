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

Create the following components in `lib/components/darkmode/` folder:

#### Simple Toggle Button (`lib/components/darkmode/simple-toggle.svelte`):

```svelte
<script lang="ts">
	import SunIcon from "@lucide/svelte/icons/sun";
	import MoonIcon from "@lucide/svelte/icons/moon";
	import { toggleMode } from "mode-watcher";
	import { Button } from "$lib/components/ui/button/index.js";
</script>

<Button onclick={toggleMode} variant="outline" size="icon">
	<SunIcon class="h-[1.2rem] w-[1.2rem] scale-100 rotate-0 !transition-all dark:scale-0 dark:-rotate-90" />
	<MoonIcon class="absolute h-[1.2rem] w-[1.2rem] scale-0 rotate-90 !transition-all dark:scale-100 dark:rotate-0" />
	<span class="sr-only">Toggle theme</span>
</Button>
```

#### Dropdown Menu Toggle (`lib/components/darkmode/dropdown-toggle.svelte`):

```svelte
<script lang="ts">
	import SunIcon from "@lucide/svelte/icons/sun";
	import MoonIcon from "@lucide/svelte/icons/moon";
	import { resetMode, setMode } from "mode-watcher";
	import * as DropdownMenu from "$lib/components/ui/dropdown-menu/index.js";
	import { buttonVariants } from "$lib/components/ui/button/index.js";
</script>

<DropdownMenu.Root>
	<DropdownMenu.Trigger class={buttonVariants({ variant: "outline", size: "icon" })}>
		<SunIcon class="h-[1.2rem] w-[1.2rem] scale-100 rotate-0 !transition-all dark:scale-0 dark:-rotate-90" />
		<MoonIcon class="absolute h-[1.2rem] w-[1.2rem] scale-0 rotate-90 !transition-all dark:scale-100 dark:rotate-0" />
		<span class="sr-only">Toggle theme</span>
	</DropdownMenu.Trigger>
	<DropdownMenu.Content align="end">
		<DropdownMenu.Item onclick={() => setMode("light")}>Light</DropdownMenu.Item>
		<DropdownMenu.Item onclick={() => setMode("dark")}>Dark</DropdownMenu.Item>
		<DropdownMenu.Item onclick={() => resetMode()}>System</DropdownMenu.Item>
	</DropdownMenu.Content>
</DropdownMenu.Root>
```

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

