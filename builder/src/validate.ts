import * as fs from 'fs';
import * as path from 'path';
import matter from 'gray-matter';
import { SKILLS_DIR } from './constants';

export function validateSkill(skillDir: string): boolean {
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

export function validateAll() {
    console.log("Validating skills...");
    if (!fs.existsSync(SKILLS_DIR)) {
        console.error("Skills directory not found!");
        return;
    }

    const skills = fs.readdirSync(SKILLS_DIR).filter(file => {
        return fs.statSync(path.join(SKILLS_DIR, file)).isDirectory();
    });

    let hasError = false;
    for (const skill of skills) {
        const isValid = validateSkill(path.join(SKILLS_DIR, skill));
        if (!isValid) hasError = true;
    }
    if (hasError) process.exit(1);
}

if (require.main === module) {
    validateAll();
}
