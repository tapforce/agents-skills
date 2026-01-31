---
name: hello-world
description: A sample skill that says hello.
---

# Hello World

This is a sample skill that demonstrates the directory structure of an Agent Skill.

## Usage

You can run the hello script:

```bash
node scripts/greet.js [name]
```

## References

See [API Reference](references/api.md) for more details.
We also have TypeScript definitions in [references/types.ts](references/types.ts).

## Assets

- Template: [assets/template.txt](assets/template.txt)
- Styles: [assets/styles.css](assets/styles.css)

---
#!/usr/bin/env node

const args = process.argv.slice(2);
const name = args[0] || 'World';

console.log(`Hello, ${name}!`);
console.log('This is a JavaScript script example.');

---
/**
 * Example TypeScript Definition
 */

export interface Greeting {
  message: string;
  recipient: string;
  timestamp: Date;
}

export interface SkillConfig {
  name: string;
  enabled: boolean;
  maxRetries?: number;
}

---
# Hello World API Reference

## Commands

### `hello`

Prints a hello message.

**Arguments:**

- `name` (optional): The name to greet. Defaults to "World".

**Example:**

```bash
python3 scripts/hello.py Alice
```

---
Hello, {{name}}!
Welcome to the {{project}} project.

---
/* Example CSS Asset */
.greeting {
  color: #333;
  font-family: 'Arial', sans-serif;
  padding: 1rem;
  background-color: #f4f4f4;
  border-radius: 4px;
}

.greeting-name {
  font-weight: bold;
  color: #007bff;
}

