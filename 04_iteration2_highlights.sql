-- highlights: quotes from interviews, tagged with a theme
-- new table not a column - one interview can have many highlights
-- a highlight needs: interview it came from, the quote, the theme
-- theme: text + CHECK, same reasoning as status

-- create table
create table highlights (
  id uuid primary key default gen_random_uuid(),
  interview_id uuid not null references interviews(id) on delete cascade,
  quote text not null,
  theme text not null check (theme in ('pain point', 'motivation', 'workaround')),
  created_at timestamptz not null default now()
);

-- seed a few
insert into highlights (interview_id, quote, theme) values
  ((select id from interviews where interviewee_name = 'Minh Tran'),
   '$15 a seat is where finance starts asking questions', 'pain point'),
  ((select id from interviews where interviewee_name = 'Minh Tran'),
   'I just want one tool instead of three', 'motivation'),
  ((select id from interviews where interviewee_name = 'Duc Nguyen'),
   'I could not find the import button so I assumed it did not exist', 'pain point'),
  ((select id from interviews where interviewee_name = 'Duc Nguyen'),
   'My colleague showed me, that is the only reason I came back', 'workaround');

-- pain point highlights with interviewee name
select h.quote, i.interviewee_name
from highlights h
join interviews i on i.id = h.interview_id
where h.theme = 'pain point';

-- count per theme
select theme, count(*) as total
from highlights
group by theme
order by total desc;

-- column vs new table, the distinction:
-- status is one value per interview, so it lives on the interview row.
-- highlights are many per interview, so they need their own rows with a foreign key back.
-- if you can ask "how many X per Y" and the answer is more than one, X is a table.
