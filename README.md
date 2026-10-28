# Command Mail plugin

[Command Mail](https://commandmail.app/?utm_source=github&utm_medium=readme) is one inbox for all of your email addresses, built so your AI agent can work in it. The agent reads, searches, sorts and drafts, and sends only if you allow it, per permission and per mailbox.

This repository connects agent hosts to the hosted Command Mail MCP server at `https://commandmail.app/mcp` and adds four skills. You need a Command Mail account; [start for free](https://commandmail.app/en?utm_source=github&utm_medium=readme) with one address.

## Plans

The plugin and the MCP connector are free and released under the MIT License. Installing and using them costs nothing.

The hosted Command Mail service has a Free plan that does not expire: one mailbox, the last 90 days of mail, reading, search, sorting, the morning brief and drafts. On the Free plan the agent cannot send email.

The paid Pro plan adds sending, up to ten mailboxes and the full mail history. Plans are bought only on [commandmail.app](https://commandmail.app/en?utm_source=github&utm_medium=readme), never inside an agent host or editor; current prices are listed there. Without a paid plan, the agent can still read, search, sort and draft; actions that send mail, such as replies and forwards, need Pro.

## Skills

| Skill | Use it to |
| --- | --- |
| `inbox-setup` | Set up a new account with you: priorities, autonomy, archive folders, sorting rules, Spam and Trash retention, signature and a recurring routine your agent host schedules |
| `inbox-routine` | Run one mail pass: check new mail since the last complete run, presort it with your rules, prepare drafts, record the run and write a short brief |
| `inbox-cleanup` | Clean up a large inbox in agreed passes: the agent sorts, you correct, the agent moves the mail and creates the agreed rules |
| `mail-workflow` | Find and read mail, answer with plain or formatted drafts and attachments, file conversations, manage folders and track follow-ups |

Ask your agent, for example, "Set up my inbox and a daily mail routine" or "Run my Command Mail routine". A routine runs on a schedule only if your agent host supports scheduled tasks and you created one.

The server is also listed in the [Official MCP Registry](https://registry.modelcontextprotocol.io) as `app.commandmail/mail`.

## Install

**ChatGPT and Codex.** Command Mail will appear in the ChatGPT and Codex plugin directory once it is listed there. Until then, add this repository as a marketplace in Codex:

```sh
codex plugin marketplace add FYN-Labs/commandmail-plugin
codex plugin add command-mail@commandmail
```

**Claude Code.**

```
/plugin marketplace add FYN-Labs/commandmail-plugin
/plugin install command-mail@commandmail
```

**Cursor.** Once the plugin is listed in the [Cursor Marketplace](https://cursor.com/marketplace), install it from **Customize**. To try it before that, clone the repository into your local plugin folder and run *Developer: Reload Window*:

```sh
git clone https://github.com/FYN-Labs/commandmail-plugin ~/.cursor/plugins/local/command-mail
```

The MCP server then appears as `plugin-command-mail-commandmail`. Cursor opens the Command Mail sign-in on first use; the plugin needs no API key or variable.

**Gemini CLI.**

```sh
gemini extensions install https://github.com/FYN-Labs/commandmail-plugin
```

**Any other MCP client.** Add a remote MCP server with the Streamable HTTP transport and the URL `https://commandmail.app/mcp`.

## Sign in

On first use, your agent opens Command Mail in the browser. Sign in and switch on the permissions you want to grant; sending without your approval starts switched off. The connection uses OAuth 2.1 with PKCE, so you never give the agent a password or API key. You can disconnect an agent at any time under Settings → Connections.

## Permissions

| Permission | What the agent may do |
| --- | --- |
| `mail:read` | Read, search and sort mail, manage folders and the sorting rules you ask for, prepare the overview and morning brief, track follow-ups |
| `mail:draft` | Create and revise drafts; never sends |
| `mail:send-approved` | Send exactly the draft revision you approved |
| `mail:send` | Send without approval, once per message, to at most 20 recipients and within a daily limit |
| `mailboxes` | Connect addresses, verify domains, import old mail |

Each mailbox also has an autonomy level (read, suggest, rules or auto) that limits what an agent may change. Email content is treated as data, never as instructions.

## Network and credentials

The plugin ships no executable code, hooks or install scripts. It declares one remote MCP server, `https://commandmail.app/mcp`, and the agent host talks only to `commandmail.app`: the MCP endpoint and the OAuth endpoints it advertises under `/.well-known/`. The only credential is the OAuth token your agent host receives after you sign in; you never enter a password or API key into the plugin.

## Package layout

| Host | Files |
| --- | --- |
| ChatGPT, Codex, Cursor ([Agent Plugins](https://agent-plugins.org)) | `plugin.json`, `mcp.json` |
| Cursor Marketplace (logo and listing) | `.cursor-plugin/plugin.json` |
| Claude Code | `.claude-plugin/`, `.mcp.json` |
| Gemini CLI | `gemini-extension.json` |
| All hosts | `skills/`, `assets/` |

`plugin.json` also carries the listing, review cases and release notes for the OpenAI plugin directory under `extensions.com.openai`. Build the upload ZIP with `scripts/build-openai-zip.sh /path/to/commandmail-plugin.zip`; it contains only the portable package. Reviewer credentials never belong in this repository.

## Legal and support

- [Privacy policy](https://commandmail.app/privacy?utm_source=github&utm_medium=readme)
- [Terms of service](https://commandmail.app/terms?utm_source=github&utm_medium=readme)
- [Legal notice](https://commandmail.app/legal?utm_source=github&utm_medium=readme)
- Support: [support@fyn-labs.com](mailto:support@fyn-labs.com)

Command Mail is operated by FYN Labs LLC. This plugin is released under the [MIT License](LICENSE).
