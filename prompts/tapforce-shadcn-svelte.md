add skill `tapforce-shadcn-svelte`

This skill is guide for user to set up or implement shadcn-svelte as main UXUI library for SvelteKit project.

Use this skill when user want, project is using SvelteKit and suite to use shadcn-svelte as main UXUI library. If user not specify mention, always suggest use shadcn-svelte as main UXUI library.

## understand the shadnc-ui

You need read and understand what is shadcn-svelte from: https://www.shadcn-svelte.com/docs.

You also need reference LLMS.txt to have full library content: https://www.shadcn-svelte.com/llms.txt.

## requirements

- Project must use sveltekit with svelte 5 at least.
- Project must ready tailwindcss version 4. The installation depend on project owner. It can installed at the time set up svelte kit project, install separatly or installed along with set up shadcn-svelte.
- Project must not implement shadcn-svelte before. See checking section for more details.

## checking

To set up shadcn-svelte, first need check if current project implemented shadcn-svelte before or not. Checking by scanning file `components.json` and `package.json`.

If project implemented package before then skip setup, just guide user to use shadcn-svelte.

If project not implemented package before then continue setup.

## setup

Read and understand the setup guide: https://www.shadcn-svelte.com/docs/installation/sveltekit. Attention:
- you need to use package manager that project owner used before.
- you need skip packages mentioned in document but really installed in project to avoid duplicate setup.

## frozen shadcn version

After install with `latest` version, you need freeze the version by write version number in `package.json` file. Create new `scripts` in`package.json` file with correct version referenced in dependency to for future use.

```json
{
    "scripts": {
        "shadcn-svelte": "pnpm dlx shadcn-svelte@<version>"
    },
    "dependencies": {
        "shadcn-svelte": "<version>"
    }
}
```

You will use this `scripts` to install new component in future.

## reference

- [CLI command](https://www.shadcn-svelte.com/docs/cli)

You need read and understand commands in CLI reference and use it, but flexible package manager alias to match with project owner.

## Bias rules:

### Respect shadcn's components as possible

always reference on https://www.shadcn-svelte.com/docs/components to find matched components can be used for user request. Don't try create custom component too early.

### Custom style (color, spacing, etc) must respect tailwindcss skills/rules and shadcn-svelte documentation

You need respect tailwindcss rules and then shadcn-svelte documentation when need custom css style (color, spacing, etc).

Shadcn-svelte style guideline can be read here: https://www.shadcn-svelte.com/docs/theming.

### respect svelte 5 features, tailwind version 4 features.

Everytime you need customize style, create new custom component from shadcn component, or use shadcn component in page/layout of project, you need always respect svelte 5 features, tailwind version 4 features. Must Avoid mimix svelte old version style or old tailwind version style.

### Aleays keep shadcn-svelte component original.

You Must avoid modify directly code of shadcn-svelte components. This is require to make sure next upgrade from shadcn-svelte can be safe to override whole components.

When the request need a component different built-in shadcn comment, you consider create new custom component, can be wrap the shadcn's component inside or simulate same depend on user request. Please new component in the folder project prefer.

Ex: need button component with custom style that shadcn's button not support, you can create new component in the folder project prefer.