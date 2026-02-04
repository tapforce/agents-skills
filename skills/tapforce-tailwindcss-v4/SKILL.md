---
name: tapforce-tailwindcss-v4
description: Comprehensive guide for TailwindCSS v4 setup and best practices in Node.js web projects. Includes installation verification, framework-specific setup instructions, and modern v4 configuration patterns.
license: Apache-2.0
metadata:
  author: tapforce
  version: "1.0"
compatibility: Requires Node.js and compatible web framework (SvelteKit, Next.js, Gatsby, React Router)
---

# TailwindCSS v4 Setup and Best Practices

This skill provides comprehensive guidance for setting up and using TailwindCSS v4 in Node.js-based web projects.

## When to Use

Use this skill when:
- Starting a new web project with Node.js backend/framework
- Adding TailwindCSS v4 to an existing project
- Migrating from TailwindCSS v3 to v4
- Setting up styling for SvelteKit, Next.js, Gatsby, or React Router projects

## Step 1: Check Current Installation

First, verify if TailwindCSS v4 is already installed in your project:

```bash
# Check package.json for tailwindcss dependency
cat package.json | grep -i tailwind
```

If TailwindCSS is not installed or is version 3.x, proceed with installation.

## Step 2: Install TailwindCSS v4

Install TailwindCSS v4 and its dependencies:

```bash
# Using npm
npm install -D tailwindcss@^4.0.0

# Using pnpm
pnpm add -D tailwindcss@^4.0.0

# Using yarn
yarn add -D tailwindcss@^4.0.0
```

## Step 3: Framework-Specific Setup

### SvelteKit
Reference: https://tailwindcss.com/docs/installation/framework-guides/sveltekit

1. Create or update `./src/routes/layout.css`:
```css
@import "tailwindcss";

/* Custom configuration goes here */
@theme {
  /* Your custom theme configuration */
}
```

2. Import the CSS in your layout file:
```javascript
// ./src/routes/+layout.js
import '../app.css';
```

### Next.js
Reference: https://tailwindcss.com/docs/installation/framework-guides/nextjs

1. Create or update `./app/globals.css`:
```css
@import "tailwindcss";

/* Custom configuration goes here */
@theme {
  /* Your custom theme configuration */
}
```

2. Import in your layout:
```javascript
// ./app/layout.js
import './globals.css';
```

### Gatsby
Reference: https://tailwindcss.com/docs/installation/framework-guides/gatsby

1. Create or update `./src/css/global.css`:
```css
@import "tailwindcss";

/* Custom configuration goes here */
@theme {
  /* Your custom theme configuration */
}
```

2. Import in `gatsby-browser.js`:
```javascript
// ./gatsby-browser.js
import './src/css/global.css';
```

### React Router
Reference: https://tailwindcss.com/docs/installation/framework-guides/react-router

1. Create or update `./src/index.css`:
```css
@import "tailwindcss";

/* Custom configuration goes here */
@theme {
  /* Your custom theme configuration */
}
```

2. Import in your main entry point:
```javascript
// ./src/main.jsx or ./src/index.js
import './index.css';
```

## Step 4: Configuration and Best Practices

### Color System
TailwindCSS v4 uses `oklch()` color values by default. Reference: https://tailwindcss.com/docs/colors

```css
@theme {
  --color-primary: oklch(0.5 0.2 250);
  --color-secondary: oklch(0.6 0.15 200);
}
```

### Custom Colors as CSS Variables
When using custom colors in multiple places, define them as CSS variables with meaningful names:

```css
@theme {
  --color-brand-blue: oklch(0.55 0.2 260);
  --color-brand-green: oklch(0.65 0.15 160);
  --color-warning: oklch(0.85 0.2 60);
  --color-error: oklch(0.65 0.25 20);
}
```

### Custom Utilities with @utility
For styles used more than once, create utility classes using the `@utility` directive:

```css
@utility card-shadow {
  box-shadow: 0 4px 6px -1px rgb(0 0 0 / 0.1), 0 2px 4px -2px rgb(0 0 0 / 0.1);
}

@utility gradient-text {
  background: linear-gradient(135deg, var(--color-brand-blue), var(--color-brand-green));
  -webkit-background-clip: text;
  -webkit-text-fill-color: transparent;
  background-clip: text;
}
```

### Arbitrary Values Syntax
Prefer TailwindCSS class syntax for custom CSS:

```html
<!-- Instead of custom CSS -->
<div style="grid-auto-rows: minmax(0, 2fr);">

<!-- Use TailwindCSS arbitrary values -->
<div class="auto-rows-[minmax(0,2fr)]">
```

### Priority Syntax (!)
In TailwindCSS v4, the `!` syntax is placed AFTER the class name:

```html
<!-- Correct v4 syntax -->
<div class="bg-red-500 !text-white">

<!-- Incorrect (v3 syntax) -->
<div class="!bg-red-500 text-white">
```

## Step 5: Avoid Inline Custom CSS

Never write custom or plain CSS inline in HTML files or component files. Instead:

1. **For one-off styles**: Use TailwindCSS arbitrary values
2. **For reusable styles**: Create utility classes with `@utility`

### Examples

#### ❌ Avoid This
```svelte
<!-- Svelte component -->
<div style="background: linear-gradient(135deg, blue, green); color: white;">
  <style>
    .custom-style {
      padding: 1rem;
      border-radius: 0.5rem;
    }
  </style>
</div>
```

#### ✅ Do This
```css
/* In your main CSS file */
@utility gradient-bg {
  background: linear-gradient(135deg, var(--color-brand-blue), var(--color-brand-green));
}

@utility card-padding {
  padding: 1rem;
}

@utility rounded-lg {
  border-radius: 0.5rem;
}
```

```svelte
<!-- Svelte component -->
<div class="gradient-bg text-white card-padding rounded-lg">
```

## Step 6: Testing Your Setup

1. Add some TailwindCSS classes to verify it's working:
```html
<div class="bg-blue-500 text-white p-4 rounded-lg">
  If this is blue with white text, TailwindCSS is working!
</div>
```

2. Run your development server and verify the styles are applied.

## Common Issues and Solutions

### Issue: Styles not applying
- Verify the CSS import is in the correct location for your framework
- Check that your CSS file contains `@import "tailwindcss";`
- Ensure your development server is restarted after installation

### Issue: Build errors
- Verify all dependencies are installed correctly
- Check for syntax errors in your CSS configuration
- Ensure framework-specific setup is followed correctly

### Issue: Color inconsistencies
- Use CSS variables for custom colors used in multiple places
- Prefer `oklch()` color values for better color space coverage
- Document your color palette in the main CSS file

## Migration from v3 to v4

If migrating from TailwindCSS v3:

1. Remove `tailwind.config.js` file (configuration now in CSS)
2. Update CSS imports to use `@import "tailwindcss";`
3. Move configuration to `@theme` block in CSS
4. Update priority syntax from `!class` to `class!`
5. Replace custom CSS with utility classes where possible
