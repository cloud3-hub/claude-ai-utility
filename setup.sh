#!/usr/bin/env bash
set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "${SCRIPT_DIR}/setup/utils.sh"

# ─────────────────────────────────────────────
# BANNER
# ─────────────────────────────────────────────
echo ""
echo -e "${BOLD}${BLUE}╔════════════════════════════════════════╗${RESET}"
echo -e "${BOLD}${BLUE}║   Claude AI Utility Kit — Cloud3       ║${RESET}"
echo -e "${BOLD}${BLUE}╚════════════════════════════════════════╝${RESET}"
echo ""
info "Setup idempotente: sicuro da rieseguire più volte."
echo ""

# ─────────────────────────────────────────────
# 1. Prerequisiti
# ─────────────────────────────────────────────
bash "${SCRIPT_DIR}/setup/check-prereqs.sh"

# ─────────────────────────────────────────────
# 2. Selezione tier
# ─────────────────────────────────────────────
echo ""
step "Selezione tier di configurazione"
echo ""
echo "  ${BOLD}[1] Base${RESET}       — Developer nuovo, configurazione minima"
echo "  ${BOLD}[2] Developer${RESET}  — DB + GitHub + Docker (raccomandato)"
echo "  ${BOLD}[3] Full${RESET}       — Senior/Lead, tutti gli strumenti"
echo ""
read -rp "  Tier [1/2/3] (default: 2): " TIER_CHOICE

case "$TIER_CHOICE" in
  1) TIER="base" ;;
  3) TIER="full" ;;
  *) TIER="developer" ;;
esac

success "Tier selezionato: ${BOLD}$TIER${RESET}"

# ─────────────────────────────────────────────
# 3. Plugin
# ─────────────────────────────────────────────
bash "${SCRIPT_DIR}/setup/install-plugins.sh" "$TIER"

# ─────────────────────────────────────────────
# 4. Skills
# ─────────────────────────────────────────────
bash "${SCRIPT_DIR}/setup/install-skills.sh" "$TIER"

# ─────────────────────────────────────────────
# 5. Settings
# ─────────────────────────────────────────────
bash "${SCRIPT_DIR}/setup/apply-settings.sh" "$TIER"

# ─────────────────────────────────────────────
# 6. MCP Servers
# ─────────────────────────────────────────────
echo ""
read -rp "  Configurare MCP servers (GitHub, PostgreSQL, ecc.)? [S/n]: " CONFIGURE_MCP
if [[ "$CONFIGURE_MCP" != "n" && "$CONFIGURE_MCP" != "N" ]]; then
  bash "${SCRIPT_DIR}/setup/configure-mcp.sh" "$TIER"
else
  warn "MCP servers saltati. Esegui manualmente: bash setup/configure-mcp.sh $TIER"
fi

# ─────────────────────────────────────────────
# 7. Report finale
# ─────────────────────────────────────────────
echo ""
echo -e "${BOLD}${GREEN}╔════════════════════════════════════════╗${RESET}"
echo -e "${BOLD}${GREEN}║   Setup completato con successo!       ║${RESET}"
echo -e "${BOLD}${GREEN}╚════════════════════════════════════════╝${RESET}"
echo ""
info "Prossimi passi:"
echo "  1. Riavvia Claude Code per applicare le modifiche"
echo "  2. Esegui /using-superpowers per scoprire le skills installate"
echo "  3. Leggi docs/onboarding.md per la guida completa"
echo ""
info "Documentazione: ${SCRIPT_DIR}/docs/onboarding.md"

log_setup "Setup completato — tier: $TIER — macchina: $(hostname)"
