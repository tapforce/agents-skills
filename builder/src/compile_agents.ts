import * as fs from 'fs';
import * as path from 'path';
import { glob } from 'glob';
import matter from 'gray-matter';
import { SKILLS_DIR } from './constants';
import { validateSkill } from './validate';

export async function compileSkillAgents(skillDir: string) {
    const skillName = path.basename(skillDir);
    console.log(`Compiling agents for skill: ${skillName}`);

    const skillFile = path.join(skillDir, 'SKILL.md');
    const skillContent = fs.readFileSync(skillFile, 'utf8');

    let agentsContent = skillContent.trimEnd() + '\n\n';

    const files = await glob('**/*', {
        cwd: skillDir,
        ignore: ['SKILL.md', 'AGENTS.md', 'node_modules/**', '.git/**'],
        nodir: true
    });

    for (const file of files) {
        const filePath = path.join(skillDir, file);
        const content = fs.readFileSync(filePath, 'utf8');
        let sectionContent = content;

        if (file.startsWith('rules/') && file.endsWith('.md')) {
            const parsed = matter(content);
            const title = String(
                parsed.data.name ??
                parsed.data.title ??
                path.basename(file, path.extname(file))
            );
            const description = typeof parsed.data.description === 'string' ? parsed.data.description : '';
            const tags = Array.isArray(parsed.data.tags)
                ? parsed.data.tags.join(', ')
                : typeof parsed.data.tags === 'string'
                    ? parsed.data.tags
                    : '';
            const body = parsed.content.trim();
            const parts = [`# ${title} | File: ${file}`];
            if (description) parts.push('', description);
            if (tags) parts.push('', tags);
            if (body) parts.push('', body);
            sectionContent = parts.join('\n');
        }

        agentsContent += `---
${sectionContent}
`;
    }

    const outputPath = path.join(skillDir, 'AGENTS.md');
    fs.writeFileSync(outputPath, agentsContent);
    console.log(`Generated ${outputPath}`);
}

export async function compileAllAgents() {
    console.log(`Compiling agents from ${SKILLS_DIR}...`);

    if (!fs.existsSync(SKILLS_DIR)) {
        console.error('Skills directory not found!');
        return;
    }

    const skills = fs.readdirSync(SKILLS_DIR).filter(file => {
        return fs.statSync(path.join(SKILLS_DIR, file)).isDirectory();
    });

    for (const skill of skills) {
        const skillPath = path.join(SKILLS_DIR, skill);
        if (validateSkill(skillPath)) {
            await compileSkillAgents(skillPath);
        } else {
            console.error(`Skipping compile for ${skill} due to validation errors.`);
        }
    }
    console.log('Compile complete.');
}

if (require.main === module) {
    compileAllAgents().catch(console.error);
}
