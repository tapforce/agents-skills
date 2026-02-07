---
name: version-requirements
description: Rules for ensuring correct Node.js, Svelte, and SvelteKit versions
---

# Version Requirements Rules

## Required Versions

Ensure projects meet these minimum version requirements:

### Node.js
- **Required**: Node.js ^20.0.0
- **Recommended**: Latest LTS version
- **Check command**: `node --version`

### Svelte
- **Required**: Svelte ^5.0.0
- **Features**: Modern Svelte 5 features like `$state`, `$effect`, `$inspect`
- **Check command**: Check `package.json` dependencies

### SvelteKit
- **Required**: SvelteKit ^2.0.0
- **Features**: Modern SvelteKit 2 features and patterns
- **Check command**: Check `package.json` dependencies

### Package Manager
- **Preferred**: pnpm ^10.0.0
- **Check command**: `pnpm --version`

## Version Validation

### Automated Environment Validation

**ALWAYS** use the automated validation scripts before starting development:

```bash
# Node.js-based validation (recommended)
node references/environment-check.js

# Shell-based validation (alternative)
./references/environment-check.sh
```

### Package Script Integration

Add this script to `package.json` for easy access:

```json
{
  "scripts": {
    "check-env": "node references/environment-check.js",
    "validate": "node references/environment-check.js"
  }
}
```

Then run: `pnpm run check-env`

### Manual Validation (Fallback)

If automated scripts aren't available, validate manually:

```bash
# Check Node.js version
node --version

# Check pnpm version
pnpm --version
```

### During Project Setup

Ensure CLI creates project with correct versions:

```bash
# Verify SvelteKit version in package.json
grep "sveltekit" package.json

# Verify Svelte version in package.json
grep "svelte" package.json
```

### Package.json Version Configuration

Add version constraints to ensure compatibility:

```json
{
  "engines": {
    "node": ">=20.0.0"
  },
  "packageManager": "pnpm@10.20.0",
  "dependencies": {
    "@sveltejs/kit": "^2.0.0",
    "svelte": "^5.0.0"
  }
}
```

## Version Compatibility

### Supported Combinations

- Node.js ^20.0.0 + Svelte ^5.0.0 + SvelteKit ^2.0.0 ✅
- Node.js ^18.0.0 + Svelte ^5.0.0 + SvelteKit ^2.0.0 ❌ (Node.js too old)
- Node.js ^20.0.0 + Svelte ^4.0.0 + SvelteKit ^2.0.0 ❌ (Svelte too old)
- Node.js ^20.0.0 + Svelte ^5.0.0 + SvelteKit ^1.0.0 ❌ (SvelteKit too old)

### Migration Requirements

When upgrading projects:
1. Upgrade Node.js to ^20.0.0 first
2. Upgrade Svelte to ^5.0.0
3. Upgrade SvelteKit to ^2.0.0
4. Update code to use modern features
5. Test compatibility thoroughly

## Version Pinning Strategies

### Development Environment
```bash
# Pin specific versions for consistency
pnpm add svelte@5.0.0 @sveltejs/kit@2.0.0
```

### Production Environment
```json
{
  "dependencies": {
    "svelte": "5.0.0",
    "@sveltejs/kit": "2.0.0"
  }
}
```

## Troubleshooting Version Issues

### Automated Validation

Use the automated scripts for comprehensive troubleshooting:

```bash
# Run full environment validation
pnpm run check-env

# Or use the scripts directly
node references/environment-check.js
./references/environment-check.sh
```

The automated validation provides:
- ✅ Detailed version compatibility matrix
- ✅ Specific fix suggestions for each issue
- ✅ Color-coded status indicators
- ✅ Exit codes for CI/CD integration

### Common Problems

1. **Node.js version too old**: Upgrade to Node.js ^20.0.0
2. **Svelte version mismatch**: Update to Svelte ^5.0.0
3. **SvelteKit version outdated**: Update to SvelteKit ^2.0.0
4. **Package manager conflicts**: Use pnpm consistently

### Resolution Commands

```bash
# Update to latest compatible versions
pnpm update svelte@^5.0.0 @sveltejs/kit@^2.0.0

# Clean install with correct versions
rm -rf node_modules pnpm-lock.yaml
pnpm install

# Validate after fixes
pnpm run check-env
```
