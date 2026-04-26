#!/usr/bin/env bash
set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "${SCRIPT_DIR}/utils.sh"

step "Verifica prerequisiti"

ERRORS=0

# Node.js >= 18
if has_cmd node; then
  NODE_VER=$(node -e "process.exit(parseInt(process.version.slice(1)) < 18 ? 1 : 0)" 2>/dev/null && echo "ok" || echo "old")
  if [ "$NODE_VER" = "ok" ]; then
    success "Node.js $(node --version)"
  else
    error "Node.js trovato ma versione < 18. Aggiorna: https://nodejs.org"
    ERRORS=$((ERRORS+1))
  fi
else
  error "Node.js non trovato. Installa: https://nodejs.org (>= 18)"
  ERRORS=$((ERRORS+1))
fi

# npm >= 9
if has_cmd npm; then
  NPM_MAJOR=$(npm --version | cut -d. -f1)
  if [ "$NPM_MAJOR" -ge 9 ]; then
    success "npm $(npm --version)"
  else
    warn "npm versione $(npm --version) < 9. Aggiorna: npm install -g npm@latest"
  fi
fi

# Claude CLI
if has_cmd claude; then
  success "Claude CLI $(claude --version 2>/dev/null | head -1)"
else
  error "Claude CLI non trovata. Installa: npm install -g @anthropic-ai/claude-code"
  ERRORS=$((ERRORS+1))
fi

# git
if has_cmd git; then
  GIT_NAME=$(git config --global user.name 2>/dev/null || echo "")
  GIT_EMAIL=$(git config --global user.email 2>/dev/null || echo "")
  if [ -z "$GIT_NAME" ] || [ -z "$GIT_EMAIL" ]; then
    warn "git trovato ma user.name/email non configurati."
    warn "  git config --global user.name 'Nome Cognome'"
    warn "  git config --global user.email 'email@cloud3.srl'"
  else
    success "git $(git --version | awk '{print $3}') — $GIT_NAME <$GIT_EMAIL>"
  fi
else
  error "git non trovato."
  ERRORS=$((ERRORS+1))
fi

# jq (per merge JSON)
if has_cmd jq; then
  success "jq $(jq --version)"
else
  error "jq non trovato. Installa: brew install jq"
  ERRORS=$((ERRORS+1))
fi

# npx (per skills)
if has_cmd npx; then
  success "npx disponibile"
else
  warn "npx non trovato — installalo con Node.js"
fi

echo ""
if [ "$ERRORS" -gt 0 ]; then
  error "Trovati $ERRORS prerequisiti mancanti. Risolvili prima di continuare."
  exit 1
else
  success "Tutti i prerequisiti soddisfatti."
fi
