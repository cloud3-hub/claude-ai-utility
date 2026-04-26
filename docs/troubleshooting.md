# Troubleshooting

## Problemi comuni dopo il setup

### "Unknown skill: nome-skill"

La skill è installata ma Claude Code non la vede nella sessione attuale.

**Soluzione**: riavvia Claude Code. Le skills vengono caricate all'avvio.

```bash
# Verifica che la skill sia installata
ls ~/.agents/skills/ | grep nome-skill
```

---

### "jq: command not found" durante il setup

```bash
# macOS
brew install jq

# Ubuntu/Debian
sudo apt-get install jq
```

---

### Il setup sovrascrive le mie configurazioni custom

Non dovrebbe — il setup fa un merge intelligente. Se è successo:

```bash
# Trova il backup automatico
ls ~/.claude/settings.backup.*.json

# Ripristina il backup
cp ~/.claude/settings.backup.YYYYMMDD_HHMMSS.json ~/.claude/settings.json
```

---

### Claude non ha i permessi per eseguire un comando

Il comando non è nell'allowlist del tier configurato.

**Soluzione A**: aggiungi il permesso al settings globale:
```json
// ~/.claude/settings.json
{
  "permissions": {
    "allow": ["Bash(il-tuo-comando *)"]
  }
}
```

**Soluzione B**: crea un `.claude/settings.json` nella root del progetto specifico con il permesso.

---

### MCP Server "github" non risponde

1. Verifica il token: `echo $GITHUB_PERSONAL_ACCESS_TOKEN` → deve essere valorizzato
2. Controlla i scope del token su github.com/settings/tokens
3. Rigenera il token e riesegui: `bash setup/configure-mcp.sh developer`

---

### npx skills — errore di rete

```bash
# Verifica connessione
npx skills find test

# Se usi proxy aziendale
export HTTPS_PROXY=http://proxy.cloud3.srl:8080
npx skills find test
```

---

### "claude: command not found" dopo installazione

```bash
# Verifica che npm global bin sia nel PATH
npm config get prefix
# Aggiungi al ~/.zshrc o ~/.bash_profile:
export PATH="$(npm config get prefix)/bin:$PATH"
source ~/.zshrc
```

---

## Rieseguire il setup parzialmente

Il setup è modulare. Puoi rieseguire solo le parti che ti servono:

```bash
# Solo skills
bash setup/install-skills.sh developer

# Solo MCP servers (ri-chiede le credenziali)
bash setup/configure-mcp.sh developer

# Solo settings
bash setup/apply-settings.sh developer

# Solo prerequisiti
bash setup/check-prereqs.sh
```

---

## Segnalare un problema

Apri una issue su `github.com/cloud3srl/claude-ai-utility` con:
- Output del comando che ha fallito
- Versioni: `node --version`, `claude --version`, `jq --version`
- Sistema operativo e versione
