# agentd on Cursor

[obarker94/agentd](https://github.com/obarker94/agentd) is an MCP server (Go). Upstream examples show OpenCode; Cursor uses `mcp.json`.

## When

Only for large DAG / multi-agent epics. Skip for normal MMFs.

## Install binary

```bash
git clone https://github.com/obarker94/agentd.git
cd agentd
go build -o agentd ./cmd/agentd
cp agentd ~/.local/bin/   # ensure ~/.local/bin is on PATH
```

## Cursor config

**Global** (all projects): `~/.cursor/mcp.json`  
**Project**: `.cursor/mcp.json`

```json
{
  "mcpServers": {
    "agentd": {
      "command": "agentd",
      "env": {
        "AGENTD_DB_PATH": "${userHome}/.agentd/agentd.db"
      }
    }
  }
}
```

If `agentd` is not on PATH, set `"command"` to the absolute binary path.

Restart Cursor (or reload MCP). Confirm the server is green under **Settings → MCP**.

## With this skill

1. Keep the living plan in git (`plans/`) as source of truth  
2. Create agentd project/tasks from that plan  
3. Each worker: worktrunk branch + claim task → implement → complete task  
4. Mirror progress into the plan checklist + `last-steps.md`  
5. Ship still ends in **PRs** (one PR per coherent slice when possible)

## Note

agentd is early/small. If MCP wiring fails, fall back to markdown plans + worktrunk — do not block the epic on agentd.
