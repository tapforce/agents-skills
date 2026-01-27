import fs from 'fs';
import path from 'path';
import matter from 'gray-matter';
import { marked } from 'marked';

const SKILLS_DIR = path.resolve('../skills');

export interface Skill {
  name: string;
  description: string;
  content: string;
  metadata?: Record<string, any>;
  assets?: Record<string, string>;
  references?: Record<string, string>;
}

function getDirectoryFiles(dirPath: string): Record<string, string> {
  const files: Record<string, string> = {};
  if (fs.existsSync(dirPath)) {
    const entries = fs.readdirSync(dirPath, { withFileTypes: true });
    for (const entry of entries) {
      if (entry.isFile()) {
        try {
          files[entry.name] = fs.readFileSync(path.join(dirPath, entry.name), 'utf-8');
        } catch (e) {
          console.warn(`Failed to read file ${entry.name} as text`, e);
        }
      }
    }
  }
  return files;
}

export function getSkills(): Skill[] {
  if (!fs.existsSync(SKILLS_DIR)) {
    return [];
  }

  const skills: Skill[] = [];
  const entries = fs.readdirSync(SKILLS_DIR, { withFileTypes: true });

  for (const entry of entries) {
    if (entry.isDirectory()) {
      const skillPath = path.join(SKILLS_DIR, entry.name, 'SKILL.md');
      if (fs.existsSync(skillPath)) {
        const fileContent = fs.readFileSync(skillPath, 'utf-8');
        const { data, content } = matter(fileContent);
        
        skills.push({
          name: data.name || entry.name,
          description: data.description || '',
          content: marked(content) as string,
          metadata: data
        });
      }
    }
  }

  return skills;
}

export function getSkillByName(name: string): Skill | null {
  const skillDir = path.join(SKILLS_DIR, name);
  const skillPath = path.join(skillDir, 'SKILL.md');
  
  if (!fs.existsSync(skillPath)) {
    return null;
  }

  const fileContent = fs.readFileSync(skillPath, 'utf-8');
  const { data, content } = matter(fileContent);

  const assets = getDirectoryFiles(path.join(skillDir, 'assets'));
  const references = getDirectoryFiles(path.join(skillDir, 'references'));

  return {
    name: data.name || name,
    description: data.description || '',
    content: marked(content) as string,
    metadata: data,
    assets,
    references
  };
}
