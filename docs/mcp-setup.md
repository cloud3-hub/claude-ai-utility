# Guida MCP Servers

## Cos'è un MCP Server

MCP (Model Context Protocol) è il protocollo che permette a Claude di connettersi a strumenti esterni: database, API, file system, servizi web. Con un MCP server attivo, puoi chiedere a Claude di fare query SQL, gestire GitHub, fare ricerche web — tutto senza uscire dalla sessione.

## MCP Servers inclusi nel kit

### GitHub MCP
Gestisce repository, PR, issues, code review direttamente da Claude.

**Prerequisiti**: Personal Access Token su github.com/settings/tokens
- Scope: `repo`, `read:org`, `read:user`

**Esempi d'uso**:
```
Mostrami le PR aperte su questo repo
Crea una issue: "Bug nel calcolo delle commissioni"
Cerca nei commit le modifiche al file MovimentiController
```

---

### PostgreSQL MCP
Query dirette sul database PostgreSQL locale.

**Prerequisiti**: PostgreSQL installato e accessibile
- Format URL: `postgresql://utente:password@localhost:5432/nome_db`

**Esempi d'uso**:
```
Mostrami lo schema della tabella movimenti
Quante aziende sono registrate nel sistema?
Trova i record con data_creazione nell'ultima settimana
```

> Usa solo su DB di sviluppo locale. MAI su database di produzione.

---

### Filesystem MCP
Navigazione e lettura file nelle directory configurate.

**Cartelle accessibili** (configurate in setup):
- `~/Projects` — tutti i progetti
- `~/Claude` — repository Claude e kit

**Esempi d'uso**:
```
Trova tutti i file .ts che importano useAuth
Mostrami i file modificati di recente in app-frantoi
Cerca "TODO" in tutti i file Python del progetto
```

---

### Puppeteer MCP
Automazione browser: screenshot, scraping, testing.

**Prerequisiti**: nessuno (si installa automaticamente via npx)

**Esempi d'uso**:
```
Fai uno screenshot della homepage di cloud3.srl
Verifica che la pagina di login risponda correttamente
Testa il form di contatto su localhost:3000
```

---

### Brave Search MCP
Ricerca web in tempo reale (tier Full).

**Prerequisiti**: API Key da brave.com/search/api/
- Piano gratuito: 2.000 query/mese
- Piano base: $3/mese per 20.000 query

**Esempi d'uso**:
```
Cerca la documentazione più recente di Frappe v15
Trova esempi di implementazione di questo pattern in React
Cerca errori comuni con questa versione di PostgreSQL
```

---

## Aggiungere un MCP server personalizzato

Per aggiungere un MCP server non incluso nel kit (es. per un progetto specifico):

1. Aggiungi la configurazione direttamente in `~/.claude/settings.json`:

```json
{
  "mcpServers": {
    "mio-server": {
      "command": "node",
      "args": ["/path/al/mio/mcp-server/index.js"]
    }
  }
}
```

2. Oppure crea un `.claude/settings.json` nella root del progetto specifico.

---

## Troubleshooting MCP

**MCP server non si avvia**
```bash
# Testa il server manualmente
npx -y @modelcontextprotocol/server-github
```

**GitHub MCP: errore autenticazione**
- Verifica che il token non sia scaduto
- Controlla gli scope del token su github.com/settings/tokens
- Rigenera il token e riesegui `bash setup/configure-mcp.sh developer`

**PostgreSQL MCP: connessione rifiutata**
- Verifica che PostgreSQL sia in esecuzione: `pg_isready`
- Controlla il formato della DATABASE_URL: `postgresql://user:pass@localhost:5432/db`
- Testa la connessione: `psql "$DATABASE_URL" -c "SELECT 1"`
