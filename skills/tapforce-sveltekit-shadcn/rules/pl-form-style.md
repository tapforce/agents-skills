---
name: pl-form-style
description: Guide for proper form structure and styling with Form components
tags:
  - sveltekit
  - form
  - styling
  - structure
---

## Form Structure Guidelines

### FieldSet vs FormField Usage

**Use `<FieldSet>` for sections that do NOT contain form fields defined in zod schema:**
- Login buttons (Google, OAuth)
- Separator text
- Action buttons that don't correspond to schema fields
- Static content or decorative elements

```svelte
<form use:enhance class={['space-y-6']}>
  <FieldSet>
    <Button variant="outline" type="button">
      Login with Google
    </Button>
  </FieldSet>
  <FieldSeparator>Or continue with</FieldSeparator>
</form>
```

**Use `<FormField {form} name="[schema_key]">` for sections that contain form fields defined in zod schema:**
- Input fields (email, password, etc.)
- Form validation and error display
- Labels and descriptions tied to schema fields

```svelte
<FormField {form} name="username">
  <FormControl>
    {#snippet children({ props })}
      <FormLabel>Email</FormLabel>
      <Input {...props} type="email" bind:value={$formData.username} />
    {/snippet}
  </FormControl>
  <FormFieldErrors />
</FormField>
```

### Form Styling

**MUST add `space-y-6` to the `<form>` tag when using Form components:**
```svelte
<form use:enhance class={['space-y-6']}>
  <!-- Form content -->
</form>
```

**Benefits:**
- Consistent vertical spacing between form sections
- Proper visual hierarchy
- Follows shadcn UI design patterns

### Complete Example

```svelte
<form use:enhance class={['space-y-6']}>
  <!-- Non-schema section -->
  <FieldSet>
    <Button variant="outline" type="button">
      Login with Google
    </Button>
  </FieldSet>
  
  <FieldSeparator>Or continue with</FieldSeparator>
  
  <!-- Schema fields -->
  <FormField {form} name="username">
    <FormControl>
      {#snippet children({ props })}
        <FormLabel>Email</FormLabel>
        <Input {...props} type="email" bind:value={$formData.username} />
      {/snippet}
    </FormControl>
    <FormFieldErrors />
  </FormField>
  
  <FormField {form} name="password">
    <FormControl>
      {#snippet children({ props })}
        <FormLabel>Password</FormLabel>
        <Input {...props} type="password" bind:value={$formData.password} />
      {/snippet}
    </FormControl>
    <FormFieldErrors />
  </FormField>
  
  <!-- Submit button (non-schema) -->
  <Button type="submit" disabled={$submitting}>
    {#if $submitting}
      Loading...
    {:else}
      Login
    {/if}
  </Button>
</form>
```

### Key Points

- **FieldSet**: For non-schema content (buttons, separators, static elements)
- **FormField**: For schema-defined fields (inputs with validation)
- **space-y-6**: Required on `<form>` tag for proper spacing
- **Consistency**: Follow this pattern for all forms using Form components
