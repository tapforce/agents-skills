---
name: login-02
description: Login block template with two-column layout and branding.
tags: 
    - login
    - template
    - shadcn
    - svelte
    - tapforce
    - two-column
---

Main information of block found at https://www.shadcn-svelte.com/blocks#login-02.

## Implementation Guide

### Installation
```bash
pnpm dlx shadcn-svelte@latest add login-02
```

### Layout Characteristics

The login-02 block features a two-column layout:
- **Left column**: Login form with branding
- **Right column**: Background image (hidden on mobile)
- **Responsive**: Stacks on mobile, side-by-side on larger screens
- **Branding**: Includes company logo and name

### Default Behavior
- Two-column grid layout (`lg:grid-cols-2`)
- Company branding with logo and name
- Background image on the right side
- Responsive design for mobile devices

### Customization Logic

#### Branding Elements
1. **Default**: Keep "Acme Inc." branding with GalleryVerticalEndIcon
2. **If user wants custom branding**: Replace company name and logo
3. **If user says "no branding"**: Remove the branding section
4. **If user wants different icon**: Replace GalleryVerticalEndIcon with desired icon

#### Background Image
1. **Default**: Use placeholder image
2. **If user wants custom image**: Replace `/placeholder.svg` with actual image path
3. **If user says "no image"**: Replace with solid color background
4. **If user wants gradient**: Apply gradient classes instead of image

#### Layout Modifications
1. **Default**: Keep two-column layout
2. **If user wants single column**: Remove the image column and adjust grid
3. **If user wants different proportions**: Modify grid column classes

### Implementation Steps

1. Install the block using the command above
2. Move the generated files to the correct location if needed (e.g., from `/login-02/` to `/login/`)
3. Review the generated component structure:
   - `routes/login-02/+page.svelte` - Main page component
   - `lib/components/login-form.svelte` - Form component
4. Customize branding elements (company name, logo) if needed
5. Update background image or styling based on preferences
6. Test responsive behavior on different screen sizes

### Detection Patterns

Look for these elements in the generated components:
- Grid container with `grid min-h-svh lg:grid-cols-2` classes
- Branding section with company name and icon
- Background image section with `bg-muted relative hidden lg:block` classes
- LoginForm component in the left column
- Responsive design patterns
