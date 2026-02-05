---
name: moon-configuration
description: Rule for ensuring each application/package has its own moon.yml file with tasks
tags: [moon, configuration, tasks]
---

**ALWAYS** ensure each application or package has its own `moon.yml` file containing a `tasks` object that defines available tasks. Tasks can forward `scripts` from the current application's `package.json` to the `moon.yml` configuration.
