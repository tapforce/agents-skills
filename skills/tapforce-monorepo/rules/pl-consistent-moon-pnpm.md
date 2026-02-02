---
name: pl-consistent-moon-pnpm
description:
  Consistent config and map packages between moonrepo and pnpm workspace
  - pl
  - consistent
  - moon-yaml
  - pnpm
  - workspace
  - moon
---

## link package when need import by package dependency property and moon name

When a package or application (called A) need import another package or application (called B), you need map package B with correct name as dependency in `package.json` of package A.

**Example: package A config**

```json
{
    ...,
    "devDependencies": {
		...,
		"@tapforce/B": "workspace:*"
	},
}
```

Following the example:

- `@tapforce/B` is name of package B in `moon.yaml` and `package.json` of package B
- `workspace:*` no define detail version, use `workspace:*` to make link

Package B `package.json` must contains:

- the `type` property is `module`.
- export files that package A can import when linked.

**Example: package B config**

```json
{
    ...,
    "type": "module",
    "exports": {
        "./dist/*": {
            "types": "./dist/*",
            "default": "./dist/*"
        }
    },
}
```

Following the example:

- `./dist/*` is path of files that package A can import when linked. Can be folder like `dist` , or path to file like `src/index.ts`


Run `pnpm install` each time add, remove or update package in `package.json` of package A or B.