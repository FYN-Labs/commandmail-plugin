# Command Mail plugin

[Command Mail](https://commandmail.app) is one inbox for all of your email addresses, built so your AI agent can work in it. The agent reads, searches, sorts and drafts, and sends only if you allow it, per permission and per mailbox.

This repository connects agent hosts to the hosted Command Mail MCP server at `https://commandmail.app/mcp` and adds four skills. You need a Command Mail account: [start for free](https://commandmail.app/en) with one address; Pro adds sending, more addresses and your full history.

## Skills

| Skill | Use it to |
| --- | --- |
| `inbox-setup` | Set up a new account with you: priorities, autonomy, archive folders, signature and a recurring routine your agent host schedules |
| `inbox-routine` | Run one mail pass: check new mail since the last complete run, presort it, prepare drafts, record the run and write a short brief |
| `inbox-cleanup` | Clean up a large inbox in agreed passes, build the archive structure, separate spam and phishing and propose sorting rules |
| `mail-workflow` | Find and read mail, answer with plain or formatted drafts, file conversations and track follow-ups |

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

**Cursor.** Clone the repository into your local plugin folder, then run *Developer: Reload Window*:

```sh
git clone https://github.com/FYN-Labs/commandmail-plugin ~/.cursor/plugins/local/command-mail
```

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
| `mail:read` | Read, search and sort mail, prepare the overview and morning brief, track follow-ups |
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
| Claude Code | `.claude-plugin/`, `.mcp.json` |
| Gemini CLI | `gemini-extension.json` |
| All hosts | `skills/`, `assets/` |

`plugin.json` also carries the listing, review cases and release notes for the OpenAI plugin directory under `extensions.com.openai`. Build the upload ZIP with `scripts/build-openai-zip.sh /path/to/commandmail-plugin.zip`; it contains only the portable package. Reviewer credentials never belong in this repository.

## Legal and support

- [Privacy policy](https://commandmail.app/privacy)
- [Terms of service](https://commandmail.app/terms)
- [Legal notice](https://commandmail.app/legal)
- Support: [support@fyn-labs.com](mailto:support@fyn-labs.com)

Command Mail is operated by FYN Labs LLC. This plugin is released under the [MIT License](LICENSE).
