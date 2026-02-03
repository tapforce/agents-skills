---
name: login-04
description: Login block template with muted background and wide form layout.
tags: 
    - login
    - template
    - shadcn
    - svelte
    - tapforce
    - wide-layout
---

Main information of block found at https://www.shadcn-svelte.com/blocks#login-04.

## Implementation Guide

### Installation
```bash
pnpm dlx shadcn-svelte@latest add login-04
```

### Layout Characteristics

The login-04 block features a wide form layout:
- **Muted background** with centered content
- **Wide form container** that expands on larger screens
- **Responsive width**: `max-w-sm` on mobile, `md:max-w-3xl` on larger screens
- **Clean, minimal design** with focus on content area

### Default Behavior
- Muted background color (`bg-muted`)
- Centered layout with proper spacing
- Wide form that adapts to screen size
- Minimal styling approach

### Customization Logic

#### Background Styling
1. **Default**: Keep muted background (`bg-muted`)
2. **If user wants different background**: Replace with `bg-background`, `bg-primary`, etc.
3. **If user wants gradient**: Apply gradient classes to the background
4. **If user wants image**: Add background image with proper overlay

#### Form Width
1. **Default**: Use responsive width (`max-w-sm md:max-w-3xl`)
2. **If user wants fixed width**: Use single max-width class like `max-w-md`
3. **If user wants full width**: Remove max-width constraints
4. **If user wants custom breakpoints**: Adjust the responsive width classes

#### Layout Modifications
1. **Default**: Keep centered layout
2. **If user wants left-aligned**: Change `items-center` to `items-start`
3. **If user wants different spacing**: Modify gap and padding classes
4. **If user wants sidebar**: Consider using login-02 instead

### Implementation Steps

1. Install the block using the command above
2. Move the generated files to the correct location if needed (e.g., from `/login-04/` to `/login/`)
3. Review the generated component structure:
   - `routes/login-04/+page.svelte` - Main page component
   - `lib/components/login-form.svelte` - Form component
4. Customize background styling based on user preferences
5. Adjust form width and layout if needed
6. Test responsive behavior and ensure proper spacing

### Detection Patterns

Look for these elements in the generated components:
- Main container with `bg-muted flex min-h-svh flex-col items-center justify-center p-6 md:p-10` classes
- Form container with `w-full max-w-sm md:max-w-3xl` classes
- LoginForm component import and usage
- Responsive width patterns
- Centered layout structure
