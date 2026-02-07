---
name: command-consistency
description: Rules for maintaining consistent pnpm command usage
---

# Command Consistency Rules

## Rule: Use pnpm Commands Exclusively

Always use `pnpm` prefix for all package management commands.

### Command Mapping

| npm/yarn command | pnpm equivalent |
|------------------|-----------------|
| `npm install` | `pnpm install` |
| `npm add <package>` | `pnpm add <package>` |
| `npm add <package> --save-dev` | `pnpm add <package> --save-dev` |
| `npm run <script>` | `pnpm run <script>` |
| `npm update` | `pnpm update` |
| `npm uninstall <package>` | `pnpm remove <package>` |
| `yarn install` | `pnpm install` |
| `yarn add <package>` | `pnpm add <package>` |
| `yarn run <script>` | `pnpm run <script>` |

### Auto-Replacement Rules

When encountering commands with other package manager prefixes:

1. **Identify the command**: Look for `npm`, `yarn`, `npx`, `yarn dlx`
2. **Replace prefix**: Change to `pnpm` or `pnpm dlx` respectively
3. **Preserve arguments**: Keep all flags and parameters unchanged

### Examples

**Correct Usage:**
```bash
pnpm install
pnpm add express
pnpm add typescript --save-dev
pnpm run build
pnpm dlx create-react-app my-app
```

**Incorrect Usage (needs replacement):**
```bash
npm install  # Should be: pnpm install
yarn add lodash  # Should be: pnpm add lodash
npx tsc --init  # Should be: pnpm dlx tsc --init
```

### Workspace Commands

For workspace projects:
```bash
pnpm -F <package> install  # Install for specific package
pnpm -r install  # Install for all packages
pnpm workspace run <script>  # Run script in workspace
```
