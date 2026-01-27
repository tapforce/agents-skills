# Agent Skills Workspace

This repository contains tools and source code for developing "Agent Skills" - modular capabilities that can be consumed by AI agents.

## Project Structure

- **`skills/`**: The source directory containing skill definitions. Each skill is a directory with a `SKILL.md` and other resources.
- **`builder/`**: A CLI tool used to validate skills and "build" them (packaging `SKILL.md` and other files into a single `AGENTS.md` distribution).
- **`web/`**: A SvelteKit web application for viewing and previewing the available skills.

## Getting Started

1.  **Install Dependencies**:
    ```bash
    pnpm install
    ```

2.  **Setup Moon (Optional but Recommended)**:
    This project uses [Moon](https://moonrepo.dev/) for task management.
    ```bash
    npm install -g @moonrepo/cli
    ```

## Commands

### Builder

The builder tool processes the raw skills in `skills/` and outputs them to `dist/skills/`.

*   **Build the Builder Tool**:
    Bundles the TypeScript source using `tsup` for distribution (ESM & CJS).
    ```bash
    moon run builder:build
    # or
    cd builder && pnpm build
    ```

*   **Run Builder (Generate Skills)**:
    Runs the builder directly from source (using `tsx`) to generate `AGENTS.md` for all skills. **No build step required.**
    ```bash
    moon run builder:start
    # or
    cd builder && pnpm start
    ```

*   **Validate Skills**:
    Checks if skills have the required `SKILL.md` and frontmatter. Runs directly from source.
    ```bash
    moon run builder:validate
    # or
    cd builder && pnpm validate
    ```

### Web Interface

The web application allows you to browse the skills.

*   **Start Development Server**:
    ```bash
    moon run web:dev
    # or
    cd web && pnpm dev
    ```
    Open http://localhost:5173 to view the app.

*   **Build Web App**:
    ```bash
    moon run web:build
    # or
    cd web && pnpm build
    ```

## Creating a New Skill

1.  Create a new directory in `skills/<your-skill-name>`.
2.  Create a `SKILL.md` file with the required frontmatter:
    ```markdown
    ---
    name: your-skill-name
    description: A brief description of what this skill does.
    ---
    
    # Your Skill Documentation
    ...
    ```
3.  Add any supporting files (scripts, assets) in the directory.
4.  Run validation: `moon run builder:validate`
5.  Build the skill: `moon run builder:start`
