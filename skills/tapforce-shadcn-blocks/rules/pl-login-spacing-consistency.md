---
name: pl-login-spacing-consistency
description: Comprehensive spacing guidelines for login templates to ensure consistent layout patterns across all login variants.
tags:
    - login
    - spacing
    - layout
    - consistency
    - tailwindcss
    - shadcn
    - svelte
    - tapforce
---

# Login & Auth Template Spacing Consistency Guide

This rule establishes consistent spacing patterns for all authentication-related templates and components to ensure uniform visual hierarchy and user experience. While initially based on login templates (login-01 through login-05), these spacing guidelines should be applied to **any authentication-related interface** including:

- Login forms and pages
- Sign up/registration forms
- Password reset forms
- Email verification forms
- Profile update forms
- Single-form pages
- Authentication modals/dialogs
- Any custom auth-related components

Following these spacing patterns ensures consistency across the entire authentication flow in your project.

## Core Spacing Values

### Primary Spacing Scale
- **gap-2**: 0.5rem (8px) - Tight spacing between related elements
- **gap-4**: 1rem (16px) - Standard spacing for form sections
- **gap-6**: 1.5rem (24px) - **Primary default spacing** between major elements
- **gap-8**: 2rem (32px) - Loose spacing for better visual separation
- **gap-10**: 2.5rem (40px) - Extra loose spacing for dramatic separation

### Padding Scale
- **p-4**: 1rem (16px) - Small container padding
- **p-6**: 1.5rem (24px) - **Standard mobile padding**
- **p-10**: 2.5rem (40px) - **Standard desktop padding**
- **px-4**: 1rem (16px) - Horizontal padding only
- **px-6**: 1.5rem (24px) - Standard horizontal padding

### Responsive Padding Pattern
```
p-6 md:p-10
```
This is the **standard responsive padding pattern** used across all login templates.

## Layout Spacing Patterns by Template

### Authentication Layout Patterns

These patterns apply to **all authentication-related interfaces**, not just login templates:

#### Simple Centered Layout (Login-01 Pattern)
Best for: Login forms, password reset, email verification
```html
<!-- Main container -->
<div class="flex h-screen w-full items-center justify-center px-4">
  <!-- Form container -->
  <div class="w-full max-w-sm">
    <!-- Content with default spacing -->
  </div>
</div>
```

#### Two-Column Layout (Login-02 Pattern)
Best for: Sign up forms, login with branding, registration with features
```html
<!-- Grid container -->
<div class="grid min-h-svh lg:grid-cols-2">
  <!-- Left column with form -->
  <div class="flex flex-col items-center justify-center gap-6 p-6 lg:p-10">
    <!-- Branding and form with gap-6 -->
  </div>
  <!-- Right column with background -->
  <div class="relative hidden lg:block">
    <!-- Background content -->
  </div>
</div>
```

#### Wide Form Layout (Login-04 Pattern)
Best for: Registration forms, profile updates, detailed authentication forms
```html
<!-- Main container with muted background -->
<div class="bg-muted flex min-h-svh flex-col items-center justify-center gap-6 p-6 md:p-10">
  <!-- Wide form container -->
  <div class="flex w-full max-w-sm md:max-w-3xl flex-col gap-6">
    <!-- Content with responsive width -->
  </div>
</div>
```

#### Clean Standard Layout (Login-05 Pattern)
Best for: All authentication forms, modals, single-form pages
```html
<!-- Main container with clean background -->
<div class="bg-background flex min-h-svh flex-col items-center justify-center gap-6 p-6 md:p-10">
  <!-- Standard form container -->
  <div class="flex w-full max-w-sm flex-col gap-6">
    <!-- Content with standard spacing -->
  </div>
</div>
```

## Form Component Spacing (Authentication Forms)

### Standard Auth Form Structure
Applies to **all authentication forms** (login, sign up, password reset, etc.):
```html
<div class="flex flex-col gap-6">
  <!-- Card container -->
  <Card.Root>
    <!-- Card header with centered text -->
    <Card.Header class="text-center">
      <!-- Title and description -->
    </Card.Header>
    <!-- Card content -->
    <Card.Content>
      <!-- Form with field group -->
      <FieldGroup>
        <!-- Form fields with default spacing -->
      </FieldGroup>
    </Card.Content>
  </Card.Root>
  <!-- Footer description -->
  <FieldDescription class="px-6 text-center">
    <!-- Terms, privacy, or help links -->
  </FieldDescription>
</div>
```

### Field Group Spacing
- **Default**: Use FieldGroup's built-in spacing for all auth forms
- **Between fields**: Controlled by FieldGroup component
- **Button spacing**: Each Field wrapper handles button spacing
- **Additional links**: Use consistent spacing for "Forgot Password", "Sign Up", etc.

## Spacing Customization Rules

### When to Increase Spacing
1. **Visual clarity needed**: Change `gap-6` to `gap-8` or `gap-10`
2. **Mobile-first approach**: Consider larger gaps on smaller screens
3. **Accessibility**: More spacing helps users with motor impairments

### When to Decrease Spacing
1. **Compact design**: Change `gap-6` to `gap-4` or `gap-2`
2. **Content-heavy forms**: Reduce spacing to fit more content
3. **Mobile constraints**: Consider smaller gaps on mobile devices

### Background-Specific Spacing
- **Muted background**: Use standard spacing, background provides contrast
- **Clean background**: Use standard spacing, maintain clean aesthetic
- **Image background**: Standard spacing works with visual background
- **Modal/Dialog**: Use standard spacing even in overlay contexts

## Template Selection Based on Auth Type & Spacing Needs

### Choose Simple Centered Layout (Login-01 Pattern) When:
- Simple login or password reset forms
- Minimal spacing requirements
- Full-screen centered design needed
- Single-purpose authentication

### Choose Two-Column Layout (Login-02 Pattern) When:
- Sign up forms with feature highlights
- Login with branding elements
- Registration with marketing content
- Need visual background interest

### Choose Wide Form Layout (Login-04 Pattern) When:
- Registration forms with many fields
- Profile update forms
- Detailed authentication forms
- Need responsive width scaling

### Choose Clean Standard Layout (Login-05 Pattern) When:
- Standard authentication forms (login, sign up, reset)
- Authentication modals/dialogs
- Single-form pages
- Consistent spacing across auth flow needed

## Responsive Spacing Guidelines

### Mobile-First Spacing
```html
<!-- Base mobile spacing -->
class="gap-6 p-6"

<!-- Desktop enhancement -->
class="gap-6 p-6 md:p-10"
```

### Breakpoint-Specific Adjustments
- **sm**: Small screens (640px+) - Rarely needed for login forms
- **md**: Medium screens (768px+) - Common for padding adjustments
- **lg**: Large screens (1024px+) - Used for layout changes (login-02)
- **xl**: Extra large (1280px+) - Rarely needed for login forms

## Common Spacing Mistakes to Avoid

### ❌ Inconsistent Gap Usage
```html
<!-- Wrong -->
<div class="gap-4">
  <div class="gap-6">
    <div class="gap-8">
```

### ✅ Consistent Gap Usage
```html
<!-- Correct -->
<div class="gap-6">
  <div>
    <div>
```

### ❌ Mixed Padding Patterns
```html
<!-- Wrong -->
class="p-4 md:px-6 lg:p-8"
```

### ✅ Consistent Padding Pattern
```html
<!-- Correct -->
class="p-6 md:p-10"
```

### ❌ Arbitrary Spacing Values
```html
<!-- Wrong -->
class="gap-[24px] p-6"
```

### ✅ Standard Tailwind Classes
```html
<!-- Correct -->
class="gap-6 p-6"
```

## Implementation Checklist

### Before Implementing Auth Components
- [ ] Identify which auth layout pattern matches requirements
- [ ] Review existing spacing in current auth implementation
- [ ] Determine if custom spacing is needed for specific auth type

### During Implementation
- [ ] Use `gap-6` as default spacing between major auth elements
- [ ] Apply `p-6 md:p-10` for responsive auth container padding
- [ ] Maintain consistent spacing within all auth form components
- [ ] Use standard Tailwind classes, avoid arbitrary values
- [ ] Apply same spacing patterns to login, sign up, reset, etc.

### After Implementation
- [ ] Test spacing on mobile devices for all auth forms
- [ ] Test spacing on desktop screens for all auth forms
- [ ] Verify accessibility with sufficient spacing across auth flow
- [ ] Check visual hierarchy and readability for all auth types
- [ ] Ensure consistency between login, sign up, and other auth pages

## Maintenance Rules

### When Updating Authentication Components
1. **Preserve spacing patterns** when updating any auth components
2. **Document spacing changes** in component documentation
3. **Test all breakpoints** after spacing modifications
4. **Maintain consistency** across all authentication variants

### When Creating New Authentication Components
1. **Follow established spacing patterns** from this guide
2. **Use standard Tailwind classes** for spacing
3. **Document any spacing deviations** with clear reasoning
4. **Test against existing auth components** for consistency
5. **Ensure consistency across login, sign up, reset, and other auth flows**

### Cross-Component Consistency
- **Login ↔ Sign Up**: Must use identical spacing patterns
- **Reset Password ↔ Email Verification**: Must follow same spacing rules
- **Profile Update ↔ Settings Forms**: Should use auth spacing patterns
- **Modal/Dialog Auth**: Must maintain same spacing as full-page auth

### When Updating Login Templates
1. **Preserve spacing patterns** when updating components
2. **Document spacing changes** in template documentation
3. **Test all breakpoints** after spacing modifications
4. **Maintain consistency** across all login variants

### When Creating New Login Variants
1. **Follow established spacing patterns** from this guide
2. **Use standard Tailwind classes** for spacing
3. **Document any spacing deviations** with clear reasoning
4. **Test against existing templates** for consistency

## Spacing Testing Guidelines

### Visual Testing
1. **Mobile view**: Ensure elements don't feel cramped
2. **Tablet view**: Check spacing proportions
3. **Desktop view**: Verify spacing isn't excessive
4. **High DPI screens**: Ensure spacing scales properly

### Accessibility Testing
1. **Touch targets**: Ensure 44px minimum touch targets
2. **Screen readers**: Verify spacing doesn't affect navigation
3. **Motor impairments**: Test with larger spacing if needed
4. **Color contrast**: Background choice affects perceived spacing
