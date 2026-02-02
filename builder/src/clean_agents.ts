import * as fs from 'fs';
import * as path from 'path';
import { glob } from 'glob';
import { SKILLS_DIR } from './constants';

export async function removeAgentsFiles() {
    console.log(`Removing AGENTS.md files from skills in ${SKILLS_DIR}...`);
    
    if (!fs.existsSync(SKILLS_DIR)) {
        console.error("Skills directory not found!");
        return;
    }

    // Find all AGENTS.md files in skills directories
    const agentsFiles = await glob('skills/*/AGENTS.md', { 
        cwd: path.resolve(__dirname, '../..'),
        absolute: true 
    });

    if (agentsFiles.length === 0) {
        console.log("No AGENTS.md files found in skills directories.");
        return;
    }

    console.log(`Found ${agentsFiles.length} AGENTS.md files to remove:`);
    
    for (const agentsFile of agentsFiles) {
        try {
            fs.unlinkSync(agentsFile);
            console.log(`Removed: ${agentsFile}`);
        } catch (error) {
            console.error(`Failed to remove ${agentsFile}:`, error);
        }
    }

    console.log("Clean complete.");
}

if (require.main === module) {
    removeAgentsFiles().catch(console.error);
}
