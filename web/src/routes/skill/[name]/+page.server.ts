import { getSkillByName } from '$lib/server/skills';
import { error } from '@sveltejs/kit';
import type { PageServerLoad } from './$types';

export const load: PageServerLoad = async ({ params }) => {
  const skill = getSkillByName(params.name);
  
  if (!skill) {
    throw error(404, 'Skill not found');
  }

  return {
    skill
  };
};
