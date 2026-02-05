---
name: style-consistency
description: Rules for maintaining consistent styling within block implementations
tags: [styling, theming, consistency, blocks]
---

# Style Consistency Rules

## Core Principle

**ALWAYS** maintain consistent styling within block implementations while respecting the project's shadcn-svelte theme.

## Implementation Rules

### Block Style Respect
- **ALWAYS** respect the original styling patterns of each block
- **ALWAYS** maintain the layout spacing, font sizes, and visual hierarchy defined in the block
- **NEVER** modify block styling unless absolutely necessary for project integration

### Project Theme Integration
- **ALWAYS** respect the shadcn-svelte theme defined in the project
- **ALWAYS** use the project's CSS variables and design tokens
- **NEVER** override project theme settings with block-specific styles

### Custom Component Styling
- **ALWAYS** respect the block's styling when creating custom components for block pages
- **ALWAYS** follow the same spacing, typography, and color patterns as the original block
- **NEVER** introduce inconsistent styling patterns within block implementations

### Layout Consistency
- **ALWAYS** maintain consistent layout spacing within block pages
- **ALWAYS** use the same responsive breakpoints and grid systems as the block
- **NEVER** mix different layout paradigms within a single block implementation

### Typography and Colors
- **ALWAYS** use the same font sizes, weights, and line heights as the block
- **ALWAYS** respect the color palette and contrast ratios defined in the block
- **NEVER** introduce new typography scales or color schemes within blocks

### Component Variants
- **ALWAYS** use the same component variants as defined in the block
- **ALWAYS** maintain consistent button sizes, input styles, and component states
- **NEVER** mix different component variants within the same block implementation

## Cross-Block Consistency
- **ALWAYS** maintain consistent styling patterns when using multiple blocks in the same project
- **ALWAYS** ensure blocks work harmoniously together without visual conflicts
- **NEVER** allow blocks to have conflicting styling approaches

## Responsive Design
- **ALWAYS** maintain the responsive behavior defined in each block
- **ALWAYS** use the same breakpoints and responsive patterns as the original block
- **NEVER** break the responsive design of blocks during integration

## CSS Variables and Theming
- **ALWAYS** use CSS variables for theming when available
- **ALWAYS** respect the project's CSS variable naming conventions
- **NEVER** hardcode values that should be themeable
