create skill `tapforce-shadcn-svelte`

Skill provide best practices for setup and use `shadcn-svelte` library to develop UXUI in svelte project.

Use this skill when project is using svelte/sveltekit framework as main app framework, when user attemp to setup new project or when user is developing on existing project using shadcn-svelte components.

## requirements

- project must based on sveltekit framework version 2.0 or higher
- project must use svelte 5.0 or higher
- recommend project should use tailwindcss.

## resource

- [Official documentation]: https://www.shadcn-svelte.com/llms.txt
- [Components documentation]: https://www.shadcn-svelte.com/docs/components

## component documentation

You read document name and link from this page then write into a list with format `- [name](link)`: https://www.shadcn-svelte.com/docs/components.

## check project

You must check project to know `shadcn-svelte` is already installed or not. To checking, find file `components.json` in project root directory.

## install

Read and understand documentation at https://www.shadcn-svelte.com/docs/installation/sveltekit, write into skill documentation.

You need attention:

- Project require sveltekit ^2 and tailwindcss ^4 ready before init shadcn-svelte.
- command: `pnpm dlx shadcn-svelte@latest init` use `@latest` indicate install latest version. For adding document by command, you need get real version from `package.json` and use it in command.

## cli

Read and understand documentation at https://www.shadcn-svelte.com/docs/cli, write into skill documentation.

## theming:

Read and understand documentation at https://www.shadcn-svelte.com/docs/theming, write into skill documentation.

## darkmode:

Read and understand documentation at https://www.shadcn-svelte.com/docs/dark-mode/svelte, write into skill documentation.

## rules / bias topics:

### Maintaince shadcn components

In order to keep project and shadcn can update in future, you should not modify shadcn components after add to project. If you need to modify shadcn components, you should create a new component and use it instead of shadcn component.

### Take advantage component options

Always try to take advantage options when use a component, like button component can have `variant`, `size`, `class` options.

---

correct skill

in examples import component, you are using:

```typescript
import { Button } from "$lib/components/ui/button/index.js";
```

you need update to import with folder path:

```typescript
import { Button } from "$lib/components/ui/button";
```

Like this you can support both case:

- import a component with same name: `import { Button } from "$lib/components/ui/button";`

Write this into a rule for skill documentation.

-- 

correct skill, rule `component-imports.md`

You should prefer use destructuring import components with `import {<components>} from <shadcn component path`.

When example show import all (use `* as <component>`), you should update to use destructuring import.

**origin**

```svelte
<script lang="ts">
  import * as Card from "$lib/components/ui/card/index.js";
</script>

<Card.Root>
  <Card.Content>Content</Card.Content>
</Card.Root>
```

**correct**

```svelte
<script lang="ts">
  import { Card, CardContent } from "$lib/components/ui/card";
</script>

<Card>
  <CardContent>Content</CardContent>
</Card>
```

---

correct the skill

Add new rule: when you install, init libray, or add shadcn component, you never try to manually creating config file when meeting error. You must respect install, init, adding component via CLI commands.