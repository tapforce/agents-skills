---
name: package-management
description: Rules for using pnpm and managing dependencies in SvelteKit projects
---

# Package Management Rules

## Package Manager Preference

### Use pnpm by Default

**ALWAYS** prefer `pnpm` as the package manager for SvelteKit projects.

#### Required pnpm Version
- **Minimum**: pnpm ^10.0.0
- **Recommended**: Latest stable version
- **Check**: `pnpm --version`

#### Why pnpm?
- Better disk space efficiency
- Faster installation times
- More reliable dependency resolution
- Better monorepo support

## Dependency Management

### Core Dependencies

For SvelteKit projects, ensure these core dependencies:

```json
{
  "dependencies": {
    "@sveltejs/kit": "^2.0.0",
    "svelte": "^5.0.0"
  },
  "devDependencies": {
    "@sveltejs/adapter-auto": "^3.0.0",
    "@sveltejs/adapter-node": "^5.0.0",
    "svelte": "^5.0.0",
    "vite": "^6.0.0"
  }
}
```

### Recommended Additional Dependencies

#### Styling Frameworks
```bash
# Tailwind CSS
pnpm add -D tailwindcss postcss autoprefixer @tailwindcss/typography

# shadcn-svelte
pnpm add -D @shadcn/svelte clsx tailwind-merge lucide-svelte
```

#### Development Tools
```bash
# TypeScript support
pnpm add -D typescript @types/node

# Testing
pnpm add -D vitest @sveltejs/adapter-test

# Linting
pnpm add -D eslint @typescript-eslint/parser @typescript-eslint/eslint-plugin eslint-plugin-svelte
```

## Package Commands

### Standard Commands

Use these pnpm commands consistently:

```bash
# Install dependencies
pnpm install

# Add production dependency
pnpm add <package>

# Add development dependency
pnpm add -D <package>

# Add exact version
pnpm add <package>@exact

# Update dependencies
pnpm update

# Run scripts
pnpm run <script>

# Remove dependency
pnpm remove <package>
```

### SvelteKit Specific Commands

```bash
# Development server
pnpm run dev

# Build for production
pnpm run build

# Preview production build
pnpm run preview

# Type checking
pnpm run check

# Linting
pnpm run lint

# Formatting
pnpm run format
```

## Workspace Configuration

### Monorepo Setup

For monorepo SvelteKit projects:

```yaml
# pnpm-workspace.yaml
packages:
  - packages/*
  - apps/*
```

### Package.json Configuration

```json
{
  "name": "my-sveltekit-app",
  "version": "0.0.1",
  "packageManager": "pnpm@10.20.0",
  "scripts": {
    "dev": "vite dev",
    "build": "vite build",
    "preview": "vite preview",
    "check": "svelte-kit sync && svelte-check --tsconfig ./tsconfig.json",
    "check:watch": "svelte-kit sync && svelte-check --tsconfig ./tsconfig.json --watch",
    "lint": "prettier --plugin-search-dir . --check . && eslint .",
    "format": "prettier --plugin-search-dir . --write ."
  },
  "devDependencies": {
    "@sveltejs/adapter-auto": "^3.0.0",
    "@sveltejs/kit": "^2.0.0",
    "prettier": "^3.0.0",
    "prettier-plugin-svelte": "^3.0.0",
    "svelte": "^5.0.0",
    "svelte-check": "^4.0.0",
    "typescript": "^5.0.0",
    "vite": "^6.0.0"
  },
  "type": "module"
}
```

## Version Pinning

### Strict Version Management

Pin critical dependencies for consistency:

```json
{
  "dependencies": {
    "svelte": "5.0.0",
    "@sveltejs/kit": "2.0.0"
  },
  "devDependencies": {
    "pnpm": "10.20.0"
  }
}
```

### Engine Constraints

```json
{
  "engines": {
    "node": ">=20.0.0",
    "pnpm": ">=10.0.0"
  }
}
```

## Dependency Best Practices

### Security Updates

```bash
# Check for vulnerabilities
pnpm audit

# Fix vulnerabilities
pnpm audit --fix

# Update specific package
pnpm update <package>
```

### Clean Installation

```bash
# Clean slate installation
rm -rf node_modules pnpm-lock.yaml
pnpm install
```

### Dependency Optimization

```bash
# Check for unused dependencies
pnpm why <package>

# List dependencies
pnpm list --depth=0

# Outdated packages
pnpm outdated
```

## Common Scenarios

### Adding Tailwind CSS

```bash
# Install Tailwind CSS
pnpm add -D tailwindcss postcss autoprefixer
pnpm dlx tailwindcss init -p

# Configure tailwind.config.js
# Add Tailwind directives to app.css
```

### Adding shadcn-svelte

```bash
# Install shadcn-svelte
pnpm add -D @shadcn/svelte clsx tailwind-merge lucide-svelte

# Initialize shadcn
pnpm dlx shadcn-svelte@latest init
```

### Setting up Testing

```bash
# Install Vitest and SvelteKit test adapter
pnpm add -D vitest @sveltejs/adapter-test

# Configure vitest.config.ts
# Add test scripts to package.json
```

## Troubleshooting

### Common Issues

1. **Node modules conflicts**: Use `pnpm install --force`
2. **Version mismatches**: Check `pnpm why <package>`
3. **Cache issues**: Clear with `pnpm store prune`
4. **Permission errors**: Use `pnpm install --ignore-scripts`

### Dependency Resolution

```bash
# Check dependency tree
pnpm list --all

# Find conflicting versions
pnpm why <package>

# Resolve peer dependency issues
pnpm install --strict-peer-deps
```

## Performance Optimization

### Installation Speed

```bash
# Use strict dependencies
pnpm install --strict-peer-deps

# Prefer offline mode
pnpm install --offline

# Use frozen lockfile in CI
pnpm install --frozen-lockfile
```

### Build Optimization

```bash
# Optimize dependencies
pnpm build

# Analyze bundle size
pnpm add -D @rollup/plugin-analyzer
```
