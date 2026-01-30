import * as fs from 'fs';
import * as path from 'path';
import { glob } from 'glob';
import { SKILLS_DIR, DIST_DIR } from './constants';
import { ensureDir } from './utils';
import { validateSkill } from './validate';

export async function buildSkill(skillDir: string) {
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

export async function buildAll() {
    console.log(`Building skills from ${SKILLS_DIR}...`);
    
    if (!fs.existsSync(SKILLS_DIR)) {
        console.error("Skills directory not found!");
        return;
    }

    ensureDir(DIST_DIR);
    
    const skills = fs.readdirSync(SKILLS_DIR).filter(file => {
        return fs.statSync(path.join(SKILLS_DIR, file)).isDirectory();
    });

    for (const skill of skills) {
        const skillPath = path.join(SKILLS_DIR, skill);
        if (validateSkill(skillPath)) {
            await buildSkill(skillPath);
        } else {
            console.error(`Skipping build for ${skill} due to validation errors.`);
        }
    }
    console.log("Build complete.");
}

if (require.main === module) {
    buildAll().catch(console.error);
}
