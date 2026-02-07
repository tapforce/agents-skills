add skill `tapforce-pnpm`

This skill give best practice for use pnpm ^10.0.0 on a Nodejs project.

Use skill when working with project that based on Nodejs.

## validate current env.

before start using pnpm, you need validate current env. 

1. check current package manager is pnpm or not.
2. check current nodejs version is supported by pnpm.
3. check current project is using pnpm or not.

Skill requires:

- project based on Nodejs ^20.0.0
- local env (machine, pc, mac) ready pnpm ^10.0.0

## use pnpm

To use pnpm you must use `pnpm` command consistency.

- on project strucutre, always check and make sure project has file `pnpm-workspace.yaml` at root. Content must include property `packages` with value is array of relative path to package directory. This file MUST available before run any command.

- all command use `pnpm` instead of `npm` or any other package manager. If you meet a command has prefix from a package manager different `pnpm`, auto replace with `pnpm`.


If you need create file `pnpm-workspace.yaml` you add `packages` property with value `.` as default. You must avoid create `packages` property in `package.json` because it not stable.

**default workspace.yaml**
```yaml
packages:
  - .
```