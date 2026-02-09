---
name: tapforce-sveltekit
description: Best practices for setting up and developing Svelte projects using SvelteKit ^2.0.0. Use when considering setup or development based on SvelteKit framework.
license: ISC
metadata:
  author: tapforce
  version: "1.0"
compatibility: Requires Node.js ^20.0.0, Svelte ^5.0.0, SvelteKit ^2.0.0, pnpm ^10.0.0
allowed-tools: Bash Read Write
---

# Tapforce SvelteKit Skill

This skill provides best practices for setting up and developing Svelte projects using SvelteKit ^2.0.0.

## When to Use

Use this skill when:
- Setting up a new SvelteKit project
- Developing applications based on SvelteKit framework
- Migrating existing Svelte projects to SvelteKit ^2.0.0
- Configuring SvelteKit project structure and routing

## Requirements

- Project based on Node.js ^20.0.0
- Project needs Svelte ^5.0.0
- Project needs SvelteKit ^2.0.0
- Prefer using `pnpm ^10.0.0` as default package manager

## CLI Commands

### sv create

Sets up a new SvelteKit project with options for templates and add-ons.

**Usage**:
```bash
npx sv create [options] [path]
```

**Key Options**:
- `--template <name>`: Project template (`minimal`, `demo`, `library`)
- `--types <option>`: Type checking (`ts`, `jsdoc`)
- `--no-types`: Skip type checking (not recommended)
- `--add [add-ons...]`: Add specific add-ons during creation
- `--no-add-ons`: Skip interactive add-ons prompt
- `--install <package-manager>`: Specify package manager (`npm`, `pnpm`, `yarn`, `bun`, `deno`)
- `--no-install`: Skip dependency installation
- `--from-playground <url>`: Create from playground URL

**Examples**:
```bash
# Basic setup with pnpm
pnpm dlx sv create . --install pnpm

# With TypeScript and Tailwind CSS
pnpm dlx sv create . --types ts --add tailwindcss --install pnpm

# From template with add-ons
pnpm dlx sv create . --template demo --add eslint prettier --install pnpm
```

### sv add

Updates existing projects with new functionality and add-ons.

**Usage**:
```bash
npx sv add [add-ons]
```

**Key Options**:
- `-C, --cwd <path>`: Path to project root
- `--no-git-check`: Skip git dirty files check
- `--no-download-check`: Skip download confirmations
- `--install <package-manager>`: Specify package manager
- `--no-install`: Skip dependency installation

**Official Add-ons**:
- `tailwindcss`: Tailwind CSS v4 integration
- `eslint`: Code linting setup
- `prettier`: Code formatting setup
- `playwright`: End-to-end testing
- `vitest`: Unit testing framework
- `mdsvex`: Markdown support
- And more...

**Examples**:
```bash
# Add Tailwind CSS
pnpm dlx sv add tailwindcss

# Add multiple tools
pnpm dlx sv add eslint prettier playwright

# Add with specific package manager
pnpm dlx sv add vitest --install pnpm
```

### sv check

Finds errors and warnings in SvelteKit projects.

**Usage**:
```bash
npx sv check [options]
```

**Key Options**:
- `--workspace <path>`: Path to workspace directory
- `--output <format>`: Output format (`human`, `human-verbose`, `machine`, `machine-verbose`)
- `--watch`: Keep process alive and watch for changes
- `--tsconfig <path>`: Path to TypeScript config
- `--no-tsconfig`: Check only Svelte files
- `--ignore <paths>`: Files/folders to ignore
- `--fail-on-warnings`: Exit with error on warnings
- `--compiler-warnings <warnings>`: Configure warning behavior
- `--diagnostic-sources <sources>`: Specify diagnostic sources (`js`, `svelte`, `css`)
- `--threshold <level>`: Filter diagnostics (`warning`, `error`)

**Examples**:
```bash
# Basic check
pnpm dlx sv check

# Watch mode
pnpm dlx sv check --watch

# With specific output
pnpm dlx sv check --output machine-verbose

# Ignore specific directories
pnpm dlx sv check --ignore "dist,build"
```

### sv migrate

Migrates SvelteKit codebases between versions.

**Usage**:
```bash
npx sv migrate [migration]
```

**Available Migrations**:
- `svelte-5`: Upgrade Svelte 4 to Svelte 5 with runes
- `sveltekit-2`: Upgrade SvelteKit 1 to SvelteKit 2
- `app-state`: Migrate `$app/stores` to `$app/state`
- `self-closing-tags`: Update self-closing element syntax
- `svelte-4`: Upgrade Svelte 3 to Svelte 4
- `package`: Upgrade `@sveltejs/package` v1 to v2
- `routes`: Upgrade pre-release to v1 routing

**Examples**:
```bash
# Interactive migration
pnpm dlx sv migrate

# Specific migration
pnpm dlx sv migrate svelte-5
pnpm dlx sv migrate sveltekit-2
```

## Project Setup

### Creating New Project

For new projects, use the SvelteKit CLI command to initialize the backbone codebase. NEVER create core files manually like `package.json`, `tsconfig.json`, etc., as SvelteKit CLI will create them for you.

**Official documentation**: https://svelte.dev/docs/kit/creating-a-project/llms.txt

**Quick Setup Commands**:
```bash
# Basic setup with pnpm (recommended)
pnpm dlx sv create . --install pnpm
pnpm run dev

# With TypeScript and Tailwind CSS
pnpm dlx sv create . --types ts --add tailwindcss --install pnpm
pnpm run dev

# With common development tools
pnpm dlx sv create . --add eslint prettier vitest --install pnpm
pnpm run dev

# Minimal setup with common addons (no-install approach)
pnpm dlx sv create . --template minimal --add tailwindcss prettier adapter-auto --no-install
echo 'packages:
    - .' > pnpm-workspace.yaml
pnpm install
pnpm run dev

# Using npm
npm dlx sv create . --install npm
npm run dev
```

**Troubleshooting pnpm Setup**:
If you encounter `ERR_PNPM_INVALID_WORKSPACE_CONFIGURATION` error during installation, see the [Package Management](rules/package-management.md) rule for solutions.

**Template Options**:
- `minimal`: Barebones scaffolding
- `demo`: Showcase app with word guessing game
- `library`: Template for Svelte library with `svelte-package`

**Package Manager Support**:
- `pnpm` (recommended)
- `npm`
- `yarn`
- `bun`
- `deno`

### Recommended Packages

Consider using these helpful libraries for SvelteKit development:

**Style Framework/UXUI Framework**:
- tailwindcss ^4.0.0: https://tailwindcss.com/docs/installation/framework-guides/sveltekit
- shadcn-svelte: https://www.shadcn-svelte.com/docs/installation/sveltekit

**Testing Frameworks**:
- vitest: Unit testing with SvelteKit support
- playwright: End-to-end testing
- @sveltejs/adapter-test: Testing adapter for SvelteKit

**Development Tools**:
- eslint: Code linting with Svelte plugin
- prettier: Code formatting with Svelte plugin
- mdsvex: Markdown support in Svelte
- paraglide: Internationalization

## Project Configuration

### Update Package JSON

After project creation, update `package.json` to match project information like `name`, `version`, `description`, etc.

## SvelteKit Features

### Respect Svelte ^5 and SvelteKit ^2 Features

Ensure all Svelte code (including Svelte and SvelteKit) uses the latest features and coding style from Svelte ^5 and SvelteKit ^2.

**Available features from Svelte ^5**: `$state`, `$effect`, `$inspect`, etc.

**AVOID** legacy features from older versions. If you find other skills or rules teaching practices with Svelte/SvelteKit features, learn and follow the latest approaches.

**Official documentation**: https://svelte.dev/docs/kit/migrating-to-sveltekit-2/llms.txt

## SvelteKit Architecture

### Project Structure

Understand SvelteKit project structure and how it works.

**Official documentation**: https://svelte.dev/docs/kit/project-structure/llms.txt

### Project Types

SvelteKit supports a wide range of project types. Understand the different kinds available.

**Official documentation**: https://svelte.dev/docs/kit/project-types/llms.txt

### Routing System

SvelteKit has a unique routing system. Understand how it works.

**Official documentation**:
- Basic: https://svelte.dev/docs/kit/routing/llms.txt
- Advanced: https://svelte.dev/docs/kit/advanced-routing/llms.txt

### Link Handling

SvelteKit provides options to handle links. Understand these capabilities.

**Official documentation**: https://svelte.dev/docs/kit/link-options/llms.txt

## Error Handling

Read and understand how SvelteKit projects can handle errors.

**Official documentation**: https://svelte.dev/docs/kit/errors/llms.txt

## Web Standards

SvelteKit has built-in support for Web Standards and Web APIs. Understand these capabilities.

**Official documentation**: https://svelte.dev/docs/kit/web-standards/llms.txt

## Performance Optimization

SvelteKit has built-in features to help optimize performance. Understand these best practices.

**Official documentation**: https://svelte.dev/docs/kit/performance/llms.txt

## Accessibility

SvelteKit has documentation about accessibility practices. Understand these guidelines.

**Official documentation**: https://svelte.dev/docs/kit/accessibility/llms.txt

## SEO Optimization

SvelteKit has documentation about SEO optimization practices. Understand these guidelines.

**Official documentation**: https://svelte.dev/docs/kit/seo/llms.txt

## Snapshot Feature

SvelteKit supports snapshot data on pages, allowing restoration of values when users navigate back. Understand this feature.

**Official documentation**: https://svelte.dev/docs/kit/snapshots/llms.txt

## State Management

SvelteKit has documentation about state management practices. Understand these approaches.

**Official documentation**: https://svelte.dev/docs/kit/state-management/llms.txt

## Rules

This skill includes the following rules:

### Project Setup
- **Rule**: [project-setup](rules/project-setup.md)
- **Description**: Rules for setting up new SvelteKit projects using CLI

### Version Requirements
- **Rule**: [version-requirements](rules/version-requirements.md)
- **Description**: Rules for ensuring correct Node.js, Svelte, and SvelteKit versions

### Modern Features
- **Rule**: [modern-features](rules/modern-features.md)
- **Description**: Rules for using Svelte ^5 and SvelteKit ^2 modern features

### Package Management
- **Rule**: [package-management](rules/package-management.md)
- **Description**: Rules for using pnpm and managing dependencies in SvelteKit projects

## Best Practices

- Always use SvelteKit CLI for new project setup
- Prefer pnpm as the package manager
- Use Svelte ^5 and SvelteKit ^2 modern features
- Follow official SvelteKit documentation patterns
- Implement proper error handling and accessibility
- Optimize for performance and SEO
- Use appropriate project types for your use case
- Leverage SvelteKit's routing system effectively
