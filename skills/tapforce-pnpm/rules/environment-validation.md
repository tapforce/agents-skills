---
name: environment-validation
description: Rules for validating pnpm environment before usage
---

# Environment Validation Rules

## Rule: Validate pnpm Environment

Always validate the environment before using pnpm commands.

### Validation Steps

1. **Check pnpm Installation**
   ```bash
   pnpm --version
   ```
   - Must return version ^10.0.0
   - If not installed, install with: `npm install -g pnpm@latest`

2. **Check Node.js Compatibility**
   ```bash
   node --version
   ```
   - Must be Node.js ^20.0.0
   - pnpm ^10.0.0 requires Node.js 18.17 or later

3. **Check Project Configuration**
   ```bash
   ls -la pnpm-workspace.yaml
   ```
   - File must exist at project root
   - If missing, create with default configuration

### Error Handling

- If pnpm version is below 10.0.0, upgrade with: `pnpm install -g pnpm@latest`
- If Node.js version is incompatible, upgrade Node.js first
- If workspace file is missing, create it before proceeding

### Examples

**Correct Usage:**
```bash
# Validate environment first
pnpm --version  # Should show 10.x.x
node --version  # Should show 20.x.x or higher
ls pnpm-workspace.yaml  # Should exist

# Then proceed with commands
pnpm install
```

**Incorrect Usage:**
```bash
# Skipping validation
pnpm install  # May fail if environment not ready
```
