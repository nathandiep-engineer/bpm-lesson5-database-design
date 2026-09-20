# HW5 - database design

Supabase project `clra-homework`. Files run in the SQL editor in order.

1. `01_schema.sql`
2. `02_seed.sql`
3. `03_iteration1_status.sql`
4. `04_iteration2_highlights.sql`

## Questions for mentors

- If the research questions under a plan change after interviews have already happened, do old interview_questions get edited in place, or versioned so past interview notes still show what was actually asked at the time?
- We used `text` + `CHECK` for status and theme. At CLRA's real scale, is that a Postgres enum, a lookup table, or plain text validated only in the API layer - and what made you pick one over the others?
- Every foreign key here is `on delete cascade`. Does CLRA actually hard-delete an interview and lose its highlights and transcript, or is deletion always a soft delete / archive because research data has retention weight?
- Where does RLS actually start mattering for CLRA - per organization, per workspace, per user - and does that policy design happen before the schema exists or after?
