# Client-Side Form Validation with sveltekit-superforms

## Overview
Implement client-side form validation using sveltekit-superforms, zod 4, and shadcn UI Form components.

## Reference Links
- [Zod Basics](https://zod.dev/basics) - Validation schema patterns
- [Superforms Client Validation](https://superforms.rocks/concepts/client-validation) - Form handling concepts  
- [Shadcn Form](https://www.shadcn-svelte.com/docs/components/form) - Component API

## Dependencies
```bash
pnpm add zod@^4.0.0 sveltekit-superforms@^2.0.0
```

## Shadcn Form Component (Required)
**CRITICAL**: Install Form component if using shadcn UI:
```bash
pnpm dlx shadcn-svelte@latest add form
```

## Implementation Pattern

### 1. Setup
```typescript
import z from 'zod';
import { zod4Client } from 'sveltekit-superforms/adapters';
import { superForm } from 'sveltekit-superforms';
import { FormField, FormControl, FormLabel, FormFieldErrors } from '$lib/components/ui/form';

const schema = z.object({
  username: z.string().email().min(1, 'Email is required'),
  password: z.string().min(1, 'Password is required')
});

const formValidator = zod4Client(schema);
const formDataInit = {
  username: '',
  password: ''
} as z.infer<typeof schema>;

const form = superForm(formDataInit, {
  validators: formValidator,
  SPA: true,
  onSubmit: async () => {
    const { valid, data } = await form.validateForm();
    if (!valid) return;
    // Handle submission
  }
});

// Option A: Destructuring (recommended)
const { form: formData, submitting, enhance } = form;
// Option B: Full object
// const form = superForm(formDataInit, { ... });
```

### 2. Template Usage

#### Destructuring Pattern
```svelte
<form use:enhance>
  <FormField {form} name="username">
    <FormControl>
      {#snippet children({ props })}
        <FormLabel>Email</FormLabel>
        <Input {...props} type="email" placeholder="m@example.com" bind:value={$formData.username} disabled={$submitting} />
      {/snippet}
    </FormControl>
    <FormFieldErrors />
  </FormField>
  <FormField {form} name="password">
    <FormControl>
      {#snippet children({ props })}
        <FormLabel>Password</FormLabel>
        <Input {...props} type="password" bind:value={$formData.password} disabled={$submitting} />
      {/snippet}
    </FormControl>
    <FormFieldErrors />
  </FormField>
  <Button type="submit" disabled={$submitting}>
    {#if $submitting}
      Loading...
    {:else}
      Login
    {/if}
  </Button>
</form>
```

#### Full Object Pattern
```svelte
<form use:enhance use:form.form>
  <FormField {form} name="username">
    <FormControl>
      {#snippet children({ props })}
        <FormLabel>Email</FormLabel>
        <Input {...props} type="email" placeholder="m@example.com" bind:value={$form.username} disabled={$submitting} />
      {/snippet}
    </FormControl>
    <FormFieldErrors />
  </FormField>
  <FormField {form} name="password">
    <FormControl>
      {#snippet children({ props })}
        <FormLabel>Password</FormLabel>
        <Input {...props} type="password" bind:value={$form.password} disabled={$submitting} />
      {/snippet}
    </FormControl>
    <FormFieldErrors />
  </FormField>
  <Button type="submit" disabled={$submitting}>
    {#if $submitting}
      Loading...
    {:else}
      Login
    {/if}
  </Button>
</form>
```

## Key Requirements
- Use `zod4Client` for zod 4 compatibility
- Set `SPA: true` for client-side validation
- Use destructuring imports for Form components
- Add `FormFieldErrors` for validation display
- **Binding patterns**: Use `$formData.username` (destructuring) or `$form.username` (full object)
- **Disable inputs during submission**: Add `disabled={$submitting}` to all Input components
- Use `use:enhance` (destructuring) or `use:enhance use:form.form` (full object)
