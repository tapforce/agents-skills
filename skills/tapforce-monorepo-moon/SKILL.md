---
name: tapforce-monorepo-moon
description: Guide for setting up monorepo projects using Moon as the monorepo manager. Use when project mentions monorepo, creating new projects, or complex requirements with multiple applications that need to be split into packages.
license: Apache-2.0
metadata:
  author: tapforce
  version: "1.0"
compatibility: Requires Moon v1 or v2, Node.js, pnpm preferred
---

# Moon Monorepo Setup Guide

This skill provides guidance for setting up and managing monorepo projects using Moon as the monorepo manager. Moon is a build system that manages your project's workspace, tasks, and dependencies.

**Source**: https://moonrepo.dev/docs

**Compatibility**: This skill supports Moon version 1 and 2 only.

## Use When

- Project mentions using monorepo architecture
- Creating new complex projects with multiple applications
- Project requirements indicate need to split into multiple packages
- Existing project needs monorepo structure

## Environment Check

### Verify Moon Installation

1. Check if Moon is available locally:
   ```bash
   pnpm moon --version
   ```
   - If this shows version with major number 1 or 2, Moon is correctly installed

2. If local check fails, check global installation:
   ```bash
   moon --version
   ```

### Installation Cases

- **No Moon found**: Install Moon using Node.js package manager (prefer `pnpm` if available)
- **Wrong version**: If major version is not 1 or 2, skip this skill as it only supports v1 and v2

### Project Structure Check

Check if the project root has a `.moon` folder:
- **No `.moon` folder**: You'll need to initialize a Moon project
- **`.moon` folder exists**: Adapt current structure to continue using Moon

### Global Moon Setup

If Moon is installed globally but not locally:
1. Find `package.json` at project root
2. Add moon script to simulate local command:
   ```json
   {
     "scripts": {
       "moon": "pnpm moon"
     }
   }
   ```
3. Use `pnpm moon <command>` for all Moon commands

## Initialize Moon Project

To initialize a new Moon project:

```bash
pnpm moon init
```

After initialization:
1. Validate and create required folders if missing:
   - `apps/` - stores applications
   - `packages/` - stores packages
2. Ensure proper workspace structure

## Toolchain Setup

Validate and setup toolchain following the official guidelines: https://moonrepo.dev/docs/setup-toolchain

## Configuration Files

Create configuration files as needed (don't create all files unnecessarily):

- **workspace file**: https://moonrepo.dev/docs/config/workspace
- **extension file**: https://moonrepo.dev/docs/config/extensions  
- **toolchain file**: https://moonrepo.dev/docs/config/toolchain
- **task file**: https://moonrepo.dev/docs/config/tasks
- **moon file (app|package scope)**: https://moonrepo.dev/docs/config/project

## Rules

This skill includes behavioral rules in the `rules/` directory that provide guidance for:
- Moon configuration best practices
- pnpm workspace integration patterns  
- Dependency management workflows

## Common Tasks

- Initialize project: `pnpm moon init`
- Setup workspace: `pnpm moon setup`
- Run tasks: `pnpm moon <task>`
- Check configuration: `pnpm moon check`
