add skill `tapforce-shadcn-svelte-blocks`

this skill is guideline to develope UXUI for SvelteKit project that using shadcn-svelte library, use samples from shadcn-svelte block gallery.

Use this skill when user ask to build UI for their project that using svelte ^5, sveltekit ^2, and implemented shadcn-svelte.

You need read and understand content include blocks represented in https://www.shadcn-svelte.com/blocks.

You need list blocks include name, description and link with bookmark to their section.
The link with bookmark has format `https://www.shadcn-svelte.com/blocks#<name of block>`
Ex: `https://www.shadcn-svelte.com/blocks#sidebar-03`

With each section of block, you can found the command to install block into project. It has format like:
`pnpm dlx shadcn-svelte@<shadcn version> add <name of block>`. You need to write command to skill and close to individual block metadata listed above.

You need mention project should use package manager that project owner use, in case unknown prefer package manager, strong recommend the `pnpm`. In all case, MUST respect skills related to package manager to process commands if skill used.

Your job is implement (install) blocks if matched user request to project and develop UI based on block samples. 

- You MUST respect shadcn-svelte style defined in project. 
- You MUST respect shadcn-svelte version defined in project.


## Bias RULEs

### Move page of block created when install block to correct place of code.

When install a block, block can be created sample page in `src/routes` that not match to project structure. You need review there pages, move it to correct to place of code that you are doing. In case target page is exists, you need replace content of target page with the page of block.

Ex: install block `login-05` will create page `src/routes/login-05/+page.svelte` that not match to project structure. You need move file `+page.svelte` to `src/routes/login/+page.svelte` assume user request that route. If `/src/routes/login/+page.svelte` is exists, you need replace content of `+page.svelte` with content of `login-05` block. Remove the sample page after move it to correct place.

### consistency style of block

Each block can have different layout style include (layout spacing, font size, etc). You need respect style of block within the page of block. When create new custom component that used only in the page has block code, you need respect style of block.