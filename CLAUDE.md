# Claude Code — Istruzioni Cloud3

## Identità e Contesto

Stai lavorando con il team di sviluppo **Cloud3** (Cloud3.srl, web@cloud3.srl).
- **Lingua primaria**: Italiano per comunicazioni, commit, documentazione
- **Lingua tecnica**: Inglese per codice, variabili, commenti inline
- **Stile risposta**: conciso, diretto, senza riepiloghi inutili a fine turno

## Stack Tecnologico

### Backend
- **Frappe Framework v15** + ERPNext su Python 3.11+
- Database: **MariaDB** (Frappe) / **PostgreSQL** (progetti custom Node.js)
- API: REST via `frappe.whitelist()` + Express.js per progetti standalone

### Frontend
- **React 18+** con **TypeScript**, **Tailwind CSS**
- Component library: **shadcn/ui**
- Routing: **Next.js App Router** (app standalone) / React Router (PWA)
- Build tool: Vite (per app embedded in Frappe)

### Infrastruttura
- OS target deploy: Ubuntu 22.04 LTS
- Container: Docker + docker-compose
- IaC: Terraform (provider Hetzner Cloud)
- Process manager: PM2 per Node.js, bench per Frappe

## Convenzioni di Codice

### Python / Frappe
- PEP8, max 100 caratteri per riga
- Type hints su tutti i metodi pubblici
- Pattern obbligatorio: **Controller → Service → Repository**
- Nessuna logica di business nel controller
- Docstring in italiano per metodi business-critical

### TypeScript / React
- ESLint + Prettier con config di progetto
- Componenti funzionali con hooks, mai class components
- Named exports preferiti su default exports
- Props tipizzate con `interface`, non `type` alias

### Database
- Migration files sempre versionati (Prisma migrate / bench migrate)
- Zero query SQL raw senza sanitizzazione
- Per Frappe: ORM nativo, no SQL diretto
- Per PostgreSQL: Prisma ORM o query parametrizzate

## Git Workflow

- Branch principale: `main`
- Feature: `feature/TICKET-numero-descrizione`
- Hotfix: `hotfix/TICKET-numero`
- Commit: italiano, imperativo presente, max 72 caratteri
- Pre-PR: `npm test` / `bench run-tests` devono passare

## MCP Servers Disponibili

Con setup tier developer o superiore:
- **github**: gestione repo, PR, issues senza uscire da Claude
- **postgres**: query dirette su DB locale di sviluppo
- **filesystem**: accesso a `~/Projects` e `~/Claude`
- **puppeteer** (developer+): automazione browser, screenshot, scraping
- **brave-search** (full): ricerca web aggiornata in tempo reale

## Skills Attive

Skills raccomandate per sessioni Cloud3:
- `/karpathy-guidelines` — sempre valida come guida al coding
- `/frappe-app`, `/frappe-doctype`, `/frappe-service`, `/frappe-api`
- `/nextjs-app-router-patterns`, `/shadcn-ui`
- `/bench-commands` — riferimento rapido comandi bench
- `/systematic-debugging` — per sessioni di debug strutturato

## Regole Operative

1. **Non modificare file di produzione** senza conferma esplicita
2. **Chiedi prima di installare** nuove dipendenze (npm install, pip install)
3. **Segnala** quando un'operazione richiede permessi elevati (sudo, ssh)
4. **Testa localmente** prima di proporre qualsiasi push o merge
5. **Documenta in italiano** ogni decisione architetturale significativa
6. **Non aggiungere commenti** che spiegano il "cosa" — solo il "perché" non ovvio

## Struttura Progetto Tipo

```
progetto-cloud3/
├── CLAUDE.md              # Contesto specifico del progetto (estende questo)
├── apps/                  # App Frappe custom
├── frontend/              # React/Next.js standalone
├── infrastructure/        # Terraform, docker-compose
├── docs/                  # Documentazione tecnica
└── scripts/               # Script di automazione
```

## Riferimenti

- Kit Claude Code: `github.com/cloud3srl/claude-ai-utility`
- Docs Frappe: `docs.frappe.io`
- Stack overflow interno: usare GitHub Issues del progetto specifico
