# Tapforce Agent Skills Agency Guide

## 🚨 CRITICAL TESTING WORKFLOW (MANDATORY)

**After testing ANY skill, you MUST complete these steps:**

1. **Test in Playground**: Follow skill instructions in `./playground/` directory
2. **Update Test Report**: Add/update skill row in `./test-report.md` 
3. **Create Individual Report**: Write `<skill-name>_test.md` in `./test-summary/` directory with detailed analysis
4. **Clean Playground**: Run `rm -rf playground/*` after testing

**NO EXCEPTIONS** - This workflow is mandatory for every skill test.

---

## Our Mission

We are a helpful agent-skills agency dedicated to developing high-quality Agent Skills for AI models. Our expertise is based on the [Agent Skills specification](https://agentskills.io) from agentskills.io. We create skills that extend AI agent capabilities with specialized knowledge and workflows.

## Agent Skills Overview

Agent Skills are a lightweight, open format for extending AI agent capabilities. Each skill consists of:

- **SKILL.md file**: Required file with metadata and instructions
- **Optional directories**: scripts/, references/, assets/ for supporting resources

### Core Principles

1. **Progressive Disclosure**: Agents load only metadata initially, then full instructions when relevant
2. **Self-Documenting**: Skills should be readable and understandable by humans
3. **Portable**: Skills are just files - easy to edit, version, and share
4. **Extensible**: Can range from simple instructions to complex executable workflows

## Agent Skills Design Guidelines

### 1. Skill Naming Convention

#### 1.1 Core Principles

- Skill name must be **globally unique by convention**, not by enforcement
- Always assume users may install skills from many sources
- Name is a **technical identifier**, not marketing text

#### 1.2 Required Pattern

Always prefix skill names with an organization or namespace:

<org>-<domain>-<scope-or-version>

Examples:
- acme-tailwindcss-v4
- acme-sveltekit-svelte5
- acme-nodejs-pnpm
- acme-auth-firebase

Rules:
- Use kebab-case
- Avoid generic names like `tailwind`, `auth`, `ui` 
- Include major version in the name if behavior depends on it
- Prefer clarity over brevity

#### 1.3 Versioning Rule

- If a skill is tied to a specific major version, version MUST be part of the name
- Do not rely on description text to convey version constraints

Correct:
- acme-tailwindcss-v4

Incorrect:
- acme-tailwindcss (with version hidden in text)

### 2. What a Skill Represents

- One skill represents **one clear domain of knowledge or workflow**
- A skill is not a full product tutorial
- A skill should be reusable across prompts and workflows

Good examples:
- TailwindCSS setup and usage
- Firebase authentication concepts
- SvelteKit core architecture

Bad examples:
- "Full web development guide"
- Mixed UI + backend + infra in one skill

### 3. When to Create One Skill vs Multiple Skills

#### Use ONE skill when:
- Topics share the same core intent
- They are always used together
- They represent different aspects of the same domain

Example:
- TailwindCSS setup
- Tailwind usage practices
- Tailwind color customization  
→ One TailwindCSS skill

#### Split into MULTIPLE skills when:
- Topics have different intents
- One topic can be reused independently
- One topic is framework-agnostic and another is not

Example:
- firebase-auth-core
- firebase-auth-sveltekit

### 4. Using `rules/` Inside a Skill

#### 4.1 What Rules Are

- Rules are **high-priority instructions**, not executable logic
- Rules bias agent behavior but do not guarantee enforcement
- Rules are always interpreted as text by the LLM

Rules are suitable for:
- Best practices
- Constraints
- Safety or security guidance
- Strong preferences (always / never)

#### 4.2 When to Use `rules/` 

Use a `rules/` directory when:
- The skill has non-negotiable practices
- The rules apply across all usages of the skill
- You want to separate behavior constraints from workflow steps

Example structure:
skill/
├─ skill.md
└─ rules/
└─ practices.md

#### 4.3 Rule Creation Guidelines

When creating rules inside a skill:

**Focus on Single Issues**: Each rule should address **one specific issue** or behavior bias. Avoid grouping multiple unrelated issues in a single rule.

**Separate Rule Files**: Keep each rule category in its own file within the `rules/` directory. This maintains focus and makes rules easier to manage and apply selectively.

**Meaningful Content**: Rules should contain focused, meaningful content that clearly biases agent behavior toward a specific practice or constraint.

**Rule Structure**:
- **ALWAYS/NEVER**: Use strong directive language for clear behavioral guidance
- **Single Focus**: Each rule targets one specific aspect (e.g., color format, file location, syntax pattern)
- **Actionable**: Rules should directly influence agent decisions and actions
- **MANDATORY Frontmatter**: Every rule file MUST include YAML frontmatter with:
  ```yaml
  ---
  name: rule-name
  description: Clear description of what this rule governs
  tags: [tag1, tag2]
  ---
  ```

**Examples of Focused Rules**:
- ✅ **ALWAYS** use `oklch()` color values instead of legacy RGB/HSL
- ✅ **NEVER** create a separate config file for TailwindCSS v4
- ✅ **ALWAYS** place `!` AFTER the class name in v4 syntax

**Avoid Multi-Issue Rules**:
- ❌ **ALWAYS** use oklch colors, avoid config files, and place ! after classes
- ❌ **NEVER** mix v3/v4 patterns, write inline CSS, or use generic names

**Rule File Organization**:
- Create separate files for each rule category (e.g., `color-format.md`, `configuration.md`)
- Use descriptive filenames that clearly indicate the rule's focus
- Keep rule files concise and focused on their specific domain

#### 4.5 Avoiding Duplication Between Skills and Rules

**CRITICAL**: Never duplicate rule content between the main SKILL.md file and individual rule files.

**Best Practice**:
- **SKILL.md**: Should only reference or summarize rules, not duplicate their full content
- **Rule files**: Contain the complete, detailed rule content with proper frontmatter
- **Reference approach**: In SKILL.md, provide brief descriptions and point to the rule files

**Example of Proper Reference**:
```markdown
## Rules

This skill includes the following behavioral rules in the `rules/` directory:

### Component Preference
- **Rule**: Always prefer shadcn-svelte built-in components over custom implementations
- **File**: `rules/component-preference.md`
- **Details**: Reference https://www.shadcn-svelte.com/docs/components before creating custom components

### Custom Styling
- **Rule**: Follow TailwindCSS v4 and shadcn-svelte theming guidelines
- **File**: `rules/custom-styling.md`
- **Details**: Use CSS Variables for theming, respect v4 features
```

**MANDATORY Requirements for Rule References**:
- **ALWAYS** include the relative file path using `- **File**: `rules/rule-name.md`` format
- **NEVER** reference rules without providing the file path
- **ALWAYS** use relative paths from the skill root directory
- **ENSURE** file paths exactly match the actual rule file names

**What to Avoid**:
- ❌ Copying full rule text from rule files into SKILL.md
- ❌ Repeating rule content in multiple places
- ❌ Having conflicting instructions between SKILL.md and rule files

**Benefits**:
- Single source of truth for each rule
- Easier maintenance and updates
- Reduced cognitive load for agents
- Clear separation of concerns

#### 4.6 When NOT to Use `rules/` 

Do NOT use rules when:
- Content is tutorial flow
- Content is explanatory or reference material
- Rules repeat system prompt or global policy
- Rules are too generic to matter

Avoid:
- Overusing rules
- Creating rule files for every small preference
- Encoding pseudo-code or complex conditionals

### 5. How Agents Use Skills and Rules

- Agents load skill metadata first (name, description, use_when)
- Skill body is loaded only when selected
- Rules are applied as behavioral bias, not as code
- Multiple skills can be loaded in the same workflow if relevant

### 6. Best Practices Summary

- Namespace every skill
- Keep one skill = one domain
- Use bridge/orchestration skills for end-to-end workflows
- Use rules sparingly and intentionally
- Optimize for agent selection, not human storytelling

### 7. Design Goal

Design skills so that:
- Agents can confidently select them
- Skills can coexist with third-party skills
- Skills remain stable and reusable over time

---

## Skill Structure Requirements

### Directory Structure
```
skill-name/
├── SKILL.md          # Required
├── scripts/          # Optional: executable code
├── references/       # Optional: documentation
└── assets/           # Optional: templates, resources
```

### SKILL.md Format

#### Required Frontmatter
```yaml
---
name: skill-name
description: A description of what this skill does and when to use it.
---
```

#### Optional Frontmatter Fields
```yaml
---
name: skill-name
description: What this skill does and when to use it
license: Apache-2.0
compatibility: Requires specific environment
metadata:
  author: tapforce
  version: "1.0"
allowed-tools: Bash Read Write
---
```

#### Field Constraints
- **name**: 1-64 chars, lowercase letters, numbers, hyphens only
- **description**: 1-1024 chars, must describe what skill does AND when to use it
- **license**: Optional license name or reference
- **compatibility**: Optional environment requirements (max 500 chars)
- **metadata**: Optional key-value mapping for additional properties
- **allowed-tools**: Optional space-delimited list of pre-approved tools

## Our Development Process

### 1. Skill Discovery & Planning
- Identify specific use cases and user needs
- Research existing solutions and best practices
- Define clear scope and boundaries for the skill

### 2. Skill Authoring
- Write clear, step-by-step instructions
- Include examples of inputs and outputs
- Document common edge cases and error handling
- Follow progressive disclosure principles
- **ALWAYS create skills in `./skills/` directory**

### 3. Quality Assurance
- Validate skill structure against specification
- Test instructions with actual AI agents
- Review for clarity, consistency, and completeness
- Ensure proper naming conventions and metadata

### 4. Documentation & Examples
- Provide comprehensive usage examples
- Include troubleshooting guidance
- Document any prerequisites or dependencies

## Skill Evaluation Criteria

When evaluating skills, we assess:

### Understanding & Clarity
- **✅ Good**: Instructions are clear, specific, and actionable
- **❌ Poor**: Vague, ambiguous, or incomplete guidance
- **✅ Good**: Examples demonstrate expected inputs/outputs
- **❌ Poor**: No examples or unclear examples

### Consistency & Standards
- **✅ Good**: Follows Agent Skills specification exactly
- **❌ Poor**: Deviates from required format or naming conventions
- **✅ Good**: Consistent terminology and structure throughout
- **❌ Poor**: Inconsistent language or formatting

### Practical Utility
- **✅ Good**: Solves real, specific problems effectively
- **❌ Poor**: Too generic or doesn't address clear use case
- **✅ Good**: Includes edge cases and error handling
- **❌ Poor**: Only covers happy path scenarios

### Integration Readiness
- **✅ Good**: Proper frontmatter with all required fields
- **❌ Poor**: Missing or incorrect metadata
- **✅ Good**: Reasonable context size for agent loading
- **❌ Poor**: Excessively long or inefficient content
- **✅ Good**: Follows exact directory structure requirements
- **❌ Poor**: Creates unauthorized directories or deviates from spec

## Improvement Guidelines

### Making Skills Better
1. **Add Specific Examples**: Show exactly what inputs look like and what outputs to expect
2. **Include Edge Cases**: Document what happens with invalid inputs or error conditions
3. **Optimize Context**: Split long content into referenced files when appropriate
4. **Enhance Discovery**: Use descriptive names and keyword-rich descriptions
5. **Test Thoroughly**: Validate skills work with actual agent implementations

### Common Issues to Fix
- Vague descriptions that don't indicate when to use the skill
- Missing required frontmatter fields
- Overly long instructions that should be split
- Lack of examples or troubleshooting guidance
- Inconsistent formatting or terminology

## Our Current Skills

This section will be populated as we develop skills for the Tapforce ecosystem.

### Skill Categories We Focus On
- **Development Tools**: Code generation, debugging, testing workflows
- **Data Processing**: Analysis, transformation, visualization tasks  
- **Documentation**: Generation, maintenance, formatting workflows
- **Integration**: API connections, system interactions
- **Automation**: Repetitive task automation and workflow orchestration

## Skill Creation Process

### Mandatory Directory Structure
```
skills/
├── skill-name/
│   └── SKILL.md
```

### When Creating New Skills
- **ALWAYS use `./skills/` directory**
- Never create skills in repository root
- Follow naming conventions: lowercase, hyphens only
- Include required frontmatter fields
- **ALWAYS follow exact Agent Skills directory structure**
- Test skills in `playground/` directory

**MANDATORY**: Always respect the Agent Skills specification directory structure:
```
skill-name/
├── SKILL.md          # Required
├── scripts/          # Optional: executable code
├── references/       # Optional: documentation
└── assets/           # Optional: templates, resources
```

## Best Practices Checklist

### Before Creating a Skill:
- [ ] **ALWAYS use `./skills/` directory**
- [ ] Name follows conventions (lowercase, hyphens, no consecutive hyphens)
- [ ] Description includes both what AND when to use
- [ ] All required frontmatter fields present
- [ ] **ALWAYS follow exact Agent Skills directory structure**
- [ ] Instructions are step-by-step and actionable
- [ ] Examples provided for key operations
- [ ] Edge cases documented
- [ ] Skill validates against specification
- [ ] Context size is reasonable for agent loading

### After Development:
- [ ] Test with actual AI agent
- [ ] Review for clarity and completeness
- [ ] Validate file structure
- [ ] Check for consistency with other skills
- [ ] Document any prerequisites

## 🧪 SKILL TESTING WORKFLOW (MANDATORY)

### Step 1: Playground Testing
```bash
# MANDATORY: Clear playground first
rm -rf playground/*
# Follow skill instructions in playground/
# Create real test implementations
# Execute and validate functionality
```

### Step 2: Update Test Report Table
- Edit `./test-report.md`
- Add/update row with:
  - skill name
  - percentage of understanding (0-100%)
  - can production? (Yes/No/Partial)

### Step 3: Create Individual Test Report
- Create file `<skill-name>_test.md` in `./test-summary/` directory
- Include:
  - Understanding percentage and rationale
  - Clear parts analysis
  - Unclear parts with specific examples
  - Suggestions for improvement
  - Production readiness assessment

**MANDATORY: All test summary files MUST be placed in `./test-summary/` folder - NO EXCEPTIONS**

### Step 4: Clean Up
```bash
rm -rf playground/*
```

**THIS ENTIRE WORKFLOW IS MANDATORY - NO EXCEPTIONS**

---

## Testing & Validation Process

### Playground Environment
We use the `playground/` folder as our **MANDATORY** testing environment for generating code that follows skill specifications. When testing skills:

1. **Generate Code**: **MUST create test implementations in `playground/`** following the skill's instructions
2. **Execute Tests**: Run the generated code to validate functionality
3. **Analyze Results**: Evaluate success and identify issues
4. **Document Findings**: Record comprehensive analysis

**IMPORTANT**: The `playground/` directory is git-ignored, making it safe for temporary test files. **ALL test files MUST be placed here** - no exceptions.

### Git Ignore Access Policy
When encountering issues accessing files that are blocked by git ignore rules:

1. **STOP IMMEDIATELY** - Do not proceed with the operation
2. **REQUEST USER PERMISSION** - Ask the user to explicitly allow access to git-ignored files
3. **FOLLOW IDE-SPECIFIC PROCESS** - The exact option may vary depending on your IDE tools:
   - VS Code: Look for "Allow" or "Trust" prompts in the status bar
   - Cursor: Check for permission dialogs or status bar notifications
   - Other IDEs: Look for similar permission requests in the UI
4. **WAIT FOR CONFIRMATION** - Only proceed after the user has granted explicit access

**NEVER bypass git ignore restrictions without user consent. This protects both the repository integrity and user privacy.**

### Testing Workflow for Skills

#### Step 1: Environment Setup
```bash
# **MANDATORY: Always clear playground before testing**
rm -rf playground/*
mkdir -p playground/tests
cd playground
```

#### Step 2: Test Implementation
- **MUST create test files in `playground/` directory** - no exceptions
- Create test files that validate skill requirements
- Test all core functionality and edge cases
- Verify compliance with Agent Skills specification
- **NEVER create test files in repository root or other locations**

#### Step 3: Post-Test Documentation (MANDATORY)
After testing any skill (single or multiple), you **MUST**:

1. **Update Test Report Table**: 
   - Find the skill row in `./test-report.md` table
   - Update existing row or add new row with:
     - skill name
     - percentage of understanding (0-100%)
     - can production? (Yes/No/Partial)

2. **Create Individual Test Report**:
   - Create new file named `<skill-name>_test.md` in the `./test-summary/` directory
   - Include comprehensive analysis:
     - Understanding percentage and scoring rationale
     - How you understood the skill's purpose and functionality
     - Parts that need improvement with specific examples
     - Parts that were unclear or confusing
     - Suggestions for making the skill better
     - Any assumptions made during testing

**MANDATORY: All test summary files MUST be placed in `./test-summary/` folder - NO EXCEPTIONS**

3. **Clean Up Playground**:
   - **MANDATORY: Run `pnpm clean:playground` from project root after finishing all tests**
   - This ensures the playground folder is properly cleared for future use

#### Critical Requirements
- **MANDATORY: All test files MUST be placed in `./playground/` folder**
- **MANDATORY: ALWAYS clear the `playground` folder before doing a test** using `rm -rf playground/*`
- **MANDATORY: Update test-report.md table after each test**
- **MANDATORY: Create individual test report file for each skill tested**
- **MANDATORY: Run `pnpm clean:playground` from project root after finishing all tests**
- **NEVER create test files in repository root** - they may be accidentally committed
- **ALWAYS use `playground/` directory** - it's git-ignored and safe for temporary files
- **NO EXCEPTIONS** - this rule applies regardless of file type or test complexity
- **Clean up test files** after validation to maintain organized workspace
- **System temp directories** (`/tmp/`) can be used for complex tests requiring isolation

### Skill Assessment Framework

After each test, we provide a detailed analysis including:

#### Understanding Score (0-100%)
- **90-100%**: Complete understanding, clear instructions, no ambiguity
- **70-89%**: Good understanding with minor clarifications needed
- **50-69%**: Moderate understanding, some unclear or conflicting instructions
- **30-49%**: Limited understanding, significant ambiguity or missing details
- **0-29%**: Poor understanding, instructions unclear or incomplete

#### Clarity Analysis
**Clear Parts**:
- Well-defined steps and procedures
- Specific examples and expected outputs
- Comprehensive edge case handling
- Proper error handling guidance

**Unclear Parts**:
- Ambiguous terminology or phrasing
- Missing implementation details
- Inconsistent instructions
- Unclear prerequisites or dependencies

#### Hallucination Detection
**Potential Hallucinations**:
- Assumptions not supported by skill text
- Invented details or procedures
- Misinterpreted requirements
- Over-specified implementations

**Validation Methods**:
- Cross-reference with skill specification
- Verify against Agent Skills standards
- Check for consistency with examples
- Validate against stated objectives

## Tools & Resources

### Validation Tools
- [skills-ref](https://github.com/agentskills/agentskills/tree/main/skills-ref): Reference library for validation and prompt generation
- Agent Skills specification: https://agentskills.io/specification.md

### Reference Implementations
- Example skills: https://github.com/anthropics/skills
- Best practices: https://platform.claude.com/docs/en/agents-and-tools/agent-skills/best-practices

## Memory Management Guidelines

### Skill-Related Tasks
When working on Agent Skills tasks requested by the user:

- **❌ Do NOT auto-create memories** for skill development, testing, or validation activities
- **❌ Do NOT create memories** for skill analysis, evaluation, or assessment processes
- **❌ Do NOT store memories** about individual skill implementations or test results
- **✅ Focus on direct execution** of skill-related tasks without persistent storage
- **✅ Provide immediate feedback** and results without creating memory entries

### Rationale
Skill development work is typically iterative and experimental. Creating memories for each task can:
- Create unnecessary noise in the memory system
- Lead to outdated or conflicting information
- Reduce efficiency for future skill-related work
- Complicate the memory landscape with transient development details

### Exception Cases
Only create memories for skill work when:
- User explicitly requests to remember specific skill information
- Establishing permanent skill development patterns or standards
- Documenting major architectural decisions or frameworks
- User triggers memory creation with explicit intent

## Test Result Tracking

### Result Documentation
We maintain a comprehensive test result tracking system in `./test-report.md`. This file contains a table with the following columns:

- **skill name**: Name of the tested skill
- **percentage of understanding**: Understanding score (0-100%) based on clarity and completeness
- **can production?**: Production readiness assessment (Yes/No/Partial)

### Testing Workflow
1. **Test Skills**: Evaluate skills using the assessment framework
2. **Document Results**: Add or update rows in the test result table
3. **Track Progress**: Monitor improvement over multiple testing iterations
4. **Production Decisions**: Use results to determine production readiness

### Result Table Format
```markdown
| skill name | percentage of understanding | can production? |
|------------|----------------------------|-----------------|
| example-skill | 85% | Yes |
| another-skill | 72% | Partial |
```

## Continuous Improvement

We regularly review and update our skills based on:
- User feedback and usage patterns
- Advances in AI capabilities
- Updates to the Agent Skills specification
- Emerging best practices and patterns
- Test result analysis and production readiness assessments

---

*This guide serves as our internal reference for developing high-quality Agent Skills that follow the specification and provide maximum value to AI agents and their users.*