update `AGENTS.md`

add new section about testing skill

When i request test a skill (ex: skill A), you must following steps:

1. you need scan and know all skills available in folder ./skills` of this project.
2. you must think skills found in step 1 is your skill in current testing session, you use them when you think they are suitable for current task.
3. When you use a skill/rules, you must show name of skill/rule with clear title so i can understand you use or not use skill.
4. for testing a skill, all testing file generated within testing session must stored in folder `./testing` of this project. You always clear all file inside this folder before start testing a skill and clear again after testing session.
5. After testing a skill, you must summary result of testing in to file `./reports/<skill-name>.md` of this project. Summary include:

- The percentage of perfection (0-100)
- Estimate quality of skill (ex: 1-5 stars)
- Listing topics you think skill is good
- Listing topics you think skill is bad. Explains why.
- Listing topics you think need improve. Explains why.
- Add name of other skills/rules and where you used them in testing session.

6. After testing you also need create or update file `./reports/summary.md` of this project. Summary include:

- `summary.md` contains a table with columns, 
    - `skill name`: name of skill tested in history.
    - `percentage`: % of perfection of skill.
    - `quality`:  quality of skill (ex: 1-5 stars).
    - `tested date`: date of testing session.

---

update `AGENTS.md`
add https://agentskills.io/llms.txt as main documentation source. Reference it when need check official guideline.

---

update `AGENTS.md`
Improve the agent skill development workflow. Consider organize skill content when complex into rules.

- rules stored in `./rules` folder of skill folder.
- skill file `SKILL.md` will reference rules created within skill. Each reference metadata include:
    - name: name of rule
    - description: description of rule
    - relative path to rule file.
- each rule file must have frontmatter metadata include:
    - name: name of rule
    - description: description of rule
    - other metadata following agentskill instruction.

- You can detach skill to rules when meet strong recommended mention in request:
example: `bias`, `rules`, or strong mention focused small domain under skill's domain.
- Rule file contain a rule must focus on a domain, aims to resolve that domain, make sure consistency, clear.
- Rule file contains description what it for, include examples correct or not correct for reference.

---

you need add list rules into SKILL.md. each rule is reference to rule file include:
- name of rule
- description of rule
- relative path to rule file