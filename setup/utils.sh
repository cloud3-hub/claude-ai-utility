#!/usr/bin/env bash
# Funzioni condivise per gli script di setup Cloud3

# Colori ANSI con fallback graceful
if [ -t 1 ]; then
  RED='\033[0;31m'
  GREEN='\033[0;32m'
  YELLOW='\033[1;33m'
  BLUE='\033[0;34m'
  CYAN='\033[0;36m'
  BOLD='\033[1m'
  RESET='\033[0m'
else
  RED='' GREEN='' YELLOW='' BLUE='' CYAN='' BOLD='' RESET=''
fi

info()    { echo -e "${CYAN}[INFO]${RESET} $1"; }
success() { echo -e "${GREEN}[OK]${RESET}   $1"; }
warn()    { echo -e "${YELLOW}[WARN]${RESET} $1"; }
error()   { echo -e "${RED}[ERR]${RESET}  $1" >&2; }
step()    { echo -e "\n${BOLD}${BLUE}▶ $1${RESET}"; }

# Verifica se un comando esiste
has_cmd() { command -v "$1" &>/dev/null; }

# Legge un file di selezione skills (ignora righe vuote e commenti #)
read_skills_file() {
  local file="$1"
  grep -v '^\s*#' "$file" | grep -v '^\s*$'
}

# Sostituisce variabili ${VAR} in un file JSON
# Uso: substitute_vars "file.json" "VAR=valore" "VAR2=valore2"
substitute_vars() {
  local file="$1"
  shift
  local content
  content=$(cat "$file")
  for pair in "$@"; do
    local var="${pair%%=*}"
    local val="${pair#*=}"
    content="${content//\$\{$var\}/$val}"
  done
  echo "$content"
}

# Deep merge di due JSON con jq (arrays concatenati e deduplicati)
merge_json() {
  local base="$1"
  local overlay="$2"
  jq -s '
    .[0] as $base | .[1] as $overlay |
    $base * $overlay |
    if (.permissions.allow? and ($base.permissions.allow? // empty) and ($overlay.permissions.allow? // empty))
    then .permissions.allow = ([$base.permissions.allow[], $overlay.permissions.allow[]] | unique)
    else .
    end
  ' "$base" "$overlay"
}

# Log del setup su file
log_setup() {
  local logfile="${HOME}/.claude/cloud3-setup.log"
  echo "[$(date '+%Y-%m-%d %H:%M:%S')] $1" >> "$logfile"
}
