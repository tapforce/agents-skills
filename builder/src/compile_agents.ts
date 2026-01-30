import * as fs from 'fs';
import * as path from 'path';
import { glob } from 'glob';
import { SKILLS_DIR } from './constants';
import { validateSkill } from './validate';

export async function compileSkillAgents(skillDir: string) {
    const skillName = path.basename(skillDir);
    console.log(`Compiling agents for skill: ${skillName}`);

    const skillFile = path.join(skillDir, 'SKILL.md');
    const skillContent = fs.readFileSync(skillFile, 'utf8');

    // Start AGENTS.md with SKILL.md content
    let agentsContent = skillContent + '\n\n';

    // Find all other files
    // IMPORTANT: Ignore AGENTS.md to avoid recursion/duplication if it exists
    const files = await glob('**/*', { 
        cwd: skillDir, 
        ignore: ['SKILL.md', 'AGENTS.md', 'node_modules/**', '.git/**'],
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

    // Write to the same folder as SKILL.md
    const outputPath = path.join(skillDir, 'AGENTS.md');
    fs.writeFileSync(outputPath, agentsContent);
    console.log(`Generated ${outputPath}`);
}

export async function compileAllAgents() {
    console.log(`Compiling agents in ${SKILLS_DIR}...`);
    
    if (!fs.existsSync(SKILLS_DIR)) {
        console.error("Skills directory not found!");
        return;
    }

    const skills = fs.readdirSync(SKILLS_DIR).filter(file => {
        return fs.statSync(path.join(SKILLS_DIR, file)).isDirectory();
    });

    for (const skill of skills) {
        const skillPath = path.join(SKILLS_DIR, skill);
        // We can optionally validate before compiling, similar to build
        if (validateSkill(skillPath)) {
            await compileSkillAgents(skillPath);
        } else {
            console.error(`Skipping compile for ${skill} due to validation errors.`);
        }
    }
    console.log("Compilation complete.");
}

if (require.main === module) {
    compileAllAgents().catch(console.error);
}
