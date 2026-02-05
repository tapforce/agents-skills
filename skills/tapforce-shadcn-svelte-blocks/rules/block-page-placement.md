---
name: block-page-placement
description: Rules for moving block-created pages to correct project structure locations
tags: [block-installation, file-organization, routing]
---

# Block Page Placement Rules

## Core Principle

**ALWAYS** move block-created pages to the correct project structure locations when installing shadcn-svelte blocks.

## Implementation Rules

### Page Structure Analysis
- **ALWAYS** analyze the generated block page structure after installation
- **ALWAYS** identify if the generated route structure matches the project's routing conventions
- **NEVER** leave block pages in incorrect locations

### File Movement Process
- **ALWAYS** move `+page.svelte` files from block-specific directories to the correct route location
- **ALWAYS** move any associated `data.ts` or other supporting files
- **ALWAYS** update import paths if files are moved to different directory levels

### Route Mapping Examples
- `src/routes/login-05/+page.svelte` → `src/routes/login/+page.svelte`
- `src/routes/signup-02/+page.svelte` → `src/routes/auth/signup/+page.svelte`
- `src/routes/dashboard-01/+page.svelte` → `src/routes/dashboard/+page.svelte`

### Conflict Resolution
- **ALWAYS** replace existing target page content with block content if target page exists
- **NEVER** merge block content with existing content (replace entirely)
- **ALWAYS** backup existing content before replacement if needed

### Cleanup
- **ALWAYS** remove empty block-specific directories after moving files
- **ALWAYS** remove any remaining sample files that are not needed
- **NEVER** leave orphaned files or directories

## Package Manager Integration
- **ALWAYS** respect the project's package manager when running installation commands
- **ALWAYS** use the correct shadcn-svelte version specified in the project
- **NEVER** assume pnpm if another package manager is detected

## Error Handling
- **ALWAYS** verify file moves were successful
- **ALWAYS** check for broken imports after moving files
- **ALWAYS** test the moved pages render correctly
