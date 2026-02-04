---
name: pr-form-packages-setup
description: Check and setup sveltekit-superforms and zod packages for form handling
tags: [sveltekit, forms, packages, setup, validation, superforms, zod]
---

**CRITICAL**: Before implementing any form functionality in SvelteKit, ensure both `sveltekit-superforms` and `zod` packages are properly installed and configured.

## Rule: Verify Form Packages Before Implementation

**Always check these packages exist before creating forms:**

1. **Check dependencies**: Verify both packages are listed in project dependencies
2. **Install if missing**: Install missing packages using appropriate package manager
3. **Verify versions**: Use compatible versions for SvelteKit compatibility
4. **Check shadcn-svelte**: If project uses shadcn-svelte, ensure Field component is installed

## Correct Implementation Pattern

```typescript
// +page.server.ts
import { superValidate } from 'sveltekit-superforms/server';
import { z } from 'zod';
import type { Actions } from './$types';

// Define schema with zod
const schema = z.object({
  email: z.string().email(),
  password: z.string().min(8)
});

export const actions: Actions = {
  default: async ({ request }) => {
    const form = await superValidate(request, schema);
    
    if (!form.valid) {
      return { failure: { form } };
    }
    
    // Process valid form data
    return { success: { form } };
  }
};

export const load = async () => {
  return {
    form: await superValidate(schema)
  };
};
```

```svelte
<!-- +page.svelte -->
<script lang="ts">
  import { superForm } from 'sveltekit-superforms';
  import { zodClient } from 'sveltekit-superforms/adapters';
  import type { FormResult } from './$types';
  
  export let data: FormResult;
  
  const { form, enhance, errors, message, submitting } = superForm(data.form, {
    validators: zodClient(schema),
    resetForm: false,
    onResult: ({ result }) => {
      if (result.type === 'success') {
        // Handle success
      }
    }
  });
</script>

<form method="POST" use:enhance>
  <input type="email" bind:value={$form.email} />
  {#if $errors.email}<span class="error">{$errors.email}</span>{/if}
  
  <input type="password" bind:value={$form.password} />
  {#if $errors.password}<span class="error">{$errors.password}</span>{/if}
  
  <button type="submit" disabled={$submitting}>
    {$submitting ? 'Submitting...' : 'Submit'}
  </button>
</form>
```

## Package Version Requirements

**Required versions for form handling:**
- `sveltekit-superforms`: Latest compatible with SvelteKit version
- `zod`: >= 4.0.0 (required for latest features and TypeScript support)

**shadcn-svelte Integration:**
If project uses shadcn-svelte, install Field component for form consistency:
```bash
# Use shadcn CLI with project's version
shadcn-svelte@<version> add field
```

## Common Issues to Avoid

### Incorrect - Missing Packages
```typescript
// This will fail if packages aren't installed
import { superValidate } from 'sveltekit-superforms/server';
// Error: Cannot find module 'sveltekit-superforms'
```

### Incorrect - Version Mismatch
```json
{
  "dependencies": {
    "sveltekit-superforms": "^1.0.0",  // Too old for current SvelteKit
    "zod": "^3.0.0"  // Below required version 4
  }
}
```

### Correct - Proper Setup
```json
{
  "dependencies": {
    "sveltekit-superforms": "^2.29.1",
    "zod": "^4.3.6"
  }
}
```

## Verification Checklist

- [ ] Both packages exist in project dependencies
- [ ] zod version >= 4.0.0
- [ ] sveltekit-superforms compatible with SvelteKit version
- [ ] Imports work without errors
- [ ] If using shadcn-svelte, Field component is installed
- [ ] Basic form validation functions correctly
- [ ] Client and server-side validation works

## Important Notes

- **Always install both packages together** - they work as a pair
- **Check SvelteKit version compatibility** before installing
- **Use appropriate package manager** for consistent dependency management
- **Test basic validation** before implementing complex forms
- **Follow superforms documentation** for advanced patterns
- **Zod schemas should be defined once** and reused across client/server
- **Field component integration** provides consistent form styling with shadcn-svelte
