---
name: inbox-setup
description: Set up a connected Command Mail account with its owner, asking which mail matters, how much the agent may do on its own, how the archive should look and when a recurring Command Mail routine should run. Use only when the user refers to Command Mail or it is their connected mail source, right after connecting or when they ask to set up or reconfigure it; not for other mail providers and not for answering a single message.
---

# Set up Command Mail with the owner

The goal is an inbox the owner trusts: agreed priorities, a clear archive, and a
routine that runs when they expect it. Ask, propose, confirm, then act. Keep the
interview short; offer sensible defaults the owner can accept in one word.

## 1. Read what exists

Call `capabilities`. Note the owner, the granted scopes, every mailbox with its
autonomy level (read, suggest, rules or auto), the agent send limit and the plan.
Report plan limits neutrally; never promote upgrades, prices or trials. Then read
`list_folders`, `list_labels`, `list_rules`, `get_signatures` and
`checkup_status`, and summarize in a few lines what is already set up. Never ask
the owner for passwords, tokens or codes; the connection is OAuth.

If no mailbox is connected and `mailboxes` is granted, offer `connect_mailbox`:
the owner then forwards that address to the returned intake address in their
current provider. The provider's confirmation mail arrives in Command Mail; tell
the owner where to find it and let them confirm it themselves; do not repeat the
code in the conversation. With a domain of their own, `claim_domain` returns a
TXT record and `verify_domain` confirms it. Old mail comes in through the Command
Mail CLI (`commandmail import file.mbox --mailbox ADDRESS`), which archives it
read and triggers nothing; there is no MCP import.

## 2. Interview

Ask in one message, with your proposed default after each question:

1. Which mail matters most: customers, invoices and payments, deadlines,
   appointments, family, newsletters worth reading?
2. What may happen without asking: archiving routine notices, moving obvious
   spam, filing into folders? What must always wait for the owner?
3. Replies: should you only save drafts for approval, or may you send some kinds
   of mail directly? Direct sending needs the separate "Send directly" permission,
   which starts switched off.
4. Archive: which top-level folders? Propose a shallow plan in the owner's words,
   for example Customers, Finance (by year), Contracts, Accounts, Newsletters.
5. Rhythm: when and how often should the routine run (for example 07:30 brief,
   12:30 and 18:00 short passes), and in which time zone?
6. Signature: keep, write a plain one, or a formatted one with logo and links?

## 3. Apply what the owner confirmed

- Autonomy per mailbox is set by the owner under Settings in Command Mail; agents
  cannot change it. Explain the four levels and the one that matches their
  answers. With "suggest" or "rules", filing and archiving wait as suggestions.
- Create the agreed folders with `create_folder` (`parentId` for subfolders);
  `import_folders` creates many paths but is a dry run until `dryRun` is false.
- Create named views with `create_label`; a view moves no mail.
- Rules match one exact sender address and kind and can only archive or mark
  spam. For such senders, `propose_rule` from one example; the rule stays a
  suggestion until the owner switches it on in the app. Filing into folders is
  done in confirmed passes, not by rules.
- Show a signature before `set_signature`; it applies to every later message of
  that identity. HTML is cleaned; link images by https URL.

## 4. Set up the routine

A routine only runs if the agent host schedules it. If the host offers scheduled
tasks or automations, propose one task per agreed time with this prompt: "Run my
Command Mail routine with the inbox-routine skill, time zone ZONE." Create it only
after the owner agrees, and confirm the schedule the host actually saved. If the
host cannot schedule, say so plainly and offer the same prompt for the owner to
run by hand. Never claim background monitoring that does not exist.

## 5. First pass and handover

Run the first routine pass now (see inbox-routine) so the owner sees a result.
For a large backlog, suggest the inbox-cleanup skill as a separate session.
Finish with a short summary: mailboxes and their autonomy, folders and views
created, rules proposed and still waiting for activation, signature, schedule,
and what the owner still has to do in the app.
