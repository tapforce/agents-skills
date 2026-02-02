---
title: pr-setup
description: Steps and practices to prepare project to use SvelteKit.
tags:
  - sveltekit
  - setup
---

## check project codebase, ensure it has `sveltekit` package installed.

Read the `package.json` file, check if `sveltekit` package is installed.

If `sveltekit` package is not installed in `package.json`, stop flow and asking user should manually install `Sveltekit` or start new project from scratch.

If `package.json` not exist, start new project with Sveltekit following document at: https://svelte.dev/docs/kit/creating-a-project.

Use package manager to user prefer to install Sveltekit. If user not specify, use `pnpm` as default.

When install via command, carefully check the path to root project. If current folder is root of project then command should replace project name to `.`:

**Example:**

```sh
pnpx sv create . # mean: install to current folder
```

If user specify path to root project, make sure it is absolute path.

```sh
pnpx sv create [path to root project] # root project is path to sub-folder of current folder
```

When install, Sveltekit command will show prompt, let's user answer prompts and install related packages user choosed.

## Reference

- [SvelteKit - Creating a project](https://svelte.dev/docs/kit/creating-a-project)
