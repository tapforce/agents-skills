# Tapforce Agent Skills Agency Guide

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

## Best Practices Checklist

### Before Submitting a Skill:
- [ ] Name follows conventions (lowercase, hyphens, no consecutive hyphens)
- [ ] Description includes both what AND when to use
- [ ] All required frontmatter fields present
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

## Testing & Validation Process

### Playground Environment
We use the `playground/` folder as our testing environment for generating code that follows skill specifications. When testing skills:

1. **Generate Code**: Create test implementations in `playground/` following the skill's instructions
2. **Execute Tests**: Run the generated code to validate functionality
3. **Analyze Results**: Evaluate success and identify issues
4. **Document Findings**: Record comprehensive analysis

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

## Continuous Improvement

We regularly review and update our skills based on:
- User feedback and usage patterns
- Advances in AI capabilities
- Updates to the Agent Skills specification
- Emerging best practices and patterns

---

*This guide serves as our internal reference for developing high-quality Agent Skills that follow the specification and provide maximum value to AI agents and their users.*