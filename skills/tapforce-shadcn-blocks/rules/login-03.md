---
name: login-03
description: Login block template 03 with flexible button options.
tags: 
    - login
    - template
    - shadcn
    - svelte
    - tapforce
---

Main information of block found at https://www.shadcn-svelte.com/blocks#login-03.

## Implementation Guide

### Installation
```bash
pnpm dlx shadcn-svelte@latest add login-03
```

### Button Configuration Options

The login-03 block includes optional buttons that can be configured based on user requirements:

#### Social Login Buttons
- **Login with Apple** - Optional social login button
- **Login with Google** - Optional social login button

#### Authentication Links
- **Forgot Password** - Optional password recovery link
- **Sign Up** - Optional registration link

### Default Behavior
By default, all buttons and links are included:
- Both "Login with Apple" and "Login with Google" buttons
- Both "Forgot Password" and "Sign Up" links

### Customization Logic

#### Social Login Buttons
1. **Default**: Include both Apple and Google login buttons
2. **If user says "no need login apple"**: Remove only the Apple login button, keep Google
3. **If user says "no need login google"**: Remove only the Google login button, keep Apple
4. **If user says "no need social login" or similar**: Remove both social login buttons

#### Authentication Links
1. **Default**: Include both "Forgot Password" and "Sign Up" links
2. **If user says "no need forgot password"**: Remove only the forgot password link, keep sign up
3. **If user says "no need signup" or "no need sign up"**: Remove only the sign up link, keep forgot password
4. **If user says "no need extra links" or similar**: Remove both forgot password and sign up links

### Implementation Steps

1. Install the block using the command above
2. Move the generated files to the correct location if needed (e.g., from `/login-03/` to `/login/`)
3. Review the generated component and identify the button/link sections
4. Apply user preferences by removing unwanted buttons/links based on the logic above
5. Ensure proper spacing and layout after removing elements
6. Test the final implementation to ensure all remaining functionality works correctly

### Detection Patterns

Look for these elements in the generated component:
- Social login buttons (typically in a div with social login providers)
- "Forgot password" link or button
- "Sign up" link or button
- Form sections that may need adjustment after removing elements