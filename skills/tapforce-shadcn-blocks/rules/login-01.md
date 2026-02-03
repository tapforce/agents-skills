---
name: login-01
description: Simple login block template with centered form layout.
tags: 
    - login
    - template
    - shadcn
    - svelte
    - tapforce
---

Main information of block found at https://www.shadcn-svelte.com/blocks#login-01.

## Implementation Guide

### Installation
```bash
pnpm dlx shadcn-svelte@latest add login-01
```

### Layout Characteristics

The login-01 block features a clean, centered layout:
- **Simple centered form** on full screen
- **Minimal design** with no additional UI elements
- **Responsive** with proper padding and centering

### Default Behavior
- Clean, centered login form
- Full screen height with proper centering
- Minimal styling with focus on the form itself

### Customization Logic

#### Layout Modifications
1. **Default**: Keep the simple centered layout
2. **If user wants background color**: Add background classes to the container
3. **If user wants sidebar layout**: Consider using login-02 or login-04 instead
4. **If user wants branding elements**: Add logo or brand name above the form

#### Form Modifications
1. **Default**: Use the standard login form component
2. **If user wants custom styling**: Modify the LoginForm component
3. **If user wants additional fields**: Extend the LoginForm component

### Implementation Steps

1. Install the block using the command above
2. Move the generated files to the correct location if needed (e.g., from `/login-01/` to `/login/`)
3. Review the generated component structure:
   - `routes/login-01/+page.svelte` - Main page component
   - `lib/components/login-form.svelte` - Form component
4. Apply any custom styling or layout modifications based on user preferences
5. Test the final implementation to ensure proper centering and responsiveness

### Detection Patterns

Look for these elements in the generated components:
- Main container with `flex h-screen w-full items-center justify-center px-4` classes
- LoginForm component import and usage
- Simple, clean layout structure
- Responsive design patterns
