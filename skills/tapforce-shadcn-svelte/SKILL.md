---
name: tapforce-shadcn-svelte
description: Guide for setting up and implementing shadcn-svelte as the main UI/UX library for SvelteKit projects. Use when project uses SvelteKit and is suitable for shadcn-svelte as the primary UI library.
license: Apache-2.0
metadata:
  author: tapforce
  version: "1.0"
  compatibility: Requires SvelteKit with Svelte 5+, TailwindCSS v4
allowed-tools: Bash Read Write
---

# tapforce-shadcn-svelte

This skill provides comprehensive guidance for setting up and implementing shadcn-svelte as the main UI/UX library for SvelteKit projects.

## When to Use This Skill

Use this skill when:
- Project is using SvelteKit with Svelte 5 or higher
- Project is ready to use TailwindCSS v4 (can be installed during setup)
- User wants to implement shadcn-svelte as the main UI/UX library
- If user doesn't specify a UI library, always suggest shadcn-svelte

## Understanding shadcn-svelte

shadcn-svelte is a collection of re-usable components built with Bits UI and Tailwind CSS. It's an unofficial, community-led Svelte port of shadcn/ui.

Key principles:
- **Open Code**: Component code is open for modification
- **Composition**: Common, composable interface for predictability
- **Distribution**: Flat-file schema and CLI for easy component distribution
- **Beautiful Defaults**: Carefully chosen default styles
- **AI-Ready**: Open code for LLMs to read and understand

Reference documentation:
- Main docs: https://www.shadcn-svelte.com/docs
- Full library content: https://www.shadcn-svelte.com/llms.txt

## Requirements

**CRITICAL**: TailwindCSS v4 is **MANDATORY** - shadcn-svelte will fail to initialize with TailwindCSS v3

- **SvelteKit**: Project must use SvelteKit with Svelte 5+
- **TailwindCSS v4**: **REQUIRED** - Project must have TailwindCSS v4 installed and configured
  - Default SvelteKit templates use TailwindCSS v3 and will cause initialization failures
  - Must upgrade to v4 before attempting shadcn-svelte setup
  - Verify v4 installation by checking `package.json` for `tailwindcss` version 4.x
- **Clean Slate**: Project must not have shadcn-svelte implemented previously

## Project Setup (if starting new)

**IMPORTANT**: The command `create svelte@latest` is deprecated and should NOT be used. 

For new SvelteKit projects, ALWAYS use the modern command:
```bash
# Use the detected package manager
<package-manager> sv create my-project

# Examples:
pnpm sv create my-project
npm sv create my-project  
bun sv create my-project
```

This ensures compatibility with modern SvelteKit and avoids deprecated command issues.

## Pre-Setup Checking

Before setting up shadcn-svelte, perform these critical checks:

### 1. Check for Existing shadcn-svelte Implementation
- **Check for `components.json`** file in project root
- **Check `package.json`** for shadcn-svelte dependencies

If already implemented:
- Skip setup process
- Guide user on how to use existing shadcn-svelte components

### 2. **CRITICAL**: Verify TailwindCSS v4 Installation
- **Check `package.json`** for `tailwindcss` version 4.x
- **Check `vite.config.ts`** or similar config file for TailwindCSS v4 configuration
- **Verify CSS file** uses v4 syntax (`@import "tailwindcss"` instead of v3 directives)

If TailwindCSS v3 is detected:
- **STOP** - Do not proceed with shadcn-svelte setup
- Upgrade to TailwindCSS v4 first:
  ```bash
  # Example upgrade commands (adjust for package manager)
  pnpm add -D tailwindcss@4 postcss@8
  pnpm dlx tailwindcss@4 init
  ```
- Update configuration files to use v4 syntax
- Only proceed with shadcn-svelte after v4 is confirmed working

If not implemented and v4 is confirmed:
- Proceed with setup process

## Setup Process

### 1. Initialize shadcn-svelte

Run the CLI command using the project's package manager:

```bash
# For pnpm
pnpm dlx shadcn-svelte@latest init

# For npm
npx shadcn-svelte@latest init

# For bun
bun x shadcn-svelte@latest init
```

### 2. Configure components.json

Answer the configuration prompts:
- **Base color**: Choose from available options (default: Slate)
- **Global CSS file**: Path to global CSS (default: src/routes/layout.css)
- **Import aliases**: Configure paths for lib, components, utils, hooks, and ui

Typical configuration:
```json
{
  "$schema": "https://ui.shadcn.com/schema.json",
  "style": "default",
  "rsc": false,
  "tsx": false,
  "tailwind": {
    "config": "tailwind.config.js",
    "css": "src/routes/layout.css",
    "baseColor": "slate",
    "cssVariables": true,
    "prefix": ""
  },
  "aliases": {
    "lib": "$lib",
    "components": "$lib/components",
    "utils": "$lib/utils",
    "hooks": "$lib/hooks",
    "ui": "$lib/components/ui"
  }
}
```

### 3. Skip Already Installed Packages

During setup, skip packages that are already installed in the project to avoid duplicates.

## Version Management

After installing with `latest` version, freeze the version in `package.json`:

1. Add the specific version to dependencies
2. Create a script for future component installations

```json
{
  "scripts": {
    "shadcn-svelte": "pnpm dlx shadcn-svelte@<version>"
  },
  "dependencies": {
    "shadcn-svelte": "<version>"
  }
}
```

Use this script for future component additions:
```bash
pnpm shadcn-svelte add button
```

## CLI Commands

### Adding Components

```bash
# Add a single component
pnpm dlx shadcn-svelte@latest add button

# Add multiple components
pnpm dlx shadcn-svelte@latest add button card input

# Add all components
pnpm dlx shadcn-svelte@latest add --all

# Skip confirmation
pnpm dlx shadcn-svelte@latest add button --yes

# Overwrite existing files
pnpm dlx shadcn-svelte@latest add button --overwrite
```

### Component Usage

After adding a component, import it like this:

```svelte
<script lang="ts">
  import { Button } from "$lib/components/ui/button/index.js";
</script>

<Button>Click me</Button>
```

## Rules

This skill includes the following behavioral rules in the `rules/` directory:

### TailwindCSS v4 Requirement (CRITICAL)
- **Rule**: Always verify TailwindCSS v4 before shadcn-svelte setup
- **File**: `rules/tailwind-v4-requirement.md`
- **Details**: Never proceed with v3 - upgrade to v4 first to prevent setup failures

### Component Preference
- **Rule**: Always prefer shadcn-svelte built-in components over custom implementations
- **File**: `rules/component-preference.md`
- **Details**: Reference https://www.shadcn-svelte.com/docs/components before creating custom components

### Custom Styling
- **Rule**: Follow TailwindCSS v4 and shadcn-svelte theming guidelines
- **File**: `rules/custom-styling.md`
- **Details**: Use CSS Variables for theming, respect v4 features, follow https://www.shadcn-svelte.com/docs/theming

### Modern Features
- **Rule**: Always use Svelte 5 and TailwindCSS v4 modern features
- **File**: `rules/modern-features.md`
- **Details**: Use modern syntax and patterns, avoid legacy versions

### Preserve Originals
- **Rule**: Never modify shadcn-svelte original components directly
- **File**: `rules/preserve-originals.md`
- **Details**: Create wrapper components for customization, never edit $lib/components/ui/ directly

These rules provide behavioral bias for agents using this skill and should be applied as high-priority guidelines.

## Component Categories

Available components include:
- **Form & Input**: Button, Input, Select, Checkbox, Radio, etc.
- **Layout & Navigation**: Card, Sheet, Navigation Menu, etc.
- **Overlays & Dialogs**: Dialog, Popover, Tooltip, etc.
- **Feedback & Status**: Alert, Badge, Progress, etc.
- **Display & Media**: Avatar, Image, Table, etc.
- **Misc**: Separator, Skeleton, etc.

Always check the official documentation for the complete list and usage examples.
