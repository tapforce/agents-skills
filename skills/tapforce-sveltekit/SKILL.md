---
name: tapforce-sveltekit
description: Best practices for setting up and developing Svelte projects using SvelteKit ^2.0.0. Use when considering setup or development based on SvelteKit framework.
license: ISC
metadata:
  author: tapforce
  version: "1.0"
compatibility: Requires Node.js ^20.0.0, Svelte ^5.0.0, SvelteKit ^2.0.0, pnpm
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
- Prefer using `pnpm` as default package manager

## Project Setup

### Creating New Project

For new projects, use the SvelteKit CLI command to initialize the backbone codebase. NEVER create core files manually like `package.json`, `tsconfig.json`, etc., as SvelteKit CLI will create them for you.

**Official documentation**: https://svelte.dev/docs/kit/creating-a-project/llms.txt

**CLI Commands**:
```bash
<package-manager> dlx sv create .
<package-manager> run dev
```

Replace `<package-manager>` with the package manager your project uses. If unknown, use `pnpm` as default.

### Recommended Packages

Consider using these helpful libraries for SvelteKit development:

**Style Framework/UXUI Framework**:
- tailwindcss: https://tailwindcss.com/docs/installation/framework-guides/sveltekit
- shadcn-svelte: https://www.shadcn-svelte.com/docs/installation/sveltekit

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
