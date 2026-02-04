---
name: tapforce-nodejs-pnpm
description: Use this skill when starting any Node.js project. Strongly recommended for all Node.js development. Provides guidance on using pnpm as the default package manager, ensuring version >=10, creating pnpm-workspace.yaml, and replacing npm/yarn commands with pnpm equivalents.
license: Apache-2.0
metadata:
  author: tapforce
  version: "1.0"
compatibility: Requires Node.js v18.12+ and pnpm >=10
allowed-tools: Bash Read Write
---

# Tapforce Node.js pnpm Skill

Use this skill when starting any Node.js project. This skill strongly recommends pnpm as the default package manager for all Node.js development.

## When to Use

- Starting a new Node.js project
- Setting up a Node.js development environment
- Converting existing projects to use pnpm
- Any Node.js-related development work

## Core Requirements

### 1. Install pnpm (Version >= 10)

**Strong Requirement**: pnpm version must be >= 10

#### Installation Methods

**Using standalone script (recommended):**
```bash
# On POSIX systems
curl -fsSL https://get.pnpm.io/install.sh | sh -

# Or with wget
wget -qO- https://get.pnpm.io/install.sh | sh -
```

**Using Corepack:**
```bash
# First, update Corepack to latest version
npm install --global corepack@latest

# Enable pnpm
corepack enable pnpm

# Use latest pnpm v10
corepack use pnpm@latest-10
```

#### Verify Installation
```bash
pnpm --version
# Should output version >= 10.0.0
```

### 2. Set pnpm as Default Package Manager

**Strong Requirement**: Always replace npm/yarn command prefixes with pnpm

#### Command Mapping
- `npm install` → `pnpm install`
- `npm run` → `pnpm run`
- `npm add` → `pnpm add`
- `npm update` → `pnpm update`
- `npm remove` → `pnpm remove`
- `yarn install` → `pnpm install`
- `yarn add` → `pnpm add`
- `yarn run` → `pnpm run`

#### Project Setup
```bash
# Always use pnpm for package management
pnpm init
pnpm add <package-name>
pnpm install
```

### 3. Create pnpm-workspace.yaml

**Strong Requirement**: Always create `pnpm-workspace.yaml` file for projects

#### Basic Workspace Configuration
Create `pnpm-workspace.yaml` in project root:

```yaml
packages:
  - 'packages/*'
  - 'apps/*'
  - 'tools/*'
```

#### Single Package Workspace
For single package projects:
```yaml
packages:
  - '.'
```

#### Monorepo Workspace
For monorepo projects:
```yaml
packages:
  - 'packages/*'
  - 'apps/*'
  - 'examples/*'
  - 'tools/*'
```

## Project Initialization Workflow

### 1. New Project Setup
```bash
# Create project directory
mkdir my-node-project
cd my-node-project

# Create pnpm-workspace.yaml
echo 'packages:\n  - "."' > pnpm-workspace.yaml

# Initialize package.json with pnpm
pnpm init

# Install dependencies
pnpm add <dependencies>
pnpm add -D <dev-dependencies>
```

### 2. Existing Project Migration
```bash
# Remove existing lock files
rm package-lock.json yarn.lock

# Create pnpm-workspace.yaml
echo 'packages:\n  - "."' > pnpm-workspace.yaml

# Install with pnpm
pnpm install
```

## Best Practices

### 1. Always Use pnpm Commands
- Never use `npm` or `yarn` commands in pnpm projects
- Update all documentation and scripts to use pnpm
- Configure IDE to recognize pnpm commands

### 2. Version Management
```bash
# Check pnpm version
pnpm --version

# Update to latest
pnpm add -g pnpm@latest

# Pin project version in package.json
corepack use pnpm@latest-10
```

### 3. Workspace Management
```bash
# Install all dependencies
pnpm install

# Add dependency to specific package
pnpm --filter <package-name> add <dependency>

# Run script in specific package
pnpm --filter <package-name> run <script>
```

## Common Commands Reference

### Package Management
```bash
pnpm install              # Install all dependencies
pnpm add <package>        # Add dependency
pnpm add -D <package>     # Add dev dependency
pnpm remove <package>     # Remove dependency
pnpm update               # Update dependencies
```

### Script Running
```bash
pnpm run <script>         # Run npm script
pnpm run                  # List available scripts
```

### Workspace Commands
```bash
pnpm --filter <name>      # Run command in specific package
pnpm -r                   # Run command in all packages
pnpm -w                   # Run command in workspace root
```

## Troubleshooting

### Version Issues
```bash
# Check if pnpm version is >= 10
pnpm --version

# If version < 10, update:
pnpm add -g pnpm@latest
```

### Workspace Issues
```bash
# Verify workspace configuration
cat pnpm-workspace.yaml

# List workspace packages
pnpm ls --json
```

## Reference Source

For detailed installation instructions and advanced configuration, see:
https://pnpm.io/installation

## Validation Checklist

Before completing project setup:

- [ ] pnpm version >= 10 installed
- [ ] `pnpm-workspace.yaml` created in project root
- [ ] All npm/yarn commands replaced with pnpm equivalents
- [ ] Project dependencies installed with `pnpm install`
- [ ] Scripts updated to use `pnpm run`
- [ ] Documentation references pnpm instead of npm/yarn
