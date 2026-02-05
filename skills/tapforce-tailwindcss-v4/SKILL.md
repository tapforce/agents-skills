---
name: tapforce-tailwindcss-v4
description: Comprehensive guide for TailwindCSS v4 setup and best practices in Node.js web projects. Includes installation verification, framework-specific setup instructions, and modern v4 configuration patterns.
license: Apache-2.0
metadata:
  author: tapforce
  version: "1.1"
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

### Detect Package Manager
First, detect which package manager your project uses:

```bash
# Check for lock files (in order of preference)
if [ -f "pnpm-lock.yaml" ]; then echo "pnpm";
elif [ -f "yarn.lock" ]; then echo "yarn";
elif [ -f "package-lock.json" ]; then echo "npm";
else echo "pnpm"; # Default recommendation
fi
```

### Installation Commands (Fallback Only)
**This section should only be used when no specific framework is detected for the project.**

If you cannot determine the project's framework, install TailwindCSS v4 base dependencies:

```bash
# Using pnpm (recommended)
pnpm add -D tailwindcss@^4.0.0

# Using npm
npm install -D tailwindcss@^4.0.0

# Using yarn
yarn add -D tailwindcss@^4.0.0
```

**Note**: If no package manager is detected, strongly recommend using `pnpm` for better performance and disk space efficiency.

**Important**: For framework-specific projects, use the installation commands provided in Step 3 for your specific framework instead.

## Step 3: Framework-Specific Setup

### SvelteKit
Reference: https://tailwindcss.com/docs/installation/framework-guides/sveltekit

#### Option A: New Project Installation
Follow these exact steps for a new SvelteKit project:

1. **Create SvelteKit project** (if not already created):
```bash
npx sv create my-project
cd my-project
```

2. **Install TailwindCSS v4 dependencies**:
```bash
# Using detected package manager (pnpm recommended)
[pnpm|npm|yarn] add tailwindcss @tailwindcss/vite
```

3. **Configure Vite plugin**:
Create/update `vite.config.js`:
```javascript
import { sveltekit } from '@sveltejs/kit/vite';
import { defineConfig } from 'vite';
import tailwindcss from '@tailwindcss/vite';

export default defineConfig({
  plugins: [
    tailwindcss(),
    sveltekit(),
  ],
});
```

4. **Create CSS file**:
Create `./src/app.css`:
```css
@import "tailwindcss";
```

5. **Import CSS in layout**:
Create `./src/routes/+layout.svelte`:
```svelte
<script>
  let { children } = $props();
  import "../app.css";
</script>

{@render children()}
```

#### Option B: Update Existing Project
If updating an existing SvelteKit project:

1. **Install dependencies**:
```bash
[pnpm|npm|yarn] add tailwindcss @tailwindcss/vite
```

2. **Update vite.config.js** to include the tailwindcss plugin (as shown in step 3 above)

3. **Create/update app.css** with `@import "tailwindcss";`

4. **Ensure layout imports** the CSS file

### Next.js
Reference: https://tailwindcss.com/docs/installation/framework-guides/nextjs

#### Option A: New Project Installation
Follow these exact steps for a new Next.js project:

1. **Create Next.js project** (if not already created):
```bash
npx create-next-app@latest my-project --typescript --eslint --app
cd my-project
```

2. **Install TailwindCSS v4 dependencies**:
```bash
[pnpm|npm|yarn] add tailwindcss @tailwindcss/postcss postcss
```

3. **Configure PostCSS**:
Create `postcss.config.mjs`:
```javascript
const config = {
  plugins: {
    "@tailwindcss/postcss": {},
  },
};
export default config;
```

4. **Create CSS file**:
Create/update `./app/globals.css`:
```css
@import "tailwindcss";
```

#### Option B: Update Existing Project
If updating an existing Next.js project:

1. **Install dependencies**:
```bash
[pnpm|npm|yarn] add tailwindcss @tailwindcss/postcss postcss
```

2. **Create postcss.config.mjs** with the configuration (as shown in step 3 above)

3. **Update globals.css** to include `@import "tailwindcss";`

### Gatsby
Reference: https://tailwindcss.com/docs/installation/framework-guides/gatsby

#### Option A: New Project Installation
Follow these exact steps for a new Gatsby project:

1. **Create Gatsby project** (if not already created):
```bash
gatsby new my-project
cd my-project
```

2. **Install TailwindCSS v4 dependencies**:
```bash
[pnpm|npm|yarn] add @tailwindcss/postcss tailwindcss postcss gatsby-plugin-postcss
```

3. **Enable PostCSS plugin**:
Update `gatsby-config.js`:
```javascript
module.exports = {
  plugins: [
    'gatsby-plugin-postcss',
    // ... other plugins
  ],
}
```

4. **Configure PostCSS**:
Create `postcss.config.js`:
```javascript
module.exports = {
  plugins: {
    "@tailwindcss/postcss": {},
  },
};
```

5. **Create CSS file**:
Create `./src/styles/global.css`:
```css
@import "tailwindcss";
```

6. **Import CSS in browser file**:
Create/update `gatsby-browser.js`:
```javascript
import './src/styles/global.css';
```

#### Option B: Update Existing Project
If updating an existing Gatsby project:

1. **Install dependencies**:
```bash
[pnpm|npm|yarn] add @tailwindcss/postcss tailwindcss postcss gatsby-plugin-postcss
```

2. **Update gatsby-config.js** to include `gatsby-plugin-postcss`

3. **Create postcss.config.js** with the configuration

4. **Create global.css** with `@import "tailwindcss";`

5. **Ensure gatsby-browser.js** imports the CSS file

### React Router (Vite)
Reference: https://tailwindcss.com/docs/installation/framework-guides/react-router

#### Option A: New Project Installation
Follow these exact steps for a new React Router project:

1. **Create React Router project** (if not already created):
```bash
npm create react-router@latest my-project
cd my-project
```

2. **Install TailwindCSS v4 dependencies**:
```bash
[pnpm|npm|yarn] add tailwindcss @tailwindcss/vite
```

3. **Configure Vite plugin**:
Update `vite.config.js`:
```javascript
import { reactRouter } from "@react-router/dev/vite";
import { defineConfig } from "vite";
import tailwindcss from "@tailwindcss/vite";

export default defineConfig({
  plugins: [reactRouter(), tailwindcss()],
});
```

4. **Create CSS file**:
Create `./src/index.css`:
```css
@import "tailwindcss";
```

5. **Import CSS in entry point**:
Update `./src/main.jsx` or `./src/index.js`:
```javascript
import './index.css';
// ... other imports
```

#### Option B: Update Existing Project
If updating an existing React Router project:

1. **Install dependencies**:
```bash
[pnpm|npm|yarn] add tailwindcss @tailwindcss/vite
```

2. **Update vite.config.js** to include the tailwindcss plugin

3. **Create/update index.css** with `@import "tailwindcss";`

4. **Ensure entry point imports** the CSS file

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

## Migration from v3 to v4

If migrating from TailwindCSS v3:

1. Remove `tailwind.config.js` file (configuration now in CSS)
2. Update CSS imports to use `@import "tailwindcss";`
3. Move configuration to `@theme` block in CSS
4. Update priority syntax from `!class` to `class!`
5. Replace custom CSS with utility classes where possible

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

## Rules

This skill includes the following behavioral rules in the `rules/` directory:

### Color Format
- **Rule**: Use oklch color values instead of legacy RGB/HSL
- **File**: `rules/color-format.md`
- **Details**: Always use `oklch()` color values and define custom colors as CSS variables

### Configuration
- **Rule**: Avoid separate config files for TailwindCSS v4
- **File**: `rules/configuration.md`
- **Details**: Place `@theme` configuration after `@import "tailwindcss";`

### Framework Integration
- **Rule**: Follow framework-specific integration patterns
- **File**: `rules/framework-integration.md`
- **Details**: Use correct CSS file locations and imports for your framework

### Priority Syntax
- **Rule**: Use correct priority syntax with ! in v4
- **File**: `rules/priority-syntax.md`
- **Details**: Place `!` AFTER the class name (e.g., `bg-red-500!`)

### Styling Approach
- **Rule**: Prefer TailwindCSS classes over custom CSS
- **File**: `rules/styling-approach.md`
- **Details**: Never write inline CSS, prefer TailwindCSS class syntax

### Usage Patterns
- **Rule**: Use @utility directive and arbitrary values appropriately
- **File**: `rules/usage-patterns.md`
- **Details**: Use `@utility` for reusable styles, arbitrary values for one-off styles

These rules provide behavioral bias for agents using this skill and should be applied as high-priority guidelines.
