-- seed data, plans first (no dependencies), then children
-- ids are generated uuids, so child rows look up their parent by name

insert into research_plans (name, description) values
  ('B2B SaaS pricing research', 'Understand how small teams decide what to pay for tooling'),
  ('Onboarding drop-off', 'Why new users stop after the first session');

insert into interviews (research_plan_id, interviewee_name, scheduled_at) values
  ((select id from research_plans where name = 'B2B SaaS pricing research'), 'Minh Tran',   '2026-09-22 10:00+07'),
  ((select id from research_plans where name = 'B2B SaaS pricing research'), 'Sarah Chen',  '2026-09-23 15:00+07'),
  ((select id from research_plans where name = 'Onboarding drop-off'),       'Duc Nguyen',  '2026-09-24 09:30+07'),
  ((select id from research_plans where name = 'Onboarding drop-off'),       'Priya Patel', '2026-09-25 14:00+07');

insert into research_questions (research_plan_id, content) values
  ((select id from research_plans where name = 'B2B SaaS pricing research'), 'How sensitive are small teams to per-seat pricing?'),
  ((select id from research_plans where name = 'B2B SaaS pricing research'), 'Who actually makes the buying decision?'),
  ((select id from research_plans where name = 'Onboarding drop-off'),       'Where do users get stuck in the first session?');

insert into interview_questions (research_question_id, content) values
  ((select id from research_questions where content like 'How sensitive%'), 'What do you currently pay per month for tools like this?'),
  ((select id from research_questions where content like 'How sensitive%'), 'At what price would you stop and look for alternatives?'),
  ((select id from research_questions where content like 'Who actually%'),  'Walk me through the last tool your team bought. Who signed off?'),
  ((select id from research_questions where content like 'Where do users%'), 'What was the first thing you tried to do after signing up?'),
  ((select id from research_questions where content like 'Where do users%'), 'Was there a moment you thought about closing the tab?');

insert into interview_contents (interview_id, content) values
  ((select id from interviews where interviewee_name = 'Minh Tran'),
   'Pays around $40/seat across three tools. Said $15/seat is the ceiling before finance asks questions. Buying decision is his, but the CFO reviews anything over $500/month.'),
  ((select id from interviews where interviewee_name = 'Duc Nguyen'),
   'Signed up to import a CSV. Could not find the import button, assumed the product did not support it, closed the tab. Came back two days later because a colleague showed him.');
