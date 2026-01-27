---
title: Prepare Nodejs
description: Checking and suggest install Nodejs version match required version for project.
tags: environment, tools, nodejs
---

## Check Nodejs version

Nodejs version must be 20 or higher. Using command `node -v` to check current version.

```bash
node -v
```

Result must response with version 20 or higher.

**Incorrect:**

```bash
v18.16.0
```

**Correct:**

```bash
v20.10.0
```

When current version < 20 then show message suggest install Nodejs version 20 or higher.

Example: `Nodejs version must be 20 or higher. Please install Nodejs version 20 or higher.`

Reference [Nodejs official download page](https://nodejs.org/en/download)
Suggest user choose correct computer architecture.
