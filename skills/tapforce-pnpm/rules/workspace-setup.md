---
name: workspace-setup
description: Rules for setting up and managing pnpm workspaces
---

# Workspace Setup Rules

## Rule: Ensure Workspace Configuration

Always ensure proper workspace configuration for pnpm projects.

### Workspace File Requirements

1. **File Location**: `pnpm-workspace.yaml` must be at project root
2. **Required Property**: Must contain `packages` array
3. **Default Configuration**: Use `.` for single package projects

### Creating Workspace File

**Default setup for single package:**
```yaml
packages:
  - .
```

**Multi-package setup:**
```yaml
packages:
  - 'packages/*'
  - 'apps/*'
  - 'tools/*'
```

### Validation Rules

Before running any pnpm commands:

1. **Check file exists**:
   ```bash
   test -f pnpm-workspace.yaml || echo "Workspace file missing"
   ```

2. **Validate YAML syntax**:
   ```bash
   pnpm install --dry-run  # Will fail if YAML is invalid
   ```

3. **Check packages array**:
   ```bash
   grep -q "packages:" pnpm-workspace.yaml || echo "Missing packages property"
   ```

### Common Patterns

**Monorepo Structure:**
```
project/
├── pnpm-workspace.yaml
├── package.json
├── packages/
│   ├── lib-a/
│   └── lib-b/
└── apps/
    └── web-app/
```

**Workspace Configuration:**
```yaml
packages:
  - 'packages/*'
  - 'apps/*'
```

### Best Practices

1. **Always create workspace file** before installing dependencies
2. **Use relative paths** in packages array
3. **Avoid packages in package.json** - use workspace file instead
4. **Keep workspace file simple** - complex patterns can cause issues

### Examples

**Correct Setup:**
```bash
# Create workspace file first
echo "packages:\n  - ." > pnpm-workspace.yaml

# Then install dependencies
pnpm install
```

**Incorrect Setup:**
```bash
# Installing without workspace file
pnpm install  # May create unexpected node_modules structure

# Using package.json for workspace config
# (should use pnpm-workspace.yaml instead)
```
