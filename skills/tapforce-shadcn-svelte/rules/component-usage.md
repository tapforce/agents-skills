---
name: component-usage
description: Best practices for using shadcn-svelte components effectively by taking advantage of available options like variant, size, and class properties.
---

# Component Usage Best Practices Rule

## Overview

This rule provides guidelines for effectively using shadcn-svelte components by leveraging their built-in options and customization capabilities.

## Core Principle

**Always take advantage of component options when using shadcn components.**

## Why This Rule Exists

shadcn-svelte components are designed with extensive customization options that provide:

- Consistent design patterns
- Accessibility features
- Responsive behavior
- Theme integration
- Reduced code duplication

## Common Component Options

### Button Component

The Button component is a perfect example of leveraging component options:

```svelte
<script lang="ts">
  import { Button } from "$lib/components/ui/button/index.js";
</script>

<!-- ✅ Good: Using built-in variants and sizes -->
<Button variant="default" size="lg">Large Default Button</Button>
<Button variant="destructive" size="sm">Small Destructive Button</Button>
<Button variant="outline" size="icon">
  <Icon />
</Button>

<!-- ❌ Avoid: Creating separate components for each style -->
<!-- Instead of creating CustomLargeButton, CustomDestructiveButton, etc. -->
```

#### Available Button Options

- **variant**: `default` | `destructive` | `outline` | `secondary` | `ghost` | `link`
- **size**: `default` | `sm` | `lg` | `icon`
- **class**: Additional CSS classes for custom styling

### Input Component

```svelte
<script lang="ts">
  import { Input } from "$lib/components/ui/input/index.js";
</script>

<!-- ✅ Good: Using class prop for additional styling -->
<Input 
  type="email" 
  placeholder="Enter your email"
  class="w-full max-w-sm"
/>

<!-- ✅ Good: Combining with other components -->
<div class="space-y-2">
  <Label for="email">Email</Label>
  <Input id="email" type="email" />
</div>
```

### Card Component

```svelte
<script lang="ts">
  import * as Card from "$lib/components/ui/card/index.js";
</script>

<!-- ✅ Good: Using card components as a system -->
<Card.Root class="w-full max-w-md">
  <Card.Header>
    <Card.Title>Card Title</Card.Title>
    <Card.Description>Card description goes here</Card.Description>
  </Card.Header>
  <Card.Content>
    <p>Card content</p>
  </Card.Content>
  <Card.Footer>
    <Button>Action</Button>
  </Card.Footer>
</Card.Root>
```

## Best Practices by Component Category

### Form Components

#### Input Fields
- Use `class` prop for layout-specific styling
- Combine with `Label` components for accessibility
- Leverage `Field` components for form validation

```svelte
<script lang="ts">
  import { Input } from "$lib/components/ui/input/index.js";
  import { Label } from "$lib/components/ui/label/index.js";
  import { Field } from "$lib/components/ui/field/index.js";
</script>

<Field.Root>
  <Field.Label>Username</Field.Label>
  <Field.Input>
    <Input type="text" placeholder="Enter username" />
  </Field.Input>
  <Field.Description>Choose a unique username</Field.Description>
  <Field.Error>Username is required</Field.Error>
</Field.Root>
```

#### Selection Components
- Use `Select` for dropdown menus
- Use `Checkbox` and `Radio Group` for selections
- Leverage built-in validation states

```svelte
<script lang="ts">
  import * as Select from "$lib/components/ui/select/index.js";
  import * as Checkbox from "$lib/components/ui/checkbox/index.js";
</script>

<!-- Select with options -->
<Select.Root>
  <Select.Trigger>
    <Select.Value placeholder="Select an option" />
  </Select.Trigger>
  <Select.Content>
    <Select.Item value="option1">Option 1</Select.Item>
    <Select.Item value="option2">Option 2</Select.Item>
  </Select.Content>
</Select.Root>

<!-- Checkbox with custom styling -->
<Checkbox.Root class="border-2">
  <Checkbox.Box />
  <Checkbox.Label>Accept terms</Checkbox.Label>
</Checkbox.Root>
```

### Layout Components

#### Cards and Containers
- Use `Card` components for content grouping
- Leverage `Separator` for visual division
- Use `Sheet` and `Dialog` for overlays

```svelte
<script lang="ts">
  import * as Card from "$lib/components/ui/card/index.js";
  import { Separator } from "$lib/components/ui/separator/index.js";
</script>

<Card.Root class="col-span-2">
  <Card.Header>
    <Card.Title>Dashboard</Card.Title>
  </Card.Header>
  <Card.Content>
    <p>Welcome to your dashboard</p>
    <Separator class="my-4" />
    <p>Additional content</p>
  </Card.Content>
</Card.Root>
```

### Navigation Components

#### Menus and Navigation
- Use `Navigation Menu` for primary navigation
- Use `Dropdown Menu` for action menus
- Leverage `Breadcrumb` for navigation hierarchy

```svelte
<script lang="ts">
  import * as NavigationMenu from "$lib/components/ui/navigation-menu/index.js";
  import * as DropdownMenu from "$lib/components/ui/dropdown-menu/index.js";
</script>

<!-- Navigation menu with variants -->
<NavigationMenu.Root>
  <NavigationMenu.List>
    <NavigationMenu.Item>
      <NavigationMenu.Trigger>Products</NavigationMenu.Trigger>
      <NavigationMenu.Content>
        <NavigationMenu.Link href="/product1">Product 1</NavigationMenu.Link>
      </NavigationMenu.Content>
    </NavigationMenu.Item>
  </NavigationMenu.List>
</NavigationMenu.Root>

<!-- Dropdown with custom trigger -->
<DropdownMenu.Root>
  <DropdownMenu.Trigger asChild>
    <Button variant="outline">Actions</Button>
  </DropdownMenu.Trigger>
  <DropdownMenu.Content>
    <DropdownMenu.Item>Edit</DropdownMenu.Item>
    <DropdownMenu.Item>Delete</DropdownMenu.Item>
  </DropdownMenu.Content>
</DropdownMenu.Root>
```

## Advanced Usage Patterns

### Combining Components

```svelte
<script lang="ts">
  import { Button } from "$lib/components/ui/button/index.js";
  import * as Card from "$lib/components/ui/card/index.js";
  import { Badge } from "$lib/components/ui/badge/index.js";
</script>

<Card.Root>
  <Card.Header class="flex items-center justify-between">
    <div>
      <Card.Title>Feature Title</Card.Title>
      <Card.Description>Feature description</Card.Description>
    </div>
    <Badge variant="secondary">New</Badge>
  </Card.Header>
  <Card.Content>
    <p>Content goes here</p>
  </Card.Content>
  <Card.Footer class="flex justify-between">
    <Button variant="outline">Cancel</Button>
    <Button>Save</Button>
  </Card.Footer>
</Card.Root>
```

### Responsive Design with Component Options

```svelte
<script lang="ts">
  import { Button } from "$lib/components/ui/button/index.js";
  import { Input } from "$lib/components/ui/input/index.js";
</script>

<!-- Responsive button sizes -->
<Button 
  size="sm" 
  class="hidden sm:inline-flex md:size-default lg:size-lg"
>
  Responsive Button
</Button>

<!-- Responsive input -->
<Input 
  class="w-full sm:w-auto"
  placeholder="Search..."
/>
```

## Custom Styling Guidelines

### Using the Class Prop Effectively

```svelte
<script lang="ts">
  import { Button } from "$lib/components/ui/button/index.js";
  import { cn } from "$lib/utils.js";
</script>

<!-- ✅ Good: Using class prop with utility classes -->
<Button 
  variant="outline"
  class={cn(
    "w-full sm:w-auto",           // Responsive width
    "transition-all duration-200", // Smooth transitions
    "hover:scale-105"             // Hover effects
  )}
>
  Enhanced Button
</Button>

<!-- ✅ Good: Conditional classes -->
<Button 
  variant={isPrimary ? "default" : "outline"}
  class={cn(
    "font-semibold",
    isDisabled && "opacity-50 cursor-not-allowed"
  )}
>
  {isPrimary ? "Primary Action" : "Secondary Action"}
</Button>
```

### Theme Integration

```svelte
<script lang="ts">
  import { Button } from "$lib/components/ui/button/index.js";
</script>

<!-- ✅ Good: Using theme colors -->
<Button class="bg-sidebar text-sidebar-foreground">
  Sidebar Styled Button
</Button>

<!-- ✅ Good: Dark mode aware -->
<Button class="border-border bg-card hover:bg-accent">
  Theme Aware Button
</Button>
```

## Common Anti-Patterns to Avoid

- ❌ Creating wrapper components for simple variant changes
- ❌ Hardcoding styles that could use component props
- ❌ Ignoring accessibility features built into components
- ❌ Not using the `class` prop for custom styling
- ❌ Rebuilding existing functionality instead of using component options

## Approved Patterns

- ✅ Using built-in variants and sizes
- ✅ Leveraging the `class` prop for additional styling
- ✅ Combining components for complex UI patterns
- ✅ Using theme variables for consistent styling
- ✅ Following component composition patterns
- ✅ Implementing responsive design with utility classes
