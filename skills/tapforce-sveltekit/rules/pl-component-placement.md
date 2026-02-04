---
name: pl-component-placement
description: Guide for choosing component placement when creating new components
tags: [sveltekit, component, placement, organization, policy]
---

## Component Placement Rules

When creating new components, follow these placement guidelines based on component scope and reusability.

### Rule 1: Page-Specific Components

**When component is used for a specific page only and not intended for reuse elsewhere:**

- **MUST place component in the same folder as the page that will use it**
- This keeps components close to where they're used
- Improves maintainability and reduces unnecessary complexity

**File structure example:**
```
src/routes/dashboard/
├── +page.svelte
├── dashboard-stats.svelte      # Page-specific component
├── user-profile.svelte        # Page-specific component
└── +layout.svelte
```

**Usage in page:**
```svelte
<script>
  import DashboardStats from './dashboard-stats.svelte';
  import UserProfile from './user-profile.svelte';
</script>

<DashboardStats />
<UserProfile />
```

### Rule 2: Reusable Components

**When component will be used across multiple pages:**

- **MUST place component in `src/lib/components/`**
- **Create meaningful folder names related to component's content/purpose**
- Use descriptive folder structure for better organization

**File structure examples:**

**Option A: Simple components**
```
src/lib/components/
├── ui/
│   ├── button.svelte
│   ├── input.svelte
│   └── modal.svelte
├── forms/
│   ├── contact-form.svelte
│   └── search-form.svelte
└── layout/
    ├── header.svelte
    └── sidebar.svelte
```

**Option B: Feature-specific components**
```
src/lib/components/
├── calendar/
│   ├── event-card.svelte
│   ├── month-view.svelte
│   └── date-picker.svelte
├── user/
│   ├── avatar.svelte
│   ├── profile-card.svelte
│   └── user-list.svelte
└── common/
    ├── loading-spinner.svelte
    └── error-boundary.svelte
```

**Usage across pages:**
```svelte
<script>
  import Button from '$lib/components/ui/button.svelte';
  import EventCard from '$lib/components/calendar/event-card.svelte';
  import Avatar from '$lib/components/user/avatar.svelte';
</script>

<Button>
  <EventCard />
  <Avatar />
</Button>
```

## Decision Flow

1. **Ask yourself**: Will this component be used in more than one page?
   - **No** → Place in same folder as the page (Rule 1)
   - **Yes** → Place in `src/lib/components/` (Rule 2)

2. **If placing in `src/lib/components/`:**
   - What is the component's primary purpose/domain?
   - Create or use appropriate folder structure
   - Use descriptive, meaningful folder names

## Incorrect Examples

```svelte
<!-- WRONG: Page-specific component in lib/components -->
<!-- This should be in src/routes/dashboard/ -->
<script>
  import DashboardStats from '$lib/components/dashboard-stats.svelte';
</script>

<!-- WRONG: Reusable component in page folder -->
<!-- This should be in src/lib/components/ui/ -->
<script>
  import Button from './button.svelte';  <!-- If used elsewhere -->
</script>
```

## Correct Examples

```svelte
<!-- CORRECT: Page-specific component -->
<script>
  import DashboardStats from './dashboard-stats.svelte';
</script>

<!-- CORRECT: Reusable component -->
<script>
  import Button from '$lib/components/ui/button.svelte';
  import Calendar from '$lib/components/calendar/month-view.svelte';
</script>
```

## Important Notes

- **Page-specific components** should be co-located with their page
- **Reusable components** should be organized by domain/purpose in `src/lib/components/`
- **Folder names should be descriptive** and reflect the component's functionality
- **Avoid deep nesting** - keep the structure simple and intuitive
- **Consider future reuse** - if unsure, start in page folder and move to `lib/components/` when reuse is needed
