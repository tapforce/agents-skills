import { getSkills } from '$lib/server/skills';
import type { PageServerLoad } from './$types';

export const load: PageServerLoad = async () => {
  const skills = getSkills();
  return {
    skills
  };
};
