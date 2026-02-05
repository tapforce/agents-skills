add new skill `tapforce-sveltekit-v2-svelte-v5`

use when project mentions use sveltekit, create new project.

content include:

reference to llms txt:
https://svelte.dev/docs/kit/llms.txt

1. check project if sveltekit installed.

- if installed, make sure version is >= 2 and svelte version is >= 5
- if not installed, create new project to curent folder.

1.2. version is not match, update to latest version

1.3. install sveltekit

read and understand document: https://svelte.dev/docs/kit/creating-a-project.


Bias rules:

- sveltekit must installed to current folder, suggest use command:

```bash
npx sveltekit@latest create .
```

- while install, CLI can asking choose optional packages want to installed along with sveltekit. Let's user choose. Optional packages can be `tailwindcss`, `adapter-vercel` etc.

- Strong mention always write svelte codes with features svelte version >= 5 like `$state`, `$effect` etc. Or with props `let {...} = $props()`, or `{@render children()}` etc. 

- Strong mention inside component, when need define props use destructuring, always include type of property with real type, not `any` or `unknown` .

- Strong mention when write svelte code html tag with long `class` asstribute (`class="..."`), break the long class string to multi strings width not over 100 characters per line, wrap multi strings with array, replace to `class={[...]}`. Add explaintation that `svelte 5` support class array by core.

- Strong mention always use class-array style whenever having classes can be switch or toggle by condition.  Take example for this case


