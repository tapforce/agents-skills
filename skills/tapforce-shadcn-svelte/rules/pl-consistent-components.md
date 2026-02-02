---
name: pl-consistent-components
description: Practices to use consistent shadcn components
---

**CRITICAL**: ALWAYS prefer use Shadcn UI components as first choice for UI if found suitable.

**CRITICAL**: AVOID modify Shadcn components as much as possible. Keep in mind there components should be update/override easily when Shadcn update new version.

**CRITICAL**: When importing shadcn components in Svelte, ALWAYS use namespace import pattern: `import * as Component from '$lib/components/ui/component'`

**Incorrect**: 
```typescript
import Card from '$lib/components/ui/card.svelte';
import Button from '$lib/components/ui/button.svelte';
import Dialog from '$lib/components/ui/dialog.svelte';
```

**Correct**:
```typescript
import * as Card from '$lib/components/ui/card';
import * as Button from '$lib/components/ui/button';
import * as Dialog from '$lib/components/ui/dialog';
```

This allows access to all exported parts of any component (Card.Content, Button.Root, Dialog.Content, etc.) as namespace properties.

**Reason**: shadcn components export multiple parts (Root, Content, Header, Footer, Trigger, etc.) as named exports, not as default exports. The namespace import pattern captures all exports under a single namespace object for any component type.