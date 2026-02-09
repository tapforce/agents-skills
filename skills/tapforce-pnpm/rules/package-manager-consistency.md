---
name: package-manager-consistency
description: Rules for maintaining strict package manager consistency - never switch from pnpm to other package managers
---

# Package Manager Consistency Rules

## Rule: Strict Package Manager Consistency

When you choose to use `pnpm` for a project, you must maintain consistency and never switch to other package managers.

### Core Principle

**Once pnpm, always pnpm** - If you decide to use `pnpm` for a project, you must continue using it for everything in that project.

### Error Handling Protocol

When you encounter package manager-related errors:

1. **Analyze the error**: Understand what's causing the issue with pnpm
2. **Apply your knowledge**: Try to fix the issue using your understanding of pnpm
3. **Use available skills**: Leverage relevant skills to resolve the problem
4. **Never switch**: Do not switch to npm, yarn, or other package managers as a workaround
5. **Stop if unsolvable**: If you cannot resolve the issue with pnpm, stop and seek help rather than switching

### Examples

**Correct Approach:**
```bash
# If pnpm install fails
pnpm install --force  # Try pnpm-specific solutions
pnpm install --no-frozen-lockfile  # Use pnpm flags
# Analyze the error and fix pnpm-specific issues
```

**Incorrect Approach (NEVER do this):**
```bash
# Don't switch to other package managers
npm install  # WRONG - violates consistency rule
yarn install  # WRONG - violates consistency rule
```

### Common Scenarios

#### Dependency Resolution Issues
- **Use**: `pnpm install --force` or `pnpm update`
- **Don't**: Switch to npm to resolve conflicts

#### Permission Issues
- **Use**: `pnpm install --no-optional` or fix permissions
- **Don't**: Use npm as a workaround

#### Lock File Issues
- **Use**: Delete `pnpm-lock.yaml` and run `pnpm install`
- **Don't**: Generate `package-lock.json` with npm

#### Network Issues
- **Use**: `pnpm config set registry` or pnpm-specific network configurations
- **Don't**: Switch package managers due to network issues

### Team Collaboration

When working with teams:
- Ensure all team members use pnpm
- Document pnpm-specific setup in project README
- Include pnpm version in `package.json` `"packageManager"` field
- Use `.npmrc` for team-wide pnpm configurations

### Rationale

Package manager consistency ensures:
- Predictable dependency resolution
- Consistent lock file format
- Team synchronization
- Avoidance of mixed package manager conflicts
- Reliable CI/CD pipelines

### Troubleshooting Resources

When facing pnpm issues:
- Check pnpm documentation
- Review pnpm GitHub issues
- Use pnpm's built-in diagnostics: `pnpm doctor`
- Verify Node.js compatibility
- Check workspace configuration

Remember: **Consistency is more important than convenience**.
