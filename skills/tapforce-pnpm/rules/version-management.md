---
name: version-management
description: Rules for strict version management and pinning strategies with pnpm ^10.0.0
---

# Version Management Rules

## Rule: Strict Version Pinning

Always enforce strict version management for pnpm ^10.0.0 and dependencies.

### Global Version Enforcement

#### Installation Methods
```bash
# Method 1: Install specific version globally
npm install -g pnpm@10.20.0

# Method 2: Use pnpm to manage itself
pnpm install -g pnpm@10.20.0

# Method 3: Lock to major version (allows patch updates)
pnpm install -g pnpm@^10.0.0

# Method 4: Lock to exact version (no updates)
pnpm install -g pnpm@10.20.0 --save-exact
```

#### Version Verification
```bash
# Check current version
pnpm --version

# Verify meets minimum requirement
pnpm --version | grep -E "^10\." || echo "ERROR: pnpm version must be >= 10.0.0"
```

### Project-Level Version Control

#### package.json Configuration
```json
{
  "packageManager": "pnpm@10.20.0",
  "engines": {
    "pnpm": ">=10.0.0",
    "node": ">=20.0.0"
  },
  "volta": {
    "pnpm": "10.20.0"
  }
}
```

#### .npmrc Strict Settings
```ini
# Force exact versions when adding packages
save-exact=true

# Prevent automatic updates
package-manager-strict=true

# Use peer dependencies strictly
strict-peer-dependencies=true

# Prefer exact versions in lockfile
resolution-mode=highest
```

### Dependency Version Strategies

#### Exact Version Pinning
```bash
# Add exact version
pnpm add express@4.18.2 --save-exact

# Add dev dependency with exact version
pnpm add typescript@5.3.3 --save-dev --save-exact

# Update to specific version
pnpm update express@4.18.2
```

#### Range Management
```bash
# Allow patch updates only
pnpm add express@^4.18.2

# Allow minor updates
pnpm add express@~4.18.0

# Allow major updates (use with caution)
pnpm add express@*
```

### Team Synchronization

#### CI/CD Version Enforcement
```yaml
# .github/workflows/ci.yml
- name: Setup pnpm
  uses: pnpm/action-setup@v2
  with:
    version: 10.20.0

- name: Verify pnpm version
  run: pnpm --version
```

#### Docker Version Pinning
```dockerfile
# Dockerfile
FROM node:20-alpine
RUN npm install -g pnpm@10.20.0
```

#### Local Development Scripts
```json
// package.json scripts
{
  "scripts": {
    "verify-pnpm": "pnpm --version | grep -E '^10\\.' || (echo 'ERROR: pnpm version must be >= 10.0.0' && exit 1)",
    "sync-pnpm": "npm install -g pnpm@10.20.0",
    "check-versions": "pnpm outdated"
  }
}
```

### Lock File Management

#### Strict Lock File Behavior
```ini
# .npmrc
lockfile-version=6.0
prefer-frozen-lockfile=true
frozen-lockfile=true
```

#### Lock File Validation
```bash
# Validate lock file integrity
pnpm install --frozen-lockfile

# Check for lock file drift
pnpm install --prefer-frozen-lockfile

# Update lock file with exact versions
pnpm install --save-exact
```

### Environment-Specific Strategies

#### Development Environment
```bash
# Use latest stable for development
pnpm install -g pnpm@latest

# Allow pre-release features
pnpm install -g pnpm@next
```

#### Production Environment
```bash
# Use exact pinned version
pnpm install -g pnpm@10.20.0 --save-exact

# Freeze lock file
pnpm install --frozen-lockfile
```

#### CI/CD Environment
```bash
# Always use specific version
npm install -g pnpm@10.20.0

# Verify no version drift
pnpm --version
```

### Troubleshooting Version Issues

#### Common Version Conflicts
```bash
# Check for multiple pnpm versions
which pnpm
npm list -g pnpm

# Clean global installation
npm uninstall -g pnpm
pnpm install -g pnpm@10.20.0

# Reset local pnpm
rm -rf ~/.pnpm-store
pnpm install
```

#### Version Upgrade Strategy
```bash
# Check current version
pnpm --version

# Test new version in isolated environment
npx pnpm@10.21.0 --version

# Upgrade globally
pnpm install -g pnpm@10.21.0

# Update project packageManager field
# Update package.json "packageManager": "pnpm@10.21.0"
```

### Best Practices

1. **Always pin pnpm to >= 10.0.0** in project configuration
2. **Use exact versions** for production dependencies
3. **Implement CI/CD version checks** to prevent drift
4. **Document version requirements** in project README
5. **Regular security updates** while maintaining major version
6. **Team-wide version synchronization** through shared configuration

### Examples

**Correct Version Management:**
```bash
# Project setup with strict versioning
echo "packageManager: pnpm@10.20.0" >> package.json
echo "save-exact=true" >> .npmrc
pnpm add express@4.18.2 --save-exact
```

**Incorrect Version Management:**
```bash
# No version pinning
pnpm add express  # Could install any version
npm install -g pnpm  # Could install incompatible version
```
