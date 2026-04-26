#!/usr/bin/env bash
set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "${SCRIPT_DIR}/utils.sh"

TIER="${1:-developer}"

step "Installazione plugin Claude Code (tier: $TIER)"

install_plugin() {
  local plugin="$1"
  info "Plugin: $plugin"
  claude plugin install "$plugin" 2>/dev/null && success "  installato: $plugin" || warn "  già presente: $plugin"
}

# Plugin base per tutti
install_plugin "playground@claude-plugins-official"
install_plugin "github@claude-plugins-official"
install_plugin "context7@claude-plugins-official"

# Tier developer e full
if [ "$TIER" = "developer" ] || [ "$TIER" = "full" ]; then
  install_plugin "skill-creator@claude-plugins-official"
fi

success "Plugin installati."
log_setup "Plugin installati — tier: $TIER"
