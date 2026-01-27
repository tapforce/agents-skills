import * as fs from 'fs';
import * as path from 'path';
import { glob } from 'glob';
import matter from 'gray-matter';

const SKILLS_DIR = path.resolve(__dirname, '../../skills');
const DIST_DIR = path.resolve(__dirname, '../../dist/skills');

interface SkillConfig {
    name: string;
    description: string;
    [key: string]: any;
}

function ensureDir(dir: string) {
    if (!fs.existsSync(dir)) {
        fs.mkdirSync(dir, { recursive: true });
    }
}

function validateSkill(skillDir: string): boolean {
    const skillName = path.basename(skillDir);
    const skillFile = path.join(skillDir, 'SKILL.md');

    if (!fs.existsSync(skillFile)) {
        console.error(`[${skillName}] Missing SKILL.md`);
        return false;
    }

    const content = fs.readFileSync(skillFile, 'utf8');
    const { data } = matter(content);

    if (!data.name) {
        console.error(`[${skillName}] SKILL.md missing 'name' in frontmatter`);
        return false;
    }

    if (!data.description) {
        console.error(`[${skillName}] SKILL.md missing 'description' in frontmatter`);
        return false;
    }

    if (data.name !== skillName) {
        console.warn(`[${skillName}] Warning: name in SKILL.md (${data.name}) does not match directory name (${skillName})`);
    }

    console.log(`[${skillName}] Validated successfully`);
    return true;
}

async function buildSkill(skillDir: string) {
    const skillName = path.basename(skillDir);
    console.log(`Building skill: ${skillName}`);

    const outputDir = path.join(DIST_DIR, skillName);
    ensureDir(outputDir);

    const skillFile = path.join(skillDir, 'SKILL.md');
    const skillContent = fs.readFileSync(skillFile, 'utf8');

    // Start AGENTS.md with SKILL.md content
    let agentsContent = skillContent + '\n\n';

    // Find all other files
    const files = await glob('**/*', { 
        cwd: skillDir, 
        ignore: ['SKILL.md', 'node_modules/**', '.git/**'],
        nodir: true 
    });

    for (const file of files) {
        const filePath = path.join(skillDir, file);
        const content = fs.readFileSync(filePath, 'utf8');
        
        // Add file separator and content
        agentsContent += `---
# File: ${file}
${content}
`;
    }

    const outputPath = path.join(outputDir, 'AGENTS.md');
    fs.writeFileSync(outputPath, agentsContent);
    console.log(`Generated ${outputPath}`);
}

export async function main() {
    const args = process.argv.slice(2);
    const command = args[0] || 'build';

    if (!fs.existsSync(SKILLS_DIR)) {
        console.error("Skills directory not found!");
        return;
    }

    const skills = fs.readdirSync(SKILLS_DIR).filter(file => {
        return fs.statSync(path.join(SKILLS_DIR, file)).isDirectory();
    });

    if (command === 'validate') {
        console.log("Validating skills...");
        let hasError = false;
        for (const skill of skills) {
            const isValid = validateSkill(path.join(SKILLS_DIR, skill));
            if (!isValid) hasError = true;
        }
        if (hasError) process.exit(1);
    } else if (command === 'build') {
        console.log(`Building skills from ${SKILLS_DIR}...`);
        ensureDir(DIST_DIR);
        for (const skill of skills) {
            const skillPath = path.join(SKILLS_DIR, skill);
            if (validateSkill(skillPath)) {
                await buildSkill(skillPath);
            } else {
                console.error(`Skipping build for ${skill} due to validation errors.`);
            }
        }
        console.log("Build complete.");
    } else {
        console.error(`Unknown command: ${command}`);
        console.log("Usage: node builder [build|validate]");
    }
}

if (require.main === module) {
    main().catch(console.error);
}
