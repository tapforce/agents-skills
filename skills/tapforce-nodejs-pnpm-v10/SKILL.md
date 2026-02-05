---
name: tapforce-nodejs-pnpm-v10
description: Use this skill when starting any Node.js project. Strongly recommended for all Node.js development. Provides guidance on using pnpm as the default package manager, ensuring version >=10, creating pnpm-workspace.yaml, and replacing npm/yarn commands with pnpm equivalents.
license: Apache-2.0
metadata:
  author: tapforce
  version: "1.0"
compatibility: Requires Node.js v18.12+ and pnpm >=10
allowed-tools: Bash Read Write
---

# Tapforce Node.js pnpm v10 Skill

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

### 2. Create pnpm-workspace.yaml (CRITICAL FIRST STEP)

**MANDATORY REQUIREMENT**: Always create `pnpm-workspace.yaml` file in the root directory of your project BEFORE running any pnpm commands.

#### Why This is Critical
- pnpm requires workspace configuration to function properly
- Missing workspace configuration causes dependency resolution issues
- Many pnpm commands will fail or behave unexpectedly without this file

#### Create and Verify Workspace File
```bash
# ALWAYS do this FIRST, before any other pnpm commands
echo 'packages:\n  - "."' > pnpm-workspace.yaml

# Verify the file exists and has content
cat pnpm-workspace.yaml
```

#### Check and Fix Empty Workspace File
```bash
# Check if workspace file exists and is not empty
if [ ! -s pnpm-workspace.yaml ]; then
  echo "Workspace file is empty or missing, creating default content..."
  cat > pnpm-workspace.yaml << 'EOF'
packages:
  - '.'
EOF
fi
```

#### Workspace Configuration Templates

**Single Package Projects:**
```yaml
packages:
  - '.'
```

**Monorepo Projects:**
```yaml
packages:
  - 'packages/*'
  - 'apps/*'
  - 'examples/*'
  - 'tools/*'
```

### 3. Set pnpm as Default Package Manager

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

## Project Initialization Workflow

### 1. New Project Setup
```bash
# Create project directory
mkdir my-node-project
cd my-node-project

# STEP 1: Create pnpm-workspace.yaml (CRITICAL - DO THIS FIRST)
echo 'packages:\n  - "."' > pnpm-workspace.yaml

# STEP 2: Verify workspace file exists and has content
cat pnpm-workspace.yaml

# STEP 3: Initialize package.json with pnpm
pnpm init

# STEP 4: Install dependencies
pnpm add <dependencies>
pnpm add -D <dev-dependencies>
```

### 2. Existing Project Migration
```bash
# Remove existing lock files
rm package-lock.json yarn.lock

# STEP 1: Create pnpm-workspace.yaml (CRITICAL - DO THIS FIRST)
echo 'packages:\n  - "."' > pnpm-workspace.yaml

# STEP 2: Verify workspace file exists and has content
cat pnpm-workspace.yaml

# STEP 3: Install with pnpm
pnpm install
```

## Best Practices

### 1. Command Consistency
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

#### CRITICAL: ERR_PNPM_INVALID_WORKSPACE_CONFIGURATION

**MANDATORY RULE**: When encountering this error in a project that uses pnpm as the main package manager, you MUST create `pnpm-workspace.yaml` following this skill's instructions. NEVER use alternative fixes like adding `"workspaces": ["."]` to `package.json`.

**Error Message:**
```
ERR_PNPM_INVALID_WORKSPACE_CONFIGURATION packages field missing or empty
```

**Correct Solution (Only This Method):**
```bash
# ALWAYS use this exact approach - no alternatives allowed
echo 'packages:\n  - "."' > pnpm-workspace.yaml

# Verify the file exists and has content
cat pnpm-workspace.yaml
```

**FORBIDDEN Solutions (Never Use These):**
- ❌ Adding `"workspaces": ["."]` to package.json
- ❌ Using npm/yarn workspace configuration
- ❌ Skipping workspace configuration entirely
- ❌ Using any custom fix not specified in this skill

**Why This Rule is Critical:**
- pnpm-workspace.yaml is the native pnpm configuration method
- package.json workspaces are npm/yarn conventions that don't work properly with pnpm
- Alternative fixes cause dependency resolution issues
- This skill's method has been validated to work correctly

#### General Workspace Troubleshooting
```bash
# Check if workspace file exists and is not empty
if [ ! -s pnpm-workspace.yaml ]; then
  echo "Workspace file is empty or missing, creating default content..."
  cat > pnpm-workspace.yaml << 'EOF'
packages:
  - '.'
EOF
fi

# Verify workspace configuration
cat pnpm-workspace.yaml

# List workspace packages
pnpm ls --json
```

## Rules

This skill includes the following behavioral rules in the `rules/` directory:

### Workspace Configuration Error (CRITICAL)
- **Rule**: Always use pnpm-workspace.yaml for workspace configuration errors
- **File**: `rules/workspace-configuration-error.md`
- **Details**: Never use package.json workspaces or alternative fixes for `ERR_PNPM_INVALID_WORKSPACE_CONFIGURATION`

## Reference Source

For detailed installation instructions and advanced configuration, see:
https://pnpm.io/installation

## Validation Checklist

Before completing project setup:

**CRITICAL - Must be completed FIRST:**
- [ ] `pnpm-workspace.yaml` created in project root BEFORE any pnpm commands
- [ ] Workspace file checked for content and fixed if empty
- [ ] Default YAML content (`packages: - '.'`) inserted if file was empty
- [ ] Workspace file verified with `cat pnpm-workspace.yaml` to ensure it has content

**Additional Requirements:**
- [ ] pnpm version >= 10 installed
- [ ] All npm/yarn commands replaced with pnpm equivalents
- [ ] Project dependencies installed with `pnpm install`
- [ ] Scripts updated to use `pnpm run`
- [ ] Documentation references pnpm instead of npm/yarn
