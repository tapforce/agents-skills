---
name: login-05
description: Login block template with clean background and standard form width.
tags: 
    - login
    - template
    - shadcn
    - svelte
    - tapforce
    - clean-layout
---

Main information of block found at https://www.shadcn-svelte.com/blocks#login-05.

## Implementation Guide

### Installation
```bash
pnpm dlx shadcn-svelte@latest add login-05
```

### Layout Characteristics

The login-05 block features a clean, standard layout:
- **Clean background** using default background color
- **Standard form width** with `max-w-sm`
- **Centered layout** with proper spacing and gaps
- **Minimal design** focusing on the login form

### Default Behavior
- Default background color (`bg-background`)
- Fixed width form container (`max-w-sm`)
- Centered with gap spacing (`gap-6`)
- Responsive padding (`p-6 md:p-10`)

### Customization Logic

#### Background Styling
1. **Default**: Keep default background (`bg-background`)
2. **If user wants muted background**: Change to `bg-muted`
3. **If user wants colored background**: Use `bg-primary`, `bg-secondary`, etc.
4. **If user wants gradient**: Apply gradient classes to the background

#### Form Width
1. **Default**: Keep standard width (`max-w-sm`)
2. **If user wants wider form**: Change to `max-w-md` or `max-w-lg`
3. **If user wants responsive width**: Add responsive classes like `md:max-w-md`
4. **If user wants full width**: Remove max-width constraint

#### Spacing and Layout
1. **Default**: Keep gap-6 between elements
2. **If user wants more spacing**: Increase to `gap-8` or `gap-10`
3. **If user wants less spacing**: Reduce to `gap-4` or `gap-2`
4. **If user wants no gaps**: Remove gap classes

### Implementation Steps

1. Install the block using the command above
2. Move the generated files to the correct location if needed (e.g., from `/login-05/` to `/login/`)
3. Review the generated component structure:
   - `routes/login-05/+page.svelte` - Main page component
   - `lib/components/login-form.svelte` - Form component
4. Customize background styling based on user preferences
5. Adjust form width and spacing if needed
6. Test the final implementation for proper centering and responsiveness

### Detection Patterns

Look for these elements in the generated components:
- Main container with `bg-background flex min-h-svh flex-col items-center justify-center gap-6 p-6 md:p-10` classes
- Form container with `w-full max-w-sm` classes
- LoginForm component import and usage
- Standard spacing patterns with gap-6
- Clean, minimal layout structure
