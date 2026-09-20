-- add status to interviews: planned / completed / cancelled
-- column not a table, one value per interview
-- existing rows default to planned, they were all scheduled and none has happened yet
-- typo guard: text + CHECK. Enum type is stricter but changing it later is painful.

-- alter table
alter table interviews
  add column status text not null default 'planned'
  check (status in ('planned', 'completed', 'cancelled'));

-- backfill existing rows
-- default already set them to planned, so just mark the two that actually happened
update interviews
set status = 'completed'
where interviewee_name in ('Minh Tran', 'Duc Nguyen');

-- planned interviews with plan name
select i.interviewee_name, i.scheduled_at, p.name as plan_name
from interviews i
join research_plans p on p.id = i.research_plan_id
where i.status = 'planned'
order by i.scheduled_at;

-- most recent interview
-- note: seed inserted all four in one statement so created_at ties, any of them can come back
select interviewee_name, status, created_at
from interviews
order by created_at desc
limit 1;

-- why alter not drop+recreate:
-- drop would delete every interview row and cascade into interview_contents.
-- alter keeps the rows and just adds the column with a default.
