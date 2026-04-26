#!/usr/bin/env bash
set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_DIR="$(dirname "$SCRIPT_DIR")"
source "${SCRIPT_DIR}/utils.sh"

TIER="${1:-developer}"
SETTINGS_FILE="${REPO_DIR}/settings/settings.${TIER}.json"
CLAUDE_SETTINGS="${HOME}/.claude/settings.json"

step "Applicazione settings (tier: $TIER)"

if [ ! -f "$SETTINGS_FILE" ]; then
  error "File settings non trovato: $SETTINGS_FILE"
  error "Tier validi: base, developer, full"
  exit 1
fi

# Backup settings esistenti
if [ -f "$CLAUDE_SETTINGS" ]; then
  BACKUP="${HOME}/.claude/settings.backup.$(date '+%Y%m%d_%H%M%S').json"
  cp "$CLAUDE_SETTINGS" "$BACKUP"
  success "Backup settings: $BACKUP"
fi

# Crea settings.json se non esiste
if [ ! -f "$CLAUDE_SETTINGS" ]; then
  echo '{}' > "$CLAUDE_SETTINGS"
  info "Creato nuovo settings.json"
fi

# Deep merge: settings esistenti + nuovo tier
MERGED=$(merge_json "$CLAUDE_SETTINGS" "$SETTINGS_FILE")

if [ -z "$MERGED" ]; then
  error "Errore nel merge JSON. Verifica che jq sia installato e i file siano validi."
  exit 1
fi

echo "$MERGED" > "$CLAUDE_SETTINGS"
success "Settings applicati ($TIER)."
log_setup "Settings applicati — tier: $TIER"

# Mostra riepilogo (senza segreti)
info "Riepilogo settings applicati:"
echo "$MERGED" | jq '{model, "plugins": (.enabledPlugins // {}| keys), "permissions_count": (.permissions.allow // [] | length)}'
