# Onboarding Claude Code — Cloud3

## Setup iniziale (5 minuti)

### 1. Clona il kit

```bash
git clone https://github.com/cloud3-hub/claude-ai-utility.git ~/Claude/claude-ai-utility
cd ~/Claude/claude-ai-utility
```

### 2. Installa i prerequisiti mancanti (macOS)

```bash
# Node.js >= 18
brew install node

# Claude Code CLI
npm install -g @anthropic-ai/claude-code

# jq per merge JSON
brew install jq

# Configura git se non l'hai fatto
git config --global user.name "Nome Cognome"
git config --global user.email "nome@cloud3.srl"
```

### 3. Esegui il setup

```bash
chmod +x setup.sh
./setup.sh
```

Lo script ti chiederà:
- **Tier**: scegli `Developer` (opzione 2) se non sei sicuro
- **Ruolo**: seleziona `Frappe` se lavori su ERPNext, `Frontend` per React, o entrambi
- **GitHub Token**: vai su github.com/settings/tokens, crea un token con scope `repo, read:org`
- **DATABASE_URL**: la stringa di connessione al tuo PostgreSQL locale (se ne hai uno)

### 4. Riavvia Claude Code

Chiudi e riapri Claude Code. Le skills e i plugin saranno disponibili.

---

## Prima sessione

Apri Claude Code e digita:

```
/using-superpowers
```

Questo ti mostrerà come usare tutte le skills installate.

### Skills essenziali da conoscere

```
/karpathy-guidelines    → sempre utile prima di scrivere codice complesso
/systematic-debugging   → quando un bug non si trova
/writing-plans          → prima di un task complesso, scrivi un piano
/frappe-doctype         → crea un DocType Frappe completo
/nextjs-app-router-patterns → pattern moderni Next.js App Router
```

---

## Workflow tipico per una feature

```
1. Apri il progetto in Claude Code
2. /writing-plans → crea il piano della feature
3. Implementa step by step
4. /test-driven-development → scrivi i test
5. /verification-before-completion → checklist pre-PR
6. /requesting-code-review → prepara la PR con contesto
```

---

## MCP Servers: cosa puoi fare

Con i MCP server configurati (tier Developer+):

**GitHub MCP**: invece di aprire GitHub nel browser:
```
Leggi le ultime 5 PR aperte su cloud3srl/app-frantoi
Crea una issue per il bug trovato in ConfigurazioneAziende
```

**PostgreSQL MCP**: query dirette sul DB locale:
```
Mostra le ultime 10 movimentazioni del magazzino
Quanti utenti attivi ci sono nel sistema?
```

**Filesystem MCP**: navigazione file senza path manuali:
```
Trova tutti i file TypeScript che usano il hook useAuth
```

---

## Domande frequenti

**Q: Posso aggiungere il mio GITHUB_TOKEN in seguito?**
A: Sì, riesegui: `bash setup/configure-mcp.sh developer`

**Q: Come aggiorno le skills quando esce una nuova versione del kit?**
A: `git pull && ./setup.sh` — è idempotente, aggiunge solo le novità.

**Q: Ho già una configurazione Claude Code. Il setup la sovrascrive?**
A: No. Il setup fa un merge intelligente che preserva le tue configurazioni custom. Un backup viene salvato automaticamente in `~/.claude/settings.backup.YYYYMMDD.json`.

**Q: Come aggiungo permessi per un comando specifico del mio progetto?**
A: Crea un file `.claude/settings.json` nella root del progetto (non in `~/.claude/`). I permessi specifici del progetto si sommano a quelli globali.

---

Vedi anche: `docs/workflow-guide.md`, `docs/mcp-setup.md`, `docs/troubleshooting.md`
