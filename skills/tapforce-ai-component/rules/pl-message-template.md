---
name: pl-message-template
description: Complete guide for implementing AI chat/message interfaces using Svelte AI Elements new-message template with Svelte 5 compatibility.
tags:
  - policy
  - template
  - message
  - chat
  - ai
  - svelte5
---

## MANDATORY: Use Svelte AI Elements new-message template for AI chat/message implementations

### When to Apply This Rule:
**ALWAYS** apply this rule when ANY of these conditions are met:
- User requests "AI chatbox", "AI message chatbox", "chat interface", or similar
- User requests "message box", "chat component", "conversation UI"
- User requests any AI-related messaging functionality
- Project requires AI agent interaction interfaces
- Building chatbots, AI assistants, or conversational UI

### COMPLETE Installation Process:

#### Step 1: Install new-message Template
**MUST** use this exact command pattern (replace version with project's shadcn-svelte version):

```bash
pnpm dlx shadcn-svelte@1.1.1 add https://svelte-ai-elements.vercel.app/r/new-message.json
```

#### Step 2: Install Required Dependencies
**MUST** install Shiki themes for syntax highlighting:

```bash
pnpm add @shikijs/themes
```

#### Step 3: Install Supporting UI Components
**MUST** install additional UI components for complete chat interface:

```bash
pnpm dlx shadcn-svelte@1.1.1 add input
pnpm dlx shadcn-svelte@1.1.1 add scroll-area
```

### Svelte 5 Compatibility Requirements:

#### Core Svelte 5 Runes Patterns:
- **$state()**: For reactive state management
- **$derived()**: For computed values based on state
- **$props()**: For component props with type safety
- **$effect()**: For side effects and context setup

#### Required Svelte 5 Patterns:

1. **MessageBranch Component State Management:**
```typescript
// ✅ CORRECT - Svelte 5 compatible pattern
const branchContext = $derived(new MessageBranchClass(defaultBranch));
$effect(() => setMessageBranchContext(branchContext));
// Use $derived() for computed values to avoid Svelte 5 warnings
```

2. **Chat State Management:**
```typescript
// ✅ CORRECT - Using Svelte 5 runes for state
let messages = $state<ChatMessage[]>([]);
let inputMessage = $state("");
let isLoading = $state(false);
```

3. **UI Component Import Pattern:**
```typescript
// ✅ CORRECT - Import UI components properly
import { Root as ScrollArea, Scrollbar } from "$lib/components/ui/scroll-area";
import { Root as Button } from "$lib/components/ui/button";
import { Root as Input } from "$lib/components/ui/input";
```

4. **MessageAction Usage:**
```typescript
// ✅ CORRECT - Proper MessageAction with tooltip
<MessageAction onclick={() => copyMessage(content)} tooltip="Copy message">
  <Copy class="w-4 h-4" />
</MessageAction>
```

### Implementation Requirements:

#### Core Components (MUST use):
- `Message` for message container with role-based styling
- `MessageContent` for message body and content display
- `MessageActions` for interactive action buttons
- `MessageAction` for individual actions (copy, regenerate, etc.)

#### State Management (MUST use Svelte 5 runes):
- Use `$state()` for reactive state variables
- Use `$derived()` for computed values
- Use `$effect()` for side effects and context setup
- Use `$props()` for component props with proper typing

#### Features to Implement:
- Copy functionality for assistant messages (with error handling)
- Regenerate response capability
- Proper MessageRole types from context
- Loading states with animated indicators
- Keyboard shortcuts (Enter to send, Shift+Enter for new line)

### Incorrect Implementation:
```typescript
// ❌ WRONG - Creating custom components instead of using new-message template
import { Message } from "$lib/components/ai-elements/message";

// ❌ WRONG - Using basic message component only
pnpm dlx shadcn-svelte@latest add https://svelte-ai-elements.vercel.app/r/message.json

// ❌ WRONG - Svelte 5 incompatible patterns
const branchContext = new MessageBranchClass(defaultBranch);
setMessageBranchContext(branchContext);
let previousBranch = $state(branchContext.currentBranch); // Causes warnings

// ❌ WRONG - Missing required imports
import { Message, MessageContent, MessageActions, MessageAction } from "$lib/components/ai-elements/new-message";
```

### Correct Implementation:
```typescript
// ✅ CORRECT - Use new-message template with all required imports
import { Message, MessageContent, MessageActions, MessageAction, MessageBranchClass, setMessageBranchContext, type MessageRole } from "$lib/components/ai-elements/new-message/index";

// ✅ CORRECT - Complete installation sequence
pnpm dlx shadcn-svelte@1.1.1 add https://svelte-ai-elements.vercel.app/r/new-message.json
pnpm add @shikijs/themes
pnpm dlx shadcn-svelte@1.1.1 add input scroll-area

// ✅ CORRECT - Svelte 5 compatible state management
let messages = $state<ChatMessage[]>([]);
let inputMessage = $state("");
let isLoading = $state(false);

// ✅ CORRECT - Svelte 5 compatible MessageBranch pattern
const branchContext = $derived(new MessageBranchClass(defaultBranch));
$effect(() => setMessageBranchContext(branchContext));

// ✅ CORRECT - Proper MessageAction usage
<MessageAction onclick={() => copyMessage(content)} tooltip="Copy message">
  <Copy class="w-4 h-4" />
</MessageAction>
```

### Verification Checklist:
- [ ] Used `new-message.json` template (not `message.json`)
- [ ] Installed @shikijs/themes dependency
- [ ] Installed required UI components (input, scroll-area)
- [ ] Imported from `ai-elements/new-message/index` path
- [ ] Used proper MessageRole types from context
- [ ] Implemented MessageActions for assistant messages
- [ ] Used Svelte 5 runes ($state, $derived, $effect, $props)
- [ ] Applied proper MessageAction props (onclick, tooltip)
- [ ] Verified project runs without dependency errors
- [ ] Tested chat functionality (send, copy, regenerate)

### Common Issues & Solutions:

#### Issue 1: UI Component Import Errors
**Problem**: TypeScript errors when using `* as Component` imports
**Solution**: Use named imports `Root as Component` if direct imports cause errors

#### Issue 2: Svelte 5 Runes Warnings
**Problem**: "This reference only captures the initial value" warnings
**Solution**: Use `$derived()` for computed values instead of `$state()` with initial assignments

#### Issue 3: Missing Context Exports
**Problem**: Type errors with MessageBranch setup
**Solution**: Ensure all required exports are imported from the index file

### Enforcement:
This rule is **MANDATORY** and **NON-OPTIONAL**. Failure to follow this rule results in:
- Inconsistent AI component architecture
- Missing AI-native features
- Svelte 5 compatibility issues
- Poor maintainability
- Non-standard implementation patterns
- Dependency resolution errors

### Reference:
- Official Documentation: https://svelte-ai-elements.vercel.app/components/new-message
- Svelte 5 Runes Guide: https://svelte.dev/docs/svelte/5#runes
- Component API: Message, MessageContent, MessageActions, MessageAction, MessageBranchClass

