#!/usr/bin/env bash
set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_DIR="$(dirname "$SCRIPT_DIR")"
source "${SCRIPT_DIR}/utils.sh"

TIER="${1:-developer}"
MCP_COMPOSE="${REPO_DIR}/mcp/compose/mcp.${TIER}.json"
CLAUDE_SETTINGS="${HOME}/.claude/settings.json"

step "Configurazione MCP servers (tier: $TIER)"

if [ ! -f "$MCP_COMPOSE" ]; then
  error "File MCP compose non trovato: $MCP_COMPOSE"
  exit 1
fi

# Raccolta credenziali
GITHUB_TOKEN=""
DATABASE_URL=""
BRAVE_API_KEY=""

# GitHub Token (tier base+)
echo ""
info "GitHub Personal Access Token (obbligatorio per MCP github)"
info "Crea il token su: https://github.com/settings/tokens"
info "Scope necessari: repo, read:org, read:user"
read -rsp "  Token GitHub (invio per saltare): " GITHUB_TOKEN
echo ""

if [ -z "$GITHUB_TOKEN" ]; then
  warn "GitHub Token non fornito — MCP github non sarà configurato."
fi

# Database URL (tier developer+)
if [ "$TIER" = "developer" ] || [ "$TIER" = "full" ]; then
  echo ""
  info "Database URL PostgreSQL locale (es: postgresql://user:pass@localhost:5432/dbname)"
  read -rsp "  DATABASE_URL (invio per saltare): " DATABASE_URL
  echo ""
  if [ -z "$DATABASE_URL" ]; then
    warn "DATABASE_URL non fornito — MCP postgres non sarà configurato."
  fi
fi

# Brave Search API Key (tier full)
if [ "$TIER" = "full" ]; then
  echo ""
  info "Brave Search API Key (per ricerca web real-time)"
  info "Ottieni la chiave su: https://brave.com/search/api/"
  read -rsp "  Brave API Key (invio per saltare): " BRAVE_API_KEY
  echo ""
  if [ -z "$BRAVE_API_KEY" ]; then
    warn "Brave API Key non fornita — MCP brave-search non sarà configurato."
  fi
fi

# Sostituisce variabili nel compose JSON
MCP_JSON=$(cat "$MCP_COMPOSE")
MCP_JSON="${MCP_JSON//\$\{GITHUB_TOKEN\}/$GITHUB_TOKEN}"
MCP_JSON="${MCP_JSON//\$\{DATABASE_URL\}/$DATABASE_URL}"
MCP_JSON="${MCP_JSON//\$\{BRAVE_API_KEY\}/$BRAVE_API_KEY}"
MCP_JSON="${MCP_JSON//\$\{HOME\}/$HOME}"

# Rimuove i server con valori vuoti (token non forniti)
if [ -z "$GITHUB_TOKEN" ]; then
  MCP_JSON=$(echo "$MCP_JSON" | jq 'del(.mcpServers.github)')
fi
if [ -z "$DATABASE_URL" ]; then
  MCP_JSON=$(echo "$MCP_JSON" | jq 'del(.mcpServers.postgres)')
fi
if [ -z "$BRAVE_API_KEY" ]; then
  MCP_JSON=$(echo "$MCP_JSON" | jq 'del(.mcpServers["brave-search"])')
fi

# Merge in settings.json
CURRENT=$(cat "$CLAUDE_SETTINGS")
MERGED=$(echo "$CURRENT" | jq --argjson mcp "$MCP_JSON" '. * $mcp')
echo "$MERGED" > "$CLAUDE_SETTINGS"

success "MCP servers configurati."

# Mostra server attivi (senza valori segreti)
info "MCP servers attivi:"
echo "$MERGED" | jq '.mcpServers // {} | keys[]' 2>/dev/null || echo "  nessuno"

log_setup "MCP configurati — tier: $TIER"
