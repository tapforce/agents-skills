---
name: pl-consistent-components
description: Practices to use consistent shadcn components
---

**CRITICAL**: ALWAYS prefer use Shadcn UI components as first choice for UI if found suitable.

**CRITICAL**: AVOID modify Shadcn components as much as possible. Keep in mind there components should be update/override easily when Shadcn update new version.

**CRITICAL**: When importing shadcn components in Svelte, use one of these patterns:

**Option 1 - Namespace import (recommended for components with multiple parts)**:
```typescript
import * as Card from '$lib/components/ui/card/index';
```

**Option 2 - Individual component import**:
```typescript
import { Card } from '$lib/components/ui/card/index';
```

**Incorrect**: 
```typescript
import Card from '$lib/components/ui/card.svelte';
import Button from '$lib/components/ui/button.svelte';
import Dialog from '$lib/components/ui/dialog.svelte';
```

**Usage with namespace imports**:
When using `import * as Component`, you MUST use the Root component explicitly:
```typescript
// Correct
<Card.Root>
  <Card.Content>Content</Card.Content>
</Card.Root>

// Incorrect
<Card>
  <Card.Content>Content</Card.Content>
</Card>
```

**Usage with individual imports**:
When using `import { Component }`, use the component directly:
```typescript
// Correct
<Card>
  <Card.Content>Content</Card.Content>
</Card>
```

**Reason**: shadcn components export multiple parts (Root, Content, Header, Footer, Trigger, etc.) as named exports. The namespace import pattern captures all exports under a single namespace object, but requires using Component.Root for the main component. Individual imports provide direct access to the main component.