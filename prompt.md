add new skill `tapforce-monorepo-moon`

this skill is a guide set up monorepo project use moon as monorepo manager. Introduce this tool can be found at: https://moonrepo.dev/docs. You should mention this source link. This skill is guide for version 1 and 2 of moon.

use this skill when project mentions use monorepo, create new project, or when you see the project requirements is complex, with more than 1 application and need to split into multiple packages.

content of guide:

## check environment had Moon or not

You need check env of user has Moon installed or not. The checking steps following:

1. run command `pnpm moon --version`, if it show version with major number is 1 or 2, this is correct.
2. if [1] not show any version, try check moon at global scope by command : `moon --version`.

cases:
- if result not show version or say not found mean user not install Moon. You need install moon by nodejs package manager, always prefer use `pnpm` if available.
- if result show version with major not 1 or 2, then skip this skill since it is only guide for version 1 and 2 of moon.

After make sure Moon installed, check project really set up with moon structure or not. Check by:

check if root of project had folder `.moon` folder or not. If not found, assumption you will need init moon project. If found, assumption you will adapt current structure to continue using moon.

If moon installed at global scope, you need find `package.json` file at root of project and add script `moon` to simulate command call moon like local project.

`moon` -> `pnpm moon`

use command `pnpm moon <command>` to call moon command from now on.

## init moon project

To init moon project, use `pnpm moon init` command. Following steps:

1. run command `pnpm moon init`
2. validate and create if not found folders `apps` and `packages`. Consider `apps` folder is the place store applications. Consider `packages` folder is the place store packages.

## validate project structure

validate and setup toolchain. The guideline can found at: https://moonrepo.dev/docs/setup-toolchain.

## Reference sources:

- [workspace file](https://moonrepo.dev/docs/config/workspace)
- [extension file](https://moonrepo.dev/docs/config/extensions)
- [toolchain file](https://moonrepo.dev/docs/config/toolchain)
- [task file](https://moonrepo.dev/docs/config/tasks)
- [moon file (app|package scope)](https://moonrepo.dev/docs/config/project)

ATTENTION: don't try create all config file of Moon if not nessessary. You only create file as needed.  

## bias rules:

### each applications or packages should has own `moon.yml` file

Each applications or packages should has own `moon.yml` file. This file contains `tasks` object where define tasks. Tasks can forward `scripts` from `package.json` of current application or package to `moon.yml`.

### when project using pnpm, and find `pnpm-workspace.yaml` exist, you need consider link packages to applications as dependency.

When project using pnpm, and find `pnpm-workspace.yaml` exist, and when request say need import package A to application B, you need add package name into application B `package.json` as dependency use syntax:

```json
"dependencies": {
    "package-a": "workspace:*"
}
```

Keep in mind that always use `workspace:*` to link package to application.

Always run `pnpm install` and `pnpm moon setup` everytime change dependency of any application or package.