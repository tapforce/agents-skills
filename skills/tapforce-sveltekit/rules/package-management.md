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

#### Tailwind CSS ^4.0.0 Setup
```bash
# Install Tailwind CSS v4 with Vite plugin
pnpm add -D tailwindcss @tailwindcss/vite

# Configure vite.config.js
import { sveltekit } from '@sveltejs/kit/vite';
import { defineConfig } from 'vite';
import tailwindcss from '@tailwindcss/vite';

export default defineConfig({
  plugins: [
    tailwindcss(),
    sveltekit(),
  ],
});

# Create CSS file with v4 syntax
echo '@import "tailwindcss";' > src/app.css

# Import CSS in layout
# Add import "../app.css" to src/routes/+layout.svelte
```

**Tailwind CSS v4 Key Features**:
- Vite plugin instead of PostCSS
- Simplified setup with `@import "tailwindcss"`
- No `tailwind.config.js` required for basic usage
- Faster build times with Vite integration
- Enhanced performance and developer experience

##### shadcn-svelte
```bash
# shadcn-svelte components
pnpm add -D @shadcn/svelte clsx tailwind-merge lucide-svelte

# Initialize shadcn
pnpm dlx shadcn-svelte@latest init
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
    "format": "prettier --plugin-search-dir . --write .",
    "check-env": "node references/environment-check.js",
    "validate": "node references/environment-check.js"
  },
  "devDependencies": {
    "@sveltejs/adapter-auto": "^3.0.0",
    "@sveltejs/adapter-node": "^5.0.0",
    "prettier": "^3.0.0",
    "prettier-plugin-svelte": "^3.0.0",
    "svelte": "^5.0.0",
    "svelte-check": "^4.0.0",
    "typescript": "^5.0.0",
    "vite": "^6.0.0",
    "tailwindcss": "^4.0.0",
    "@tailwindcss/vite": "^4.0.0"
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
    "pnpm": "10.20.0",
    "tailwindcss": "4.0.0",
    "@tailwindcss/vite": "4.0.0"
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

#### Tailwind CSS ^4.0.0 Setup
```bash
# Install Tailwind CSS v4 with Vite plugin
pnpm add -D tailwindcss @tailwindcss/vite

# Create CSS file with v4 syntax
echo '@import "tailwindcss";' > src/app.css

# Update vite.config.js
cat > vite.config.js << 'EOF'
import { sveltekit } from '@sveltejs/kit/vite';
import { defineConfig } from 'vite';
import tailwindcss from '@tailwindcss/vite';

export default defineConfig({
  plugins: [
    tailwindcss(),
    sveltekit(),
  ],
});
EOF

# Update layout to import CSS
cat > src/routes/+layout.svelte << 'EOF'
<script>
  import "../app.css";
</script>

<slot />
EOF

# Start development
pnpm run dev
```

**Tailwind CSS v4 Configuration**:
- Uses Vite plugin instead of PostCSS
- Simple CSS import: `@import "tailwindcss";`
- No config file needed for basic setup
- Enhanced performance with Vite integration
- Modern CSS features and optimizations

### Adding shadcn-svelte

```bash
# Install shadcn-svelte
pnpm add -D @shadcn/svelte clsx tailwind-merge lucide-svelte

# Initialize shadcn
pnpm dlx shadcn-svelte@latest init
```

### Tailwind CSS v4 Features

### Key Changes in Tailwind CSS v4

- **Vite Plugin**: Uses `@tailwindcss/vite` instead of PostCSS
- **Simplified Setup**: No `tailwind.config.js` required for basic usage
- **CSS Import**: Simple `@import "tailwindcss";` in CSS file
- **Performance**: Faster build times with Vite integration

### Configuration Examples

#### Basic Setup
```javascript
// vite.config.js
import { sveltekit } from '@sveltejs/kit/vite';
import { defineConfig } from 'vite';
import tailwindcss from '@tailwindcss/vite';

export default defineConfig({
  plugins: [
    tailwindcss(),
    sveltekit(),
  ],
});
```

#### CSS Import
```css
/* src/app.css */
@import "tailwindcss";
```

#### Layout Integration
```svelte
<!-- src/routes/+layout.svelte -->
<script>
  import "../app.css";
</script>

<slot />
```

### Advanced Configuration

#### Custom Theme
```css
/* src/app.css */
@import "tailwindcss";

@theme {
  --color-primary: #3b82f6;
  --font-family-sans: "Inter", system-ui, sans-serif;
}

/* Use custom theme */
.text-primary {
  color: theme(--color-primary);
}
```

#### Component Styling
```svelte
<style lang="postcss">
  @reference "tailwindcss";
  
  .custom-button {
    @apply bg-blue-500 text-white px-4 py-2 rounded;
  }
</style>
```

## Setting up Testing

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

### pnpm Workspace Configuration Error

When installing SvelteKit with pnpm, you may encounter this error:

```
ERR_PNPM_INVALID_WORKSPACE_CONFIGURATION  packages field missing or empty
```

This error occurs because pnpm expects a workspace configuration when installing packages in a directory structure.

#### Solution Options

**Option 1: Use --no-install flag (Recommended)**
```bash
# Create SvelteKit project without installing dependencies
pnpm dlx sv create . --no-install

# Create pnpm workspace configuration
echo 'packages:
    - .' > pnpm-workspace.yaml

# Install dependencies
pnpm install

# Start development
pnpm run dev
```

**Option 2: Create workspace configuration first**
```bash
# Create pnpm workspace configuration before SvelteKit setup
echo 'packages:
    - .' > pnpm-workspace.yaml

# Then install SvelteKit normally
pnpm dlx sv create . --install pnpm
```

#### Why This Happens

- pnpm requires workspace configuration for monorepo-style setups
- SvelteKit CLI creates a project structure that pnpm interprets as needing workspace configuration
- The `pnpm-workspace.yaml` file tells pnpm which directories contain packages

#### Workspace Configuration Examples

**Single Project Setup**:
```yaml
# pnpm-workspace.yaml
packages:
    - .
```

**Monorepo Setup**:
```yaml
# pnpm-workspace.yaml
packages:
    - packages/*
    - apps/*
    - .
```

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
