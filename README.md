# HW5 - database design

Supabase project `clra-homework`. Files run in the SQL editor in order.

1. `01_schema.sql`
2. `02_seed.sql`
3. `03_iteration1_status.sql`
4. `04_iteration2_highlights.sql`

## Questions for mentors

- If the research questions under a plan change after interviews have already happened, do old interview_questions get edited in place, or versioned so past interview notes still show what was actually asked at the time?

  > Câu hỏi hay nha em, cho tới mức scale này thì chưa cần versioning lắm nha em. Vì vốn trong transcript của interview cũng đã lưu những IQ với RQ của tụi nó luôn rùi nên mình không cần đảm bảo cái SST nữa

- We used `text` + `CHECK` for status and theme. At CLRA's real scale, is that a Postgres enum, a lookup table, or plain text validated only in the API layer - and what made you pick one over the others?

  > text+CHECK là lựa chọn hợp lý ở giai đoạn này, đúng như em đã giải thích (đổi enum sau này khá đau, được cái lợi thế vể default sorting thui). Lookup table sẽ đáng cân nhắc khi cần thêm metadata cho từng status/theme (VD: màu hiển thị, mô tả, hoặc admin tự thêm theme mới không cần deploy code), còn lại những config ít thay đổi thì cũng không cần quá phức tạp. Nhớ dụ là mỗi bảng riêng là mình lại phải tính đến cả CRUD cho tụi nó nhenn

- Every foreign key here is `on delete cascade`. Does CLRA actually hard-delete an interview and lose its highlights and transcript, or is deletion always a soft delete / archive because research data has retention weight?

  > Thực tế research data nên là soft delete (thêm cột deleted_at hoặc archived_at) đúng như em nghĩ - hard delete cascade kiểu này hợp cho bài tập/demo nhưng với dữ liệu nghiên cứu thật thì mất transcript cùng với research plan không make sense.

- Where does RLS actually start mattering for CLRA - per organization, per workspace, per user - and does that policy design happen before the schema exists or after?

  > Thường là per organization/workspace trước, rồi mới tới per-user trong workspace đó. Và nên nghĩ RLS song song lúc thiết kế schema, không phải sau vì nó quyết định mình cần cột nào (VD: organization_id) nằm ở bảng nào để policy join được, thêm sau khá tốn công refactor.
  > Nhưng mà tbh là ở những giai đoạn security chưa phải là vấn đề tối quan trọng thì anh khuyên nên skip, dụ này hong khác gì YAGNI, nó gây ra rất nhiều lỗi hong đáng quan tâm
