#!/usr/bin/env bash
set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_DIR="$(dirname "$SCRIPT_DIR")"
source "${SCRIPT_DIR}/utils.sh"

TIER="${1:-developer}"
ROLE="${2:-}"  # opzionale: frappe, frontend, devops

step "Installazione skills (tier: $TIER)"

install_skills_from_file() {
  local file="$1"
  local label="$2"
  if [ ! -f "$file" ]; then
    warn "File skills non trovato: $file"
    return
  fi
  info "Installazione skills $label..."
  while IFS= read -r skill; do
    if [ -n "$skill" ]; then
      info "  → $skill"
      npx skills add "$skill" -g -y 2>/dev/null && success "    installata: $skill" || warn "    già presente o errore: $skill"
    fi
  done < <(read_skills_file "$file")
}

# Core sempre
install_skills_from_file "${REPO_DIR}/skills/selections/skills.core.txt" "core"

# Per ruolo specifico
case "$ROLE" in
  frappe)
    install_skills_from_file "${REPO_DIR}/skills/selections/skills.frappe.txt" "Frappe/ERPNext"
    ;;
  frontend)
    install_skills_from_file "${REPO_DIR}/skills/selections/skills.frontend.txt" "Frontend/React"
    ;;
  devops)
    install_skills_from_file "${REPO_DIR}/skills/selections/skills.devops.txt" "DevOps"
    ;;
  all)
    install_skills_from_file "${REPO_DIR}/skills/selections/skills.frappe.txt" "Frappe/ERPNext"
    install_skills_from_file "${REPO_DIR}/skills/selections/skills.frontend.txt" "Frontend/React"
    install_skills_from_file "${REPO_DIR}/skills/selections/skills.devops.txt" "DevOps"
    ;;
  "")
    # Nessun ruolo specificato: chiede interattivamente
    echo ""
    echo "Seleziona il tuo ruolo principale (puoi sceglierne più di uno):"
    echo "  [1] Frappe/ERPNext developer"
    echo "  [2] Frontend/React developer"
    echo "  [3] DevOps/Infrastructure"
    echo "  [4] Tutti (lead/senior)"
    echo "  [0] Solo core"
    read -rp "Scelta (es: 1 2 oppure 4): " roles
    for r in $roles; do
      case "$r" in
        1) install_skills_from_file "${REPO_DIR}/skills/selections/skills.frappe.txt" "Frappe/ERPNext" ;;
        2) install_skills_from_file "${REPO_DIR}/skills/selections/skills.frontend.txt" "Frontend/React" ;;
        3) install_skills_from_file "${REPO_DIR}/skills/selections/skills.devops.txt" "DevOps" ;;
        4)
          install_skills_from_file "${REPO_DIR}/skills/selections/skills.frappe.txt" "Frappe/ERPNext"
          install_skills_from_file "${REPO_DIR}/skills/selections/skills.frontend.txt" "Frontend/React"
          install_skills_from_file "${REPO_DIR}/skills/selections/skills.devops.txt" "DevOps"
          break
          ;;
      esac
    done
    ;;
esac

success "Installazione skills completata."
log_setup "Skills installate — tier: $TIER, ruolo: ${ROLE:-interattivo}"
