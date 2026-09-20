-- tables for clra-homework, create one at a time in sql editor, parents first

-- research_plans -> interviews (research_plan_id), research_questions (research_plan_id)
-- research_questions -> interview_questions (research_question_id)
-- interviews -> interview_contents (interview_id, one per interview)

-- interview_contents is its own table, not a column, because the transcript is
-- written at a different time than the interview is scheduled, can be large,
-- and most list screens don't need it. Keeps interviews small to read.

-- research_plans
create table research_plans (
  id uuid primary key default gen_random_uuid(),
  name text not null,
  description text,
  created_at timestamptz not null default now()
);

-- interviews
create table interviews (
  id uuid primary key default gen_random_uuid(),
  research_plan_id uuid not null references research_plans(id) on delete cascade,
  interviewee_name text not null,
  scheduled_at timestamptz,
  created_at timestamptz not null default now()
);

-- research_questions
create table research_questions (
  id uuid primary key default gen_random_uuid(),
  research_plan_id uuid not null references research_plans(id) on delete cascade,
  content text not null,
  created_at timestamptz not null default now()
);

-- interview_questions
create table interview_questions (
  id uuid primary key default gen_random_uuid(),
  research_question_id uuid not null references research_questions(id) on delete cascade,
  content text not null,
  created_at timestamptz not null default now()
);

-- interview_contents
create table interview_contents (
  id uuid primary key default gen_random_uuid(),
  interview_id uuid not null unique references interviews(id) on delete cascade,
  content text not null,
  created_at timestamptz not null default now()
);

-- RLS off on all 5 after creating (Table Editor -> table -> RLS toggle)
