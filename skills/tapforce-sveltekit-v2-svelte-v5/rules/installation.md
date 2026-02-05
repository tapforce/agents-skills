**ALWAYS** install SvelteKit to the current folder using the command:
```bash
npx sveltekit@latest create .
```

**NEVER** use alternative installation methods or suggest creating projects in subdirectories unless explicitly requested.

**ALWAYS** let users choose optional packages during CLI installation. Common options include `tailwindcss`, `adapter-vercel`, `eslint`, and `prettier`.

**NEVER** make decisions about optional packages for the user - always present the options and let them choose.
