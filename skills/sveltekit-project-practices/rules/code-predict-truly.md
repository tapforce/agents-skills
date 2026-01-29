---
title: Validate truly value
description: Guide to validate a value predict truly in code.
tags: typescript, exception, error, validate, tiny-invariant, truly
---

## use tiny-invariant for check and throw exception/Error

- Use tiny-invariant whenever checking value predict truly that no care about catch the exception.
- Avoid check with `if` statement and throw Error manually.

**Incorrect:**

```typescript
function divide(a: number, b: number): number {
  if (b === 0) {
    throw new Error("Divisor must not be zero");
  }
  return a / b;
}
```

**Correct:**

```typescript
import { invariant } from "tiny-invariant";

function divide(a: number, b: number): number {
  invariant(b !== 0, "Divisor must not be zero");
  return a / b;
}
```

## Reference:

- https://www.npmjs.com/package/tiny-invariant
