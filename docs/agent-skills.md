# Command Mail agent skills

[Deutsch](agent-skills.de.md)

Purpose: make a connected agent useful from the first conversation and keep
the user's choices in charge. These Markdown skills use ordinary Command Mail
MCP or CLI access. They contain no scheduler, install hooks, background worker,
API keys or executable mail-processing code.

## Start in the user's language

The instructions are in English for portability; agents should answer in the
user's language. A user does not need to learn tool names to choose a workflow.

| Skill | Outcome | Example request (DE / EN) |
| --- | --- | --- |
| [mail-agent-setup](../skills/mail-agent-setup/SKILL.md) | A short interview, agreed containers, action limits and an optional real host schedule | „Richte meinen Mail-Assistenten mit mir ein.“ / “Set up my mail assistant with me.” |
| [mailbox-cleanup](../skills/mailbox-cleanup/SKILL.md) | Review the existing backlog, separate wanted mail from spam, apply agreed filing in resumable batches | „Räume mein Postfach auf. Zeig mir zuerst, was raus soll.“ / “Clean up my mailbox; show me the candidates first.” |
| [mail-triage](../skills/mail-triage/SKILL.md) | Process new/changed mail under agreed preferences and show what actually happened | „Sortiere neue Mails und zeig mir nur offene Entscheidungen.“ / “Triage new mail and show the decisions I need to make.” |
| [mail-briefing](../skills/mail-briefing/SKILL.md) | A concise, sourced overview of replies, decisions, payments, deadlines and gaps | „Was braucht heute meine Aufmerksamkeit?“ / “What needs my attention today?” |
| [mail-replies](../skills/mail-replies/SKILL.md) | Context-aware replies saved for review or sent in the user's chosen mode | „Bereite eine Antwort vor; ich sende selbst.“ / “Prepare a reply; I will send it myself.” |
| [mail-follow-ups](../skills/mail-follow-ups/SKILL.md) | Track waits for replies and prepare due follow-ups | „Erinnere mich in drei Tagen, wenn darauf keine Antwort kommt.“ / “Track this; I want to follow up in three days if there is no reply.” |
| [mail-workflow](../skills/mail-workflow/SKILL.md) | Find/read mail and route broader tasks to the relevant optional skill | „Finde die letzte Mail zu meinem Angebot.“ / “Find the latest email about my quote.” |

Use setup first when no preferences exist. A historical cleanup is a separate
job; once it is reviewed, triage can handle arrivals and a briefing can surface
decisions. Existing agreed workflows stay valid. Each skill can also handle its core task
alone; the optional cross-links are not prerequisites for ordinary mail access.

## Delivery and installation

The complete plugin ships the `skills/` directory. Install using the host
instructions in the [README](../README.md). Hosts supporting plugin skill
discovery can select a relevant skill from its name and description; selection
and loading still depend on the host, not a server guarantee.

A remote MCP connection on its own exposes tools, not an installed skill pack.
For a skill-capable local agent, copy the desired folder from `skills/`, including
its references, into that host's documented skill directory. For Codex personal
skills this is `~/.codex/skills/`; check for an existing same-name skill before
copying and review it rather than overwriting user changes. Other hosts have
their own installation locations and permissions.

For a chat-only host, provide the relevant `SKILL.md` as user-approved workflow
instructions or project material. Attach `references/large-mailboxes.md` as well
for large cleanup jobs. Verify the host can actually access the contents; a link
alone is not proof that the skill was loaded. Follow that host's privacy and
persistence controls. The existing `get_organization_guide` tool and
`commandmail skill` remain the general server guide, not these seven skills.

Download the repository ZIP from GitHub's **Code → Download ZIP** for the full
pack; extract only the desired skill folders. Do not run the maintainer's
OpenAI ZIP build script as part of user installation.

## What the skills can and cannot do

- **Containers:** named inbox views are labels; archive folders file completed
  conversations away. Creation does not automatically sort existing mail.
- **Rules:** the agent proposes narrow sender-plus-kind rules. The owner
  activates or widens them in the app. Filing alone does not enable a rule.
- **Automation:** a user-approved schedule belongs to the agent host. Command
  Mail's checkup receipts show run metadata, not an agent scheduler.
- **Replies:** sorting, drafting, approved sending and direct sending are
  separate choices. Mailbox `auto` is not permission to send.
- **Large histories:** the cleanup skill supplies a bounded inventory and
  resumption method. It does not promise a 100,000-message job completes in one
  run or that a bounded overview has scanned the full history.
- **Corrections:** archive/spam journal actions can be undone where unchanged.
  Label and archive-folder changes currently have no journal undo. The skills
  explain previous-state capture and do not claim every action is reversible.
- **Assessors:** Jev or another host-provided assessor is optional diagnostic
  evidence under an authorized data/cost route. This plugin installs none and
  does not export a mailbox to an external classifier.

Confirmed preferences belong only in a user-approved private host store. Mail
bodies, credentials and checkpoint inventories never belong in this repository.
The host and server enforce rights; skill instructions guide decisions and do
not add technical permissions or guarantee model behavior.

## A useful first-session result

The agent should be able to say which mailboxes it can see, show a few realistic
sorting examples, record the user's exceptions in an approved private place,
prepare a draft if requested and show how the user can change or pause the
workflow. A recurring job is ready only after an actual schedule readback.
“Connected” is a starting point, not proof the inbox is being maintained.
