---
name: pl-consistent-components
description: Practices to use consistent shadcn components
---

**CRITICAL**: ALWAYS prefer use Shadcn UI components as first choice for UI if found suitable.

**CRITICAL**: AVOID modify Shadcn components as much as possible. Keep in mind there components should be update/override easily when Shadcn update new version.

**CRITICAL**: When importing shadcn components in Svelte, the project MUST use the following pattern:

**REQUIRED IMPORT PATTERN**:
```typescript
import { ComponentName } from '$lib/components/ui/component/index';
```

**Examples**:
```typescript
import { Card } from '$lib/components/ui/card/index';
import { Button } from '$lib/components/ui/button/index';
import { Dialog } from '$lib/components/ui/dialog/index';
import { Input } from '$lib/components/ui/input/index';
```

**STRICTLY FORBIDDEN PATTERNS**:

❌ **NEVER use namespace imports**:
```typescript
import * as Card from '$lib/components/ui/card/index';  // FORBIDDEN
```

❌ **NEVER import individual Svelte files**:
```typescript
import Card from '$lib/components/ui/card.svelte';     // FORBIDDEN
import Button from '$lib/components/ui/button.svelte';  // FORBIDDEN
```

❌ **NEVER use wildcard imports**:
```typescript
import * as Components from '$lib/components/ui/card/index';  // FORBIDDEN
```

**COMPONENT USAGE**:
When using the required import pattern, components can be used directly:
```typescript
// Correct usage
<Card>
  <Card.Content>Content</Card.Content>
  <Card.Header>Header</Card.Header>
  <Card.Footer>Footer</Card.Footer>
</Card>

<Button>Click me</Button>
<Dialog>
  <Dialog.Trigger>Open</Dialog.Trigger>
  <Dialog.Content>Dialog content</Dialog.Content>
</Dialog>
```

**ENFORCEMENT**: This import pattern is strictly enforced across the entire project to maintain:
- Consistent component usage
- Proper tree-shaking
- Clear dependency tracking
- Simplified component management

**REASON**: The `import { Component } from '.../index'` pattern provides direct access to the main component while maintaining access to all sub-components (Content, Header, Footer, Trigger, etc.) as named exports. This approach avoids the complexity of namespace imports while preventing direct file imports that break component abstraction.