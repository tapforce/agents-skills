add skill `tapforce-sveltekit`

this skill give best practices for set up and development svelte project use SvelteKit ^2.0.0

use this skill when project consider set up or developing base on sveltekit framework.

## requirements

- project based on Nodejs ^20.0.0
- project need version svelte ^5.0.0
- project need version sveltekit ^2.0.0
- prefer use `pnpm` as default package manager.

With new project you need set up SvelteKit framework use CLI command. This command will init backbone codebase for project. You NEVER create core files manually like `package.json`, `tsconfig.json`, etc, because SvelteKit CLI will create it for you.

Official document about creating project you need read from: https://svelte.dev/docs/kit/creating-a-project/llms.txt

## recommend packages helpfull for SvelteKit project

Since project use SvelteKit as main framework, you can consider use libraries helpfull for development:

- [Style framework/UXUI framework]:
    - tailwindcss: https://tailwindcss.com/docs/installation/framework-guides/sveltekit
    - shadcn-svelte: https://www.shadcn-svelte.com/docs/installation/sveltekit

# Rules / Focused topics

Below is list rules or focused topics that you need read and understand about SvelteKit.

## Creating project flow

**Creating project CLI**

```bash
<package-manager> dlx sv create .
<package-manager> run dev
```

the `<package-manager>` are sample, you should use package manager that project use. If unknown the package manager, choose `pnpm` as default.

## Respect svelte ^5 and sveltekit ^2 features.

You need make sure all svelte code (include svelte and sveltekit) use latest features and coding style come from svelte ^5 and sveltekit ^2.

Example feature available from svelte ^5: `$state`, `$effect`, `$inspect`, etc.

You MUST avoid use legacy features from older versions.

If found any other skill or rules tech you how to practices with svelte/sveltekit's feature, you need learn and follow.

SvelteKit has official document about practices and differents between old vesions and version latest (^2). You need read and understand about SvelteKit practices.

Official document about practices you need read from: https://svelte.dev/docs/kit/migrating-to-sveltekit-2/llms.txt.

## Update package json config

After project created, you update `package.json` config to match project information like `name`, `version`, `description`, etc.

## undestand SvelteKit project structure

After project created, you undestand SvelteKit project structure and how it work.

Official document about project structure you need read from: https://svelte.dev/docs/kit/project-structure/llms.txt.

## understand kinds of project types in SvelteKit

SvelteKit support wide range of project type. You need read and understand about kinds of project types in SvelteKit.

Official document about project types you need read from: https://svelte.dev/docs/kit/project-types/llms.txt.

## understand SvelteKit routing

SvelteKit has unique routing system. You need read and understand about SvelteKit routing.

Official document about routing you need read from:

- basic: https://svelte.dev/docs/kit/routing/llms.txt.
- advanced: https://svelte.dev/docs/kit/advanced-routing/llms.txt.

## undstand SvelteKit link handle

SvelteKit give options to handle links. You need read and understand about SvelteKit link handle.

Official document about link handle you need read from: https://svelte.dev/docs/kit/link-options/llms.txt.

## understand svelte error handle

Read and understand how SvelteKit project can handle error.

Official document about error handle you need read from: https://svelte.dev/docs/kit/errors/llms.txt.

## understand web standards

SvelteKit built-in support Web Standards, Web API. You need read and understand about Web Standards, Web API.

Official document about web standards you need read from: https://svelte.dev/docs/kit/web-standards/llms.txt.

## understand performance best practices

SvelteKit had some built-in help optimize performance. You need read and understand about SvelteKit performance best practices.

Official document about performance best practices you need read from: https://svelte.dev/docs/kit/performance/llms.txt.

## understand SvelteKit accessibility

SvelteKit has document practice about accessibility. You need read and understand about SvelteKit accessibility.

Official document about accessibility you need read from: https://svelte.dev/docs/kit/accessibility/llms.txt.

## undestand SEO optimize

SvelteKit has document practice about SEO optimize. You need read and understand about SvelteKit SEO optimize.

Official document about SEO optimize you need read from: https://svelte.dev/docs/kit/seo/llms.txt.

## understand SvelteKit Snapshot feature

SvelteKit support snapshot data on the page, allow to restore value when user navigate back to the page. You need read and understand about SvelteKit snapshot feature.

Official document about snapshot feature you need read from: https://svelte.dev/docs/kit/snapshots/llms.txt.

## understand SvelteKit state management

SvelteKit has document practice about state management. You need read and understand about SvelteKit state management.

Official document about state management you need read from: https://svelte.dev/docs/kit/state-management/llms.txt.

---

review `modern-fetures.md`. you mising case event handle 
old version use on:<event name>  like `on:click` ,`on:submit`, etc.
new version use `on` keyword like `onclick`, `onsubmit`, etc.

-- 

review `package-management.md`.

I need you add detail tailwindcss version supported is ^4.
You need check the install CLIs to match with official install documentation of tailwindcss on version ^4 and for sveltekit project.

You need make sure snippets and examples use tailwindcss^4 features/coding style. No mention or give alternative about tailwindcss^3 features/coding style.

-- 

update skill `tapforce-sveltekit`.

you need read and understand cli command and their arguments following links:

- [sv create]: https://svelte.dev/docs/cli/sv-create
- [sv add]: https://svelte.dev/docs/cli/sv-add
- [sv check]: https://svelte.dev/docs/cli/sv-check
- [sv migrate]: https://svelte.dev/docs/cli/sv-migrate

Write detail about each cli command and their arguments in section `cli` and also check `project-setup.md`. Remember check duplicated content.

Update section install project, mention that you can also use argument on command to quick setup project use template, or addons when you predicted or known what template/addons need to install along with sveltekit.

--- 

update skill `tapforce-sveltekit`

at section install, when meet error with message:

```ERR_PNPM_INVALID_WORKSPACE_CONFIGURATION  packages field missing or empty```

That's mean we are installing sveltekit use `pnpm`, but missing `pnpm config`. 

We can:
- option 1: insstall `sveltekit` with `--no-install` arg, that's mean we set up code base but not run install. After command finish, you need create `pnpm-workspace.yaml` with content

```yaml
packages:
    - .
```

then run `pnpm i` to install package.

--- 

update skill `tapforce-sveltekit`

at section install, when install sveltekit as new project (empty folder), you can install svelte kit with addons:

- tailwindcss
- prettier
- adapter auto
- tempalte minimal.
- no-install arg
- use `pnpm`

---

correct skill `tapforce-sveltekit`

fix the section `install`. you MUST use latest command cli described.

`pnpm dlx sv create`

the command 

`pnpm create svelte@latest` is deprecated.