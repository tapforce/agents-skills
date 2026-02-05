refresh test skill `tapforce-nodejs-pnpm-v10`
Summary after test:
- did you create file `pnpm-workspace.yaml` in project root?
- did you insert default yaml content?
- did you added `pnpm-workspace.yaml` before run any pnpm command?

fresh test skill `tapforce-shadcn-svelte`, use skills below as as your skills:
- `tapforce-nodejs-pnpm-v10`
- `tapforce-sveltekit-v2-svelte-v5`
- `tapforce-tailwindcss-v4`

---


correct skill `tapforce-nodejs-pnpm-v10`
Review content and re-sorting content to avoid duplicate sections. Make it clear for you to understand and execute but still keep consistency and abstract.


corect skill `tapforce-sveltekit-v2-svelte-v5`

add strong suggest use `pnpm` if project and env support `pnpm`, respect `pnpm` skills if available.

Read and understand how to create new project from: https://svelte.dev/docs/kit/creating-a-project. Strong mention modify command to make sure we need new project at current directory rather than create sub directory.


correct skill `tapforce-tailwindcss-v4`

Fix sections:

### Installation Commands

this section should lower priority and only used when can not detect specific framework of project.


correct skill `tapforce-nodejs-pnpm-v10`

Add a rule counter issue:

```ERR_PNPM_INVALID_WORKSPACE_CONFIGURATION packages field missing or empty```

when meet this issue and project considered to use `pnpm` as main package manager, you must add `pnpm-workspace.yaml` and content following the skill explained instead of adding any other common fixes you found. Avoid try custom fix like adding `"workspaces": ["."]` to `package.json`.