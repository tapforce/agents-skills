---
name: tapforce-pnpm
description: Best practices for using pnpm ^10.0.0 in Node.js projects. Use when working with Node.js-based projects.
license: ISC
metadata:
  author: tapforce
  version: "1.0"
compatibility: Requires Node.js ^20.0.0, pnpm ^10.0.0
allowed-tools: Bash Read Write
---

# Tapforce pnpm Skill

This skill provides best practices for using pnpm ^10.0.0 in Node.js projects.

## When to Use

Use this skill when:
- Working with any Node.js project
- Setting up a new Node.js project
- Converting a project to use pnpm
- Managing dependencies in a Node.js project

## Requirements

- Project based on Node.js ^20.0.0
- Local environment with pnpm ^10.0.0 installed

## Validate Current Environment

Before starting to use pnpm, validate the current environment:

1. **Check current package manager**: Verify if pnpm is being used
2. **Check Node.js version**: Ensure compatibility with pnpm
3. **Check project setup**: Verify if the project is configured for pnpm

## Use pnpm

To use pnpm effectively, you must use `pnpm` commands consistently.

### Workspace Configuration

- Always ensure the project has a `pnpm-workspace.yaml` file at the root
- The file must include a `packages` property with an array of relative paths to package directories
- This file MUST exist before running any pnpm commands

### Command Consistency

- Use `pnpm` instead of `npm` or any other package manager for all commands
- If you encounter a command with a different package manager prefix, automatically replace it with `pnpm`

### Creating Workspace Configuration

If you need to create `pnpm-workspace.yaml`, add a `packages` property with `.` as the default value. Avoid creating a `packages` property in `package.json` as it's not stable.

**Default workspace.yaml:**
```yaml
packages:
  - .
```

### Version Pinning

For strict version management with pnpm ^10.0.0:

#### Global Version Management
```bash
# Install specific pnpm version
npm install -g pnpm@10.20.0

# Use pnpm to manage itself
pnpm install -g pnpm@10.20.0

# Lock to major version 10
pnpm install -g pnpm@^10.0.0
```

#### Project-Level Version Control
```json
// package.json
{
  "packageManager": "pnpm@10.20.0",
  "engines": {
    "pnpm": ">=10.0.0"
  }
}
```

#### .npmrc Configuration
```ini
# .npmrc
package-manager-strict=true
save-exact=true
```

#### Team Version Synchronization
```bash
# Verify team version consistency
pnpm --version

# Force specific version in CI
npm install -g pnpm@10.20.0
```

## Common Commands

- `pnpm install` - Install dependencies
- `pnpm add <package>` - Add a dependency
- `pnpm add <package> --save-dev` - Add a dev dependency
- `pnpm add <package>@exact` - Add exact version
- `pnpm update` - Update dependencies
- `pnpm run <script>` - Run a script from package.json
- `pnpm workspace <command>` - Run commands across the workspace

## Rules

This skill includes the following rules:

### Environment Validation
- **Rule**: [environment-validation](rules/environment-validation.md)
- **Description**: Rules for validating pnpm environment before usage

### Command Consistency  
- **Rule**: [command-consistency](rules/command-consistency.md)
- **Description**: Rules for maintaining consistent pnpm command usage

### Workspace Setup
- **Rule**: [workspace-setup](rules/workspace-setup.md)
- **Description**: Rules for setting up and managing pnpm workspaces

### Version Management
- **Rule**: [version-management](rules/version-management.md)
- **Description**: Rules for strict version management and pinning strategies

## Best Practices

- Always use workspace configuration for monorepo projects
- Keep pnpm version consistent across team members (>= 10.0.0)
- Use `pnpm-lock.yaml` for dependency locking
- Prefer `pnpm` over npm/yarn for better performance and disk space efficiency
- Pin pnpm version in package.json with `"packageManager": "pnpm@10.x.x"`
- Use exact versions for production dependencies with `--save-exact`
- Implement strict version management in CI/CD environments
- Regular security updates while maintaining major version compatibility
