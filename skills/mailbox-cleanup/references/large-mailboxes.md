# Large histories: inventory, batches and resumption

Use this procedure when the history cannot fit in one run. It describes a
bounded workflow; it is not a throughput guarantee for 100,000 messages.
Available history, request limits, model context and time budgets still apply.

## Define coverage before work

Fix the instance/account, addresses, views and date range. Preserve the source
IDs exactly; Gmail/IMAP IDs are not Command Mail IDs. A complete result means
every selected page/window was enumerated, relevant conversation context was
reviewed and each candidate has a disposition. It does not mean every item was
archived or that nothing still needs the user.

Use `list_threads` for each selected view/address/folder. Follow returned totals
and pagination; do not assume an API page size. Inbox, archive, Spam and Trash
are distinct scopes. Inspect Spam for mistaken filtering, but do not restore or
process Trash without the requested scope. Drafts and sent history are separate
sources when relevant.

`mail_changes(since, until, cursor, limit)` provides cursor-paged original-message
metadata ordered by change time, including folder state. Choose a real lower
bound and freeze a non-future UTC `until`; carry the same window through every
page until `nextCursor` is absent. Deduplicate source message IDs and map them
to thread IDs. Read each relevant thread; metadata coverage is not content
triage. Change time differs from the original mail date, especially for imports.

## Avoid moving the page under your feet

Offset pagination over a folder changes when messages are moved. First enumerate
a bounded scope into a private ID inventory without writes, then classify and
apply that inventory. Never archive page 1 and then ask for page 2 of the now
shorter inbox. Prefer cursor windows where suitable. If a cursor snapshot cannot
be completed before writes, defer writes for that scope and report the backlog.

Concurrent user actions or arrivals can still change enumeration. Retain the
last complete window and recheck its boundary with overlap on resume. De-duplicate
and refresh current states; an already-filed item is not a second action. A stale
fingerprint, changed thread or quota refusal returns to review, not a force-write.

## Keep a minimal checkpoint

Use an existing user-approved private workspace/host store. Ask before adding a
new storage or export location; if unavailable, complete a smaller run and state
that durable resumption is unavailable. Keep only what is needed:

- Run ID, source/account reference, agreed scope and policy version.
- Fixed window, next cursor or page, last complete window, missing scopes.
- Deduplicated message/thread IDs and disposition: to review, approved, applied,
  suggested, skipped, failed; previous labels/folder for unjournaled writes.
- Returned activity/proposal references, truthful counts and next bounded slice.

No mail bodies, credentials or attachment contents. Restrict file access and use
the user's agreed retention. Checkpoints never belong in a public repo, another
user's account or a directory submission. Get actual results before advancing
progress. Resume from verified checkpoints, not a prose claim that work finished.

## Bound work and report it

Choose batches for actual returned limits and available time/context, starting
small enough to inspect the results. Exact fingerprints expire; refresh before
applying. Stop on repeated errors, changed permission, missing source access or
uncertain state. Report progress as messages enumerated, threads reviewed and
actions applied; samples and estimates must be labelled as such. Preserve
unresolved work when a run ends.

`record_checkup` is optional run reporting, not a generic backlog database. Its
windows are at most 31 days and its open references are bounded. For larger
histories use the private checkpoint and separate eligible window receipts;
do not submit a years-long checkup or invent a complete checkpoint. A successful
receipt attests the agent's reported coverage, not independent content review.
