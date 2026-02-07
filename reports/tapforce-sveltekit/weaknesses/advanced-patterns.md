# Advanced Patterns Weakness Analysis

## Problem
The modern features rule focuses on basic patterns, missing complex state management and advanced reactive patterns.

## Current Approach
Simple examples of basic Svelte ^5 features:
```svelte
<script>
  let count = $state(0);
  $effect(() => console.log(count));
</script>
```

## Expected Behavior
Complex state management patterns and advanced reactive examples including:
- Complex state objects with nested reactivity
- Derived state chains
- State persistence patterns
- Cross-component state sharing
- Performance optimization patterns
- Advanced effect management

## Code Examples

### Current (Basic)
```svelte
<!-- Simple counter example -->
<script>
  let count = $state(0);
  function increment() { count += 1; }
</script>
<button onclick={increment}>{count}</button>
```

### Expected (Advanced)
```svelte
<!-- Complex state management -->
<script>
  // Complex nested state
  let appState = $state({
    user: null,
    posts: [],
    filters: {
      category: 'all',
      dateRange: null,
      search: ''
    },
    ui: {
      loading: false,
      error: null,
      sidebarOpen: true
    }
  });

  // Derived state chains
  let filteredPosts = $derived(() => {
    return appState.posts.filter(post => {
      if (appState.filters.category !== 'all') {
        return post.category === appState.filters.category;
      }
      if (appState.filters.search) {
        return post.title.toLowerCase().includes(appState.filters.search.toLowerCase());
      }
      return true;
    });
  });

  let postStats = $derived(() => ({
    total: appState.posts.length,
    filtered: filteredPosts.length,
    categories: [...new Set(appState.posts.map(p => p.category))]
  }));

  // Advanced effect with cleanup
  $effect(() => {
    if (appState.ui.loading) {
      const timer = setTimeout(() => {
        appState.ui.error = 'Request timed out';
        appState.ui.loading = false;
      }, 5000);
      
      return () => clearTimeout(timer);
    }
  });

  // State persistence
  $effect(() => {
    if (browser) {
      localStorage.setItem('appState', JSON.stringify(appState));
    }
  });
</script>
```

## How to Fix
Expand modern-features rule to include:

1. **Complex State Patterns**
   - Nested reactive objects
   - State composition patterns
   - Immutable update patterns

2. **Advanced Derived State**
   - Multi-level derived dependencies
   - Memoization strategies
   - Performance considerations

3. **Effect Management**
   - Cleanup patterns
   - Effect chaining
   - Debugging effects

4. **Cross-Component Patterns**
   - State stores vs props
   - Context patterns
   - Universal state strategies

5. **Performance Optimization**
   - Lazy loading patterns
   - Debounced effects
   - Selective reactivity

## Impact
- Better preparation for complex applications
- Improved performance understanding
- More scalable state management patterns
- Enhanced developer experience for advanced use cases
