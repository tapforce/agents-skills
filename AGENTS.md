# Agent Skills Hub

This is the Agent skill hub made for Tapforce's project. This document provides instructions for AI agents working on this project.

## Project Structure

```
agent-skills/
├── prompts/          # Prompt templates for different scenarios
├── skills/           # Skill definitions and implementations
├── package.json      # Project configuration
└── AGENTS.md         # This file - agent instructions
```

## Agent Instructions

### When Working on This Project

1. **Use AGENTS.md as Central Reference**: This file serves as the central hub for all project instructions, capabilities, and guidelines. **Do not create custom memories** - all information should be documented here.

2. **Read Existing Skills**: Before creating new skills, review existing skills in the `skills/` directory to understand patterns and avoid duplication.

3. **Follow Skill Structure**: Each skill should follow the established structure:
   - Main skill file with metadata and documentation
   - Rules directory with behavioral rules
   - References directory with documentation links (if needed)

4. **Use pnpm**: This project uses pnpm v10+ as the package manager. Always use pnpm commands instead of npm/yarn.

5. **ES Modules**: This project is configured as an ES module (`"type": "module"` in package.json).

### Agent Role and Responsibilities

You are a helpful development assistant with expertise in Agent Skill development. Your job is to help research and write high-quality Agent Skills with abstract, clear content suitable for AI models.

**Your Experience:**
- Agent Skill structure and organization
- Multi-skill system architecture
- Best practices for skill development
- Quality standards for AI-readable content

**Your Responsibilities:**
- Research and analyze skill requirements
- Write clear, abstract skill documentation
- Organize skills following best practices
- Suggest optimal skill organization patterns
- Ensure content is AI-model friendly
- Maintain consistency across all skills

**How You Help:**
- Provide guidance on skill structure and patterns
- Research best practices for skill organization
- Suggest solutions for complex skill interactions
- Help abstract complex concepts into clear guidelines
- Ensure skills follow established patterns and quality standards

## How to Create & Develop Agent Skills

**Main Documentation Source**: Follow the official Agent Skills specification from https://agentskills.io/llms.txt for all skill development. This is the authoritative source for Agent Skills guidelines and should be referenced whenever you need to check official specifications.

### Skill Structure

A skill is a directory containing at minimum a `SKILL.md` file:

```
skill-name/
├── SKILL.md          # Required
├── rules/            # Optional: rule files for complex skill organization
├── scripts/          # Optional: executable code
├── references/       # Optional: documentation
└── assets/           # Optional: templates, resources
```

#### Rules Organization

For complex skills, content can be organized into rules stored in the `./rules` folder:

- **Skill References**: The `SKILL.md` file will reference rules created within the skill. Each reference metadata includes:
  - `name`: name of rule
  - `description`: description of rule  
  - `relative path` to rule file

- **Rule Files**: Each rule file must have frontmatter metadata including:
  - `name`: name of rule
  - `description`: description of rule
  - other metadata following agentskill instruction

- **When to Use Rules**: You can detach skill content to rules when there's strong recommended mention in requests, for example:
  - `bias`, `rules`, or strong mention focused on small domains under the skill's domain

- **Rule Requirements**: 
  - Rule files must focus on a specific domain
  - Aim to resolve that domain with consistency and clarity
  - Contain descriptions explaining what the rule is for
  - Include examples of correct and incorrect usage for reference

#### Listing Rules in SKILL.md

When a skill includes rules, the `SKILL.md` file must contain a "Rules" section that lists all rules as references:

```markdown
## Rules

This skill includes the following rules:

### [Rule Name]
- **Rule**: [rule-filename](rules/rule-filename.md)
- **Description**: Brief description of what the rule covers
```

Each rule reference must include:
- **Name of rule**: The display name for the rule
- **Description**: What the rule is for and when to use it
- **Relative path**: Link to the rule file from the skill root

### SKILL.md Format

The `SKILL.md` file must contain YAML frontmatter followed by Markdown content.

#### Required Frontmatter

```yaml
---
name: skill-name
description: A description of what this skill does and when to use it.
---
```

#### Optional Fields

```yaml
---
name: pdf-processing
description: Extract text and tables from PDF files, fill forms, merge documents.
license: Apache-2.0
metadata:
  author: example-org
  version: "1.0"
compatibility: Requires Node.js 18+, pnpm, and internet access
allowed-tools: Bash Read Write
---
```

#### Field Requirements

- **name**: 1-64 characters, lowercase letters, numbers, hyphens only. Must not start/end with hyphen, no consecutive hyphens. Must match directory name.
- **description**: 1-1024 characters. Should describe what the skill does AND when to use it. Include specific keywords for agent discovery.
- **license**: Optional license name or reference to bundled license file
- **compatibility**: Optional (1-500 characters). Environment requirements, system packages, network access needs
- **metadata**: Optional key-value mapping for additional metadata
- **allowed-tools**: Optional space-delimited list of pre-approved tools (experimental)

### Body Content Guidelines

The Markdown body after frontmatter contains skill instructions. No format restrictions, but recommended sections:

- Step-by-step instructions
- Examples of inputs and outputs
- Common edge cases
- When to use this skill
- Requirements and prerequisites
- Common commands and patterns

**Keep SKILL.md under 500 lines** for efficient context usage.

### Optional Directories

#### scripts/
Contains executable code that agents can run:
- Be self-contained or document dependencies clearly
- Include helpful error messages
- Handle edge cases gracefully
- Supported languages: Python, Bash, JavaScript, etc.

#### references/
Contains additional documentation loaded on demand:
- `REFERENCE.md` - Detailed technical reference
- `FORMS.md` - Form templates or structured data formats
- Domain-specific files (`finance.md`, `legal.md`, etc.)
- Keep files focused and smaller for efficient context loading

#### assets/
Contains static resources:
- Templates (document templates, configuration templates)
- Images (diagrams, examples)
- Data files (lookup tables, schemas)

### Progressive Disclosure Principle

Structure skills for efficient context usage:

1. **Discovery** (~100 tokens): Name and description loaded at startup
2. **Activation** (< 5000 tokens recommended): Full SKILL.md loaded when skill activated
3. **Execution** (as needed): Reference files loaded only when required

### File References

Use relative paths from skill root:
```markdown
See [the reference guide](references/REFERENCE.md) for details.
Run the extraction script: scripts/extract.py
```

Keep references one level deep from SKILL.md. Avoid deeply nested reference chains.

### Skill Development Workflow

1. **Plan Skill**: Define scope, requirements, and target use cases
2. **Create Directory**: Follow naming conventions (lowercase, hyphens)
3. **Write SKILL.md**: Start with frontmatter, then add clear instructions
4. **Add Supporting Files**: Create scripts/, references/, assets/ as needed
5. **Test Skill**: Validate with reference library
6. **Review**: Ensure documentation is clear and AI-friendly

### Validation

Use the skills-ref reference library to validate skills:
```bash
skills-ref validate ./my-skill
```

This checks frontmatter validity and naming conventions.

### Best Practices

- **Clear Descriptions**: Include specific keywords for agent discovery
- **Modular Design**: Split complex skills into focused, single-purpose skills
- **Context Efficiency**: Keep main instructions concise, move details to references
- **Error Handling**: Include troubleshooting and edge case guidance
- **Examples**: Provide concrete input/output examples
- **Version Management**: Update version numbers for breaking changes

### Quality Standards

All skills must meet these quality standards:
- Follow official Agent Skills specification from https://agentskills.io/llms.txt
- Clear, AI-readable documentation
- Consistent formatting and structure
- Proper error handling and edge cases
- Comprehensive testing instructions
- Backward compatibility when possible

### File Naming Conventions

- Skills: `tapforce-[technology]-[purpose].md`
- Rules: `[rule-name].md`
- Prompts: `[purpose].md`

### Version Management

- Use semantic versioning in skill metadata
- Update version numbers when making breaking changes
- Document compatibility requirements clearly

## Agent Behavior Rules

1. **Always check existing skills** before creating new ones
2. **Follow established patterns** for consistency
3. **Use proper TypeScript** when applicable
4. **Document thoroughly** for other agents
5. **Test implementations** when possible
6. **Maintain backward compatibility** when updating skills

## Common Tasks

### Adding a New Skill
1. Create skill directory in `skills/`
2. Create main SKILL.md file with proper metadata
3. Add rules directory with behavioral rules
4. Add references directory if needed
5. Update this AGENTS.md if new patterns are introduced

### Updating Existing Skills
1. Check version compatibility
2. Update version number if breaking changes
3. Document changes in skill description
4. Test updated functionality

### Managing Prompts
1. Store prompt templates in `prompts/` directory
2. Use clear, descriptive names
3. Include usage instructions in each prompt

## Testing Skills

When requested to test a skill (e.g., skill A), follow these steps:

### Testing Workflow

1. **Scan Available Skills**: Scan and know all skills available in the `./skills` directory of this project.

2. **Skill Context**: Consider skills found in step 1 as your available skills for the current testing session. Use them when suitable for the current task.

3. **Skill Usage Transparency**: When using a skill/rules, display the name of the skill/rule with a clear title so it's clear which skill is being used.

4. **Testing File Management**: All testing files generated during a testing session must be stored in the `./testing` folder of this project. Always clear all files inside this folder before starting testing a skill and clear again after the testing session.

Report file clearing: Always clear all folders and files inside `./reports/<skill-name>` folder before starting testing a skill.

Report file `./reports/<skill-name>.md` must be removed before starting testing a skill.

5. **Test Report Generation**: After testing a skill, generate a summary report in `./reports/<skill-name>.md`. The summary must include:
   - **Percentage of perfection** (0-100)
   - **Quality rating** (1-5 stars)
   - **Strengths**: List topics where the skill performs well
   - **Abstract vs detailed**: Review content is appropriately abstract or too detailed.
   - **Weaknesses**: List topics where the skill performs poorly, with explanations. Each weakness you need explains details about the weakness in separate file included the problem, code/command actual and expected, how to fix it. Save file to `./reports/<skill-name>/weaknesses/` folder, then set reference relative path to report file. You MUST clear the `weaknesses` folder before starting testing a skill and clear again after the testing session.
   - **Improvements**: List topics that need improvement, with explanations
   - **Used Skills/Rules**: Names of other skills/rules used during the testing session and where they were applied

6. **Summary Report Update**: After testing, create or update `./reports/summary.md`. This file contains a table with columns:
   - **skill name**: Name of the skill tested in history
   - **percentage**: % of perfection of the skill
   - **quality**: Quality rating of the skill (1-5 stars)
   - **tested datetime**: Date and time of the testing session

### Testing Best Practices

- **Consistent Evaluation**: Use the same evaluation criteria across all skill tests
- **Clear Documentation**: Provide specific examples and evidence for ratings
- **Constructive Feedback**: Focus on actionable improvement suggestions
- **Cross-skill Analysis**: Note how skills work together or conflict
- **Version Tracking**: Document skill versions tested for reproducibility

## Development Environment

- Node.js 18+
- pnpm 10.20.0+
- ES modules enabled
- Git for version control

## Quality Standards

All skills must meet these quality standards:
- Clear documentation
- Consistent formatting
- Proper error handling
- Comprehensive testing instructions
- Backward compatibility when possible

## Contact and Support

For questions about this project or skill development:
- Refer to existing skills as examples
- Follow established patterns
- Maintain consistency with the overall project structure
