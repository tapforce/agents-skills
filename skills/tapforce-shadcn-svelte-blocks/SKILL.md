---
name: tapforce-shadcn-svelte-blocks
description: Guidelines for developing UI/UX for SvelteKit projects using shadcn-svelte library with samples from shadcn-svelte block gallery. Use when building UI for projects using Svelte ^5, SvelteKit ^2, and shadcn-svelte.
license: Apache-2.0
metadata:
  author: tapforce
  version: "1.0"
  compatibility: Requires Svelte ^5, SvelteKit ^2, and shadcn-svelte
allowed-tools: Bash Read Write
---

# tapforce-shadcn-svelte-blocks

This skill provides guidelines for developing UI/UX for SvelteKit projects using the shadcn-svelte library with samples from the shadcn-svelte block gallery.

## When to Use

Use this skill when you need to:
- Build UI for projects using Svelte ^5, SvelteKit ^2, and shadcn-svelte
- Install and implement shadcn-svelte blocks from the gallery
- Develop UI components based on shadcn-svelte block samples
- Ensure consistent styling with shadcn-svelte patterns

## Available Blocks

### Dashboard Blocks
- **dashboard-01**: A dashboard with sidebar, charts and data table
  - Link: https://www.shadcn-svelte.com/blocks#dashboard-01
  - Install: `pnpm dlx shadcn-svelte@latest add dashboard-01`

### Sidebar Blocks
- **sidebar-01**: A simple sidebar with navigation grouped by section
  - Link: https://www.shadcn-svelte.com/blocks#sidebar-01
  - Install: `pnpm dlx shadcn-svelte@latest add sidebar-01`

- **sidebar-02**: A sidebar with collapsible sections
  - Link: https://www.shadcn-svelte.com/blocks#sidebar-02
  - Install: `pnpm dlx shadcn-svelte@latest add sidebar-02`

- **sidebar-03**: A sidebar with submenus
  - Link: https://www.shadcn-svelte.com/blocks#sidebar-03
  - Install: `pnpm dlx shadcn-svelte@latest add sidebar-03`

- **sidebar-07**: A sidebar that collapses to icons
  - Link: https://www.shadcn-svelte.com/blocks#sidebar-07
  - Install: `pnpm dlx shadcn-svelte@latest add sidebar-07`

### Login Blocks
- **login-01**: A simple login form
  - Link: https://www.shadcn-svelte.com/blocks#login-01
  - Install: `pnpm dlx shadcn-svelte@latest add login-01`

- **login-02**: A login page with a muted background color
  - Link: https://www.shadcn-svelte.com/blocks#login-02
  - Install: `pnpm dlx shadcn-svelte@latest add login-02`

- **login-03**: A login page with a background image
  - Link: https://www.shadcn-svelte.com/blocks#login-03
  - Install: `pnpm dlx shadcn-svelte@latest add login-03`

- **login-04**: A login page with form and image
  - Link: https://www.shadcn-svelte.com/blocks#login-04
  - Install: `pnpm dlx shadcn-svelte@latest add login-04`

### Signup Blocks
- **signup-01**: A simple signup form
  - Link: https://www.shadcn-svelte.com/blocks#signup-01
  - Install: `pnpm dlx shadcn-svelte@latest add signup-01`

- **signup-02**: A signup page with image
  - Link: https://www.shadcn-svelte.com/blocks#signup-02
  - Install: `pnpm dlx shadcn-svelte@latest add signup-02`

- **signup-03**: A signup page with background
  - Link: https://www.shadcn-svelte.com/blocks#signup-03
  - Install: `pnpm dlx shadcn-svelte@latest add signup-03`

### OTP Blocks
- **otp-01**: A simple OTP form
  - Link: https://www.shadcn-svelte.com/blocks#otp-01
  - Install: `pnpm dlx shadcn-svelte@latest add otp-01`

- **otp-02**: An OTP form with image
  - Link: https://www.shadcn-svelte.com/blocks#otp-02
  - Install: `pnpm dlx shadcn-svelte@latest add otp-02`

- **otp-03**: An OTP form with background
  - Link: https://www.shadcn-svelte.com/blocks#otp-03
  - Install: `pnpm dlx shadcn-svelte@latest add otp-03`

- **otp-04**: An OTP form with centered layout
  - Link: https://www.shadcn-svelte.com/blocks#otp-04
  - Install: `pnpm dlx shadcn-svelte@latest add otp-04`

### Calendar Blocks
- **calendar-01**: A simple calendar
  - Link: https://www.shadcn-svelte.com/blocks#calendar-01
  - Install: `pnpm dlx shadcn-svelte@latest add calendar-01`

- **calendar-02**: Multiple months with single selection
  - Link: https://www.shadcn-svelte.com/blocks#calendar-02
  - Install: `pnpm dlx shadcn-svelte@latest add calendar-02`

- **calendar-03**: Multiple months with multiple selection
  - Link: https://www.shadcn-svelte.com/blocks#calendar-03
  - Install: `pnpm dlx shadcn-svelte@latest add calendar-03`

- **calendar-04**: Single month with range selection
  - Link: https://www.shadcn-svelte.com/blocks#calendar-04
  - Install: `pnpm dlx shadcn-svelte@latest add calendar-04`

- **calendar-05**: Multiple months with range selection
  - Link: https://www.shadcn-svelte.com/blocks#calendar-05
  - Install: `pnpm dlx shadcn-svelte@latest add calendar-05`

## Implementation Guidelines

### Package Manager Selection
- Use the package manager that the project owner uses
- If unknown, strongly recommend `pnpm`
- MUST respect skills related to package manager when processing commands

### Block Installation Process
1. Install the block using the appropriate command for the detected package manager
2. Review the generated files and move them to the correct locations
3. Replace existing content if target pages already exist
4. Remove sample pages after moving content to correct locations

### Styling Requirements
- MUST respect shadcn-svelte style defined in the project
- MUST respect shadcn-svelte version defined in the project
- Maintain consistency with block styling within the page
- When creating custom components for block pages, respect the block's style

## Rules

This skill includes the following behavioral rules in the `rules/` directory:

### Block Page Placement
- **Rule**: Move block-created pages to correct project structure locations
- **File**: `rules/block-page-placement.md`
- **Details**: Handle routing structure mismatches when installing blocks

### Style Consistency
- **Rule**: Maintain consistent styling within block implementations
- **File**: `rules/style-consistency.md`
- **Details**: Respect block styling patterns and project theming

## Workflow

1. **Project Analysis**: Identify project structure, package manager, and shadcn-svelte version
2. **Block Selection**: Choose appropriate block based on user requirements
3. **Installation**: Install block using correct package manager and version
4. **File Organization**: Move generated files to correct locations
5. **Integration**: Integrate block with existing project structure
6. **Styling**: Ensure consistent styling with project theme

## Dependencies

- Svelte ^5
- SvelteKit ^2
- shadcn-svelte
- Compatible package manager (pnpm preferred)

## Notes

- Always verify project compatibility before installing blocks
- Check for existing components that might conflict with block components
- Test block functionality after installation
- Maintain project's existing routing structure
