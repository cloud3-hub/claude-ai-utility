# Claude AI Utility Kit — Cloud3

Kit pronto all'uso per configurare Claude Code in modo ottimale su qualsiasi macchina del team.

## Quick Start

```bash
git clone https://github.com/cloud3-hub/claude-ai-utility.git
cd claude-ai-utility
chmod +x setup.sh
./setup.sh
```

Un solo script installa skills, plugin, MCP servers e applica i settings ottimizzati per il tuo ruolo.

## Cosa include

| Componente | Descrizione |
|---|---|
| **Skills** | Selezione curata di ~30 skills divise per ruolo (core, Frappe, frontend, devops) |
| **MCP Servers** | Template configurazione GitHub, PostgreSQL, Filesystem, Brave Search, Puppeteer |
| **Settings** | 3 tier di configurazione: base, developer, full |
| **Plugin** | playground, github, context7, skill-creator |
| **CLAUDE.md** | Contesto aziendale Cloud3 per Claude Code |

## Tier di Setup

```
[1] Base      → Developer nuovo / configurazione minima
[2] Developer → DB + GitHub + Docker (raccomandato)
[3] Full      → Senior/Lead, tutti gli strumenti
```

## Struttura Repository

```
claude-ai-utility/
├── setup.sh                    # Punto di ingresso unico
├── setup/                      # Script modulari
│   ├── check-prereqs.sh
│   ├── install-skills.sh
│   ├── install-plugins.sh
│   ├── configure-mcp.sh
│   ├── apply-settings.sh
│   └── utils.sh
├── settings/                   # Template settings per tier
│   ├── settings.base.json
│   ├── settings.developer.json
│   └── settings.full.json
├── mcp/                        # Template MCP servers
│   ├── templates/
│   └── compose/
├── skills/                     # Catalogo e selezioni skills
│   ├── catalogo.md
│   └── selections/
├── docs/                       # Guide e documentazione
│   ├── onboarding.md
│   ├── workflow-guide.md
│   ├── mcp-setup.md
│   └── troubleshooting.md
├── examples/                   # Esempi workflow
└── CLAUDE.md                   # Istruzioni aziendali per Claude Code
```

## Prerequisiti

- **Node.js** >= 18 e npm >= 9
- **Claude Code** CLI installata (`npm install -g @anthropic-ai/claude-code`)
- **git** configurato con user.name e user.email
- **jq** installato (`brew install jq` su macOS)

## Aggiornamento

Per aggiornare skills e configurazioni dopo un update del kit:

```bash
git pull
./setup.sh  # idempotente: aggiunge solo le novità senza sovrascrivere config custom
```

## Contribuire

Per proporre nuove skills, MCP servers o migliorare le guide apri una PR su questo repository.

---

Mantenuto dal team Cloud3 · [cloud3.srl](https://cloud3.srl)
