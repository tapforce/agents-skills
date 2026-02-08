add skill `tapforce-tailwindcss`

Skill give best practices for set up and develop UXUI for project use tailwindcss ^4.

Use this skill whenever setup new project that tailwindcss support, or whenever project installed tailwindcss.

## requirements

- project use tailwindcss ^4 or need start with tailwindcss.
- project must be kind of supported by tailwindcss. You need read and understand and explain correctly from official document: https://tailwindcss.com/docs/installation/using-vite
  - vite: https://tailwindcss.com/docs/installation/using-vite
  - using postcss: https://tailwindcss.com/docs/installation/using-postcss
  - using tailwindcss: https://tailwindcss.com/docs/installation/tailwind-cli
  - frameworks: you need read and collect from: https://tailwindcss.com/docs/installation/framework-guides
  - play CDN: https://tailwindcss.com/docs/installation/play-cdn

## checking project

If project installed tailwindcss, check and make sure version is ^4. If not match version then refuse to continue.

If project not installed tailwindcss, install tailwindcss ^4 base on project type, see in requirements.

you needd explain step to install tailwindcss ^4 base on project type use resource from links, if setup steps is long then consider detach to `references` file and set relative link to `SKILL.md`.

### what project setup prefered?

For best practices, you prefer project should:

- use Nodejs as base
- use `pnpm` as package manager
- use any of popular js framework: `svelte kit`, `nextjs`, `nuxtjs`, etc. if user not decided framework when setup project, you always prefer `svelte kit` as default.


## talwindcss 4 compatibility

Tailwindcss ^4 has some breaking changes compare to ^3. You need read and understand about Tailwindcss ^4 compatibility. You need read and write skill from official document: https://tailwindcss.com/docs/compatibility.

## core concept

With each core concept you need read the official document and write SKILL.md for helpful guide AI.

- [styling with utility classes](https://tailwindcss.com/docs/styling-with-utility-classes)
- [Hover, focus, and other states](https://tailwindcss.com/docs/hover-focus-and-other-states)
- [Responsive design](https://tailwindcss.com/docs/responsive-design)
- [Dark mode](https://tailwindcss.com/docs/dark-mode)
- [theme](https://tailwindcss.com/docs/theme)
- [colors](https://tailwindcss.com/docs/colors)
- [Adding custom styles](https://tailwindcss.com/docs/adding-custom-styles)
- [Detecting classes in source files](https://tailwindcss.com/docs/detecting-classes-in-source-files)
- [Functions and directives](https://tailwindcss.com/docs/functions-and-directives)

## Rules / best practices

### use tailwindcss ^4 features with classes whenever possible

You need always prefer write style UI use tailwindcss ^4 classes instead of write custom css. Give some examples to explain.

### use arbitary value when need write custom UI that not support by built-in tailwindcss

When UI need customize that tailwindcss's built-in classes not enough to support, you need use arbitary value to write custom style. Give some examples to explain. https://tailwindcss.com/docs/theme#with-arbitrary-values

### centerize css file 

Each js framework define root css file by default, this is where you import tailwindcss (see again install document). You need make sure any customize css variable (if have) is defined on this file rather than define inline in components or pages. 

Documents to read and make samples: 
- [customize default theme](https://tailwindcss.com/docs/theme#extending-the-default-theme)
- [override default theme](https://tailwindcss.com/docs/theme#overriding-the-default-theme)
- [referencing custom css class](https://tailwindcss.com/docs/theme#referencing-other-variables)

### use utility-directive to define new custom css classes

When need define new custom css classes for style that will be shared multi places in project. Always prefer define it use utility-directive (`@utility`). Read and make sample from: https://tailwindcss.com/docs/functions-and-directives#utility-directive.

### Using `@apply` within Svelte `<style>` blocks

If you need to use the `@apply` directive within a scoped `<style>` block in a Svelte component, you can use the `@reference` directive to access the Tailwind configuration and utilities without duplicating the CSS output

```svelte
<!-- src/lib/ComponentWithApply.svelte -->
<style lang="postcss">
  @reference "../app.css"; /* Reference your main CSS file */
  .my-custom-button {
    @apply bg-green-500 hover:bg-green-600 text-white font-bold py-2 px-4 rounded;
  }
</style>

<button class="my-custom-button">
  Button with @apply
</button>
```

### consistency color value format 

By default, tailwindcss ^4 use color value format `hsl()`. but in project if use `shadnc-svelte` it can be `oklch()`. Always lookup correct main color value format in main css file and use same format for all color value.

Read this document and make sample about shadcn-svelte color value format: https://www.shadcn-svelte.com/docs/theming.
