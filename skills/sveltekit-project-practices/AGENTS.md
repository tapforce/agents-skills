---
name: sveltekit-project-practices
description: Guideline setup and develop application base on SvelteKit, tailwindcss, shadcn-svelte framework.
metadata:
  author: Tapforce<office@tapforce.com>
  version: "1.0.0"
---

# SvelteKit Project Practices

Comprehensive guide setup and develop application base on SvelteKit, tailwindcss, shadcn-svelte framework.

## When to apply

Reference these guidelines when:

- Start or develop a project application with Sveltekit, Tailwindcss, Shadcn-svelte as base framework.

## Rule Categories by Priority

| Priority | Category | Prefix    | Description                                                       |
| -------- | -------- | --------- | ----------------------------------------------------------------- |
| 1        | setup    | `setup-`  | Set up project with base packages, modules, or frameworks.        |
| 2        | styling  | `style-`  | Practices styling application with Tailwindcss and shadcn-svelte. |
| 3        | Svelte   | `svelte-` | Practices using Sveltekit features.                               |
| 4        | Abstract | `abs-`    | Abstract practices for Sveltekit project.                         |

## Quick Reference

## How to Use

Read individual rule files for detailed explanations and code examples:

```
rules/async-parallel.md
rules/bundle-barrel-imports.md
```

Each rule file contains:

- Brief explanation of why it matters
- Incorrect code example with explanation
- Correct code example with explanation
- Additional context and references

## Full Compiled Document

For the complete guide with all rules expanded: `AGENTS.md`

---
# Use `@utility` block when need define custom class | File: rules/style-use-tailwindcss-utility-block.md

Guide correct way to make style application with Tailwindcss and it's classes.

sveltekit, svelte5, tailwindcss, styling

## Use `@utility` block when need define custom class

When need to define custom class, following instruction of tailwindcss version 4 that only use css to define custom class.

```css
@utility text-lead {
  /* re-use built-in tailwindcss classes */
  @apply text-lg text-primary;
  /* define plain css */
  line-height: 1.5;
}

/* use .text-lead to apply style */
```
---
# Define global custom style within `@layer base` | File: rules/style-define-custom-global-css.md

Guide correct way to make style application with Tailwindcss and it's classes.

sveltekit, svelte5, tailwindcss, styling

## Define global custom style within `@layer base`

When need to define global custom style, following instruction of tailwindcss version 4 that only use css to define global custom style.

```css
@layer base {
  /* define global custom style */
  .text-lead {
    @apply text-lg text-primary;
    line-height: 1.5;
  }
}
```
---
# Common Tailwindcss Usage | File: rules/style-common-tailwindcss-usage.md

Common tailwindcss usage that must follow tailwind version 4.

sveltekit, svelte5, tailwindcss, styling

## All tailwindcss configuration must following tailwind version 4

When need to change default tailwindcss configuration, following instruction of tailwind version 4 that only use css to define configuration.

## Set cursor pointer to button by default

If project implemented shadcn library, add style default cursor-pointer to button in css file if it not added yet:

```css
@layer base {
  /* force cursor pointer on buttons */
  button:not(:disabled),
  [role="button"]:not(:disabled) {
    cursor: pointer;
  }
}
```

## Prefer use tailwindcss classes to present custom UI

## use arbitraty values to present custom UI

- When need add custom css style, use class customize strategy from tailwindcss, avoid use inline css style.
- Reference: https://tailwindcss.com/docs/styling-with-utility-classes#using-arbitrary-values
- Reference: https://tailwindcss.com/docs/adding-custom-styles#arbitrary-properties
- Reference: https://tailwindcss.com/docs/adding-custom-styles#arbitrary-variants
---
# use svelte snippet with shadcn component | File: rules/shadcn-use-snippet.md

Use svelte snippet (svelte 5 feature) with shadcn component to avoid duplicate code.

sveltekit, shadcn, snippet

Use svelte snippet (svelte 5 feature) with shadcn component to avoid duplicate code. Make sure you installed shadcn svelte version support Svelte 5.

**Example:**

```svelte
<script lang="ts">
 import * as DropdownMenu from "$lib/components/ui/dropdown-menu/index.js";
 import { Button } from "$lib/components/ui/button/index.js";
</script>
 
<DropdownMenu.Root>
 <DropdownMenu.Trigger>
  {#snippet child({ props })}
   <Button {...props} variant="outline">Open</Button>
  {/snippet}
 </DropdownMenu.Trigger>
```
---
# Unchange shadcn components code | File: rules/shadcn-untouch-components.md

Never change shadcn components code, keep them origin as it is to support update/overwrite when shadcn release new version.

sveltekit, shadcn, components

## Avoid change code of shadcn components

When shadcn component installed to project, never change their code, keep them origin as it is to support update/overwrite when shadcn release new version.
---
# Consistent Shadcn Style Guide | File: rules/shadcn-style-consistent.md

Keep shadcn's style consistent with project's style guide.

sveltekit, shadcn, style

After install Shadcn svelte to project, it shipped with default style defined in `/src/routes/layout.css`. Depend on project requirement, you can override the style include:

- Update shadcn color config inside `layout.css`, respect color value scheme (default is oklch()).
- respect color scheme format: oklch() with 3 values: lightness, chroma, hue. Values separate by space.
- Understand and update color correct with the scope that color variable used in scadcn components.
ex:
    `--foreground` applied to text color default, button variant default etc.

## always customize shadcn style or add new css variable in separate `:root` and `.dark` block:

**Example:**

```css
:root {
    /* default shadcn style */
    --foreground: oklch(0.145 0 0);
}

.dark {
    --foreground: oklch(0.985 0 0);
}

/* customize color */
:root {
  --foreground: oklch(0.145 1 1);
}

.dark {
    --foreground: oklch(0.985 1 1);
}
---
# Setup tools | File: rules/setup-tools.md

Review and suggest setup tools for project development.

setup, tools

## Node.js

- Developer machine must install Node.js version 20 or higher.
- use `node -v` to check Node.js version.
- If current version < 20 then show message suggest install Node.js version 20 or higher.
- Reference: https://nodejs.org/en/download

## PNPM

- Developer machine must install PNPM package manager.
- PNPM version must be 10 or higher.
- use `pnpm -v` to check PNPM version.
- If PNPM is not installed then show message suggest install PNPM.
- If PNPM version < 10 then show message suggest upgrade PNPM to version 10 or higher.
- Reference: https://pnpm.io/installation
- Using `pnpm` for all commands related to package management. If command mention about `npm`, `yarn`.. then replace with `pnpm`.

## MoonRepo

- When application required setup following mono-repo structure, developer must install MoonRepo package manager.
- Reference: https://moonrepo.dev/docs/install
- Choose install MoonRepo via `pnpm`: https://moonrepo.dev/docs/install#npm
---
# Set up SvelteKit Framework for New Project | File: rules/setup-sveltekit.md

Step by step set up SvelteKit framework to a folder as base for new project.

sveltekit, framework, setup, infrastructure

## Use common, extractly command to install SvelteKit.

- Install SvelteKit direct to current folder, use extractly command: `pnpx sv create .`.
- Sveltekit should installed to current folder, not create new sub-folder for project.
- Dont append more arguments to command, keep use correct command: `pnpx sv create .`.
---
# Setup packages base | File: rules/setup-packages-base.md

Review and suggest setup packages base for project development.

setup, packages

## Install packages via `pnpm`.

always try install project packages via `pnpm`.

- Install SvelteKit packages via `pnpm`. Use command: `pnpm install`.
- When terminal prompt approve build, suggest developer run `pnpm approve-build`.

## Create environment file

- Create file `.env.local` at root folder of project. Define pair key=value below:
- Reference: https://svelte.dev/docs/kit/creating-a-project

```bash
NODE_ENV=local
```

## Create pnpm workspace file

- Create file `pnpm-workspace.yaml` at root folder of project. Define content below:

```yaml
packages:
  - "."
```

## Tailwindcss

- Reference: https://tailwindcss.com/docs/installation/framework-guides/sveltekit
- Validate current project, if `package.json` has tailwincss package then skip, if not then install tailwindcss following official documentation.
- Make sure tailwindcss version must 4 or higher.
- Avoid use tailwind config file, since tailwindcss version 4 use single css file as config and definition.
- Main css file should be `src/routes/layout.css` include tailwindcss default config and custom styles in future.
- No use postcss config file, since tailwindcss version 4 use single css file as config and definition.

## Shadcn Svelte

- Reference: https://www.shadcn-svelte.com/docs/installation/sveltekit
- Use command: `pnpm dlx shadcn-svelte@latest init` to initialize shadcn-svelte in current project.
- Follow the guide to install shadcn-svelte packages.
- Pre-install default packages used almost of time. Each component installed need following individual official documentation page:
  - `Alert Dialog`: https://www.shadcn-svelte.com/docs/components/alert-dialog1
  - `Alert`: https://www.shadcn-svelte.com/docs/components/alert
  - `Button`: https://www.shadcn-svelte.com/docs/components/button
  - `Card`: https://www.shadcn-svelte.com/docs/components/card
  - `Sonner`: https://www.shadcn-svelte.com/docs/components/sonner
- If component's documentation mention extra setup steps, follow the steps to setup component in current project.

## tiny-invariant

- Reference: https://www.npmjs.com/package/tiny-invariant
- Install tiny-invariant package via `pnpm`. Use command: `pnpm add -D tiny-invariant`.
---
# Validate truly value | File: rules/code-predict-truly.md

Guide to validate a value predict truly in code.

typescript, exception, error, validate, tiny-invariant, truly

## use tiny-invariant for check and throw exception/Error

- Use tiny-invariant whenever checking value predict truly that no care about catch the exception.
- Avoid check with `if` statement and throw Error manually.

**Incorrect:**

```typescript
function divide(a: number, b: number): number {
  if (b === 0) {
    throw new Error("Divisor must not be zero");
  }
  return a / b;
}
```

**Correct:**

```typescript
import { invariant } from "tiny-invariant";

function divide(a: number, b: number): number {
  invariant(b !== 0, "Divisor must not be zero");
  return a / b;
}
```

## Reference:

- https://www.npmjs.com/package/tiny-invariant
