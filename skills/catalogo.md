# Catalogo Skills Cloud3

## Come usare le skills

Invoca una skill con `/nome-skill` in una sessione Claude Code. Le skills forniscono contesto e workflow specializzati a Claude per quel tipo di task.

---

## CORE — Obbligatorie per tutti

| Skill | Comando | Quando usarla |
|---|---|---|
| Karpathy Guidelines | `/karpathy-guidelines` | Sempre attiva: riduce errori comuni nel codice generato da LLM |
| Using Superpowers | `/using-superpowers` | Prima sessione: scopri come combinare le skills |
| Systematic Debugging | `/systematic-debugging` | Quando un bug non si trova con approcci normali |
| Test Driven Development | `/test-driven-development` | Prima di scrivere qualsiasi nuova funzionalità |
| Writing Plans | `/writing-plans` | Task complessi: scrivi un piano prima di implementare |
| Executing Plans | `/executing-plans` | Per eseguire un piano già definito passo per passo |
| Verification Before Completion | `/verification-before-completion` | Prima di dichiarare un task completato |
| Requesting Code Review | `/requesting-code-review` | Prepara la PR con il giusto contesto per i reviewer |
| Receiving Code Review | `/receiving-code-review` | Quando ricevi feedback su una PR, gestiscilo efficacemente |
| Finishing a Branch | `/finishing-a-development-branch` | Prima di aprire una PR: checklist pre-merge |
| Brainstorming | `/brainstorming` | Quando hai bisogno di esplorare soluzioni alternative |

---

## FRAPPE / ERPNext

| Skill | Comando | Quando usarla |
|---|---|---|
| Frappe App | `/frappe-app` | Scaffolding completo di una nuova app Frappe v15 |
| Frappe DocType | `/frappe-doctype` | Crea DocType con controller, service, validazione, test |
| Frappe Service | `/frappe-service` | Implementa service layer con repository pattern |
| Frappe API | `/frappe-api` | Crea endpoint REST autenticati con validazione |
| Bench Commands | `/bench-commands` | Riferimento rapido: migrate, build, update, test |
| MySQL Best Practices | `/mysql-best-practices` | Ottimizzazione query MariaDB/MySQL per Frappe |

---

## FRONTEND / React

| Skill | Comando | Quando usarla |
|---|---|---|
| Next.js App Router | `/nextjs-app-router-patterns` | App Router, Server Components, streaming, parallel routes |
| shadcn/ui | `/shadcn-ui` | Installazione e personalizzazione componenti shadcn |
| React Components | `/react-components` | Converti design Stitch/Figma in componenti React |
| Designing Beautiful Websites | `/designing-beautiful-websites` | UX strategy, information architecture, layout |
| UI Design Review | `/ui-design-review` | Review estetica, accessibilità, typography, colori |
| Playwright | `/playwright-explore-website` | Testing E2E e automazione browser |
| HTML to PDF | `/html-to-pdf` | Generazione PDF da HTML con supporto italiano/RTL |
| SEO Optimizer | `/seo-optimizer` | Analisi SEO tecnica di pagine HTML/CSS |
| Audit Website | `/audit-website` | Audit completo: SEO, performance, sicurezza, accessibilità |

---

## DEVOPS / Infrastructure

| Skill | Comando | Quando usarla |
|---|---|---|
| GitHub Actions | `/github-actions` | Crea workflow CI/CD, gestione sicurezza pipeline |
| Infrastructure Terraform | `/infrastructure-terraform` | IaC con Terraform, HCL, state management |
| Linux Hardening | `/linux-hardening` | CIS benchmarks, hardening server Ubuntu |
| SSH Hardening | `/ssh-hardening` | Config SSH sicura, disable root login |
| Hetzner Server | `/hetzner-server` | Crea e gestisci VPS Hetzner Cloud |
| Firewall Configuration | `/firewall-configuration` | UFW su Ubuntu/Debian |
| Grafana Dashboards | `/grafana-dashboards` | Dashboard produzione per metriche real-time |
| PostgreSQL Table Design | `/postgresql-table-design` | Progettazione tabelle ottimizzate, indexing, relazioni |
| Git Worktrees | `/using-git-worktrees` | Lavora su più branch in parallelo con worktree |

---

## AGENTI / Workflow Avanzato

| Skill | Comando | Quando usarla |
|---|---|---|
| Dispatching Parallel Agents | `/dispatching-parallel-agents` | Orchestra più agenti Claude su task indipendenti |
| Subagent Driven Development | `/subagent-driven-development` | Sviluppo guidato da subagenti specializzati |

---

## MARKETING / CONTENUTI

Utili per i siti statici (adhocoil.com, toscoleum) e comunicazione.

| Skill | Comando | Quando usarla |
|---|---|---|
| Copywriting | `/copywriting` | Testi conversione landing page ed email marketing |
| Page CRO | `/page-cro` | Ottimizzazione tasso conversione di landing page |
| Clone Website | `/clone-website` | Replica/prototipa siti in Next.js partendo da URL |
| Brand Voice Learner | `/brand-voice-learner` | Estrae tone of voice da contenuti esistenti |
| Enhance Prompt | `/enhance-prompt` | Trasforma idee UI vaghe in prompt Stitch/AI ottimizzati |
| Web Artifacts Builder | `/web-artifacts-builder` | Crea artifact HTML complessi con React/Tailwind |
| DOCX | `/docx` | Genera e modifica documenti Word da Claude |

---

## MEMORIA

| Skill | Comando | Quando usarla |
|---|---|---|
| Super Search | `/super-search` | Cerca nel tuo archivio memoria Supermemory |
| Super Save | `/super-save` | Salva informazioni nella memoria persistente |

> Nota: le skill Supermemory richiedono account e API key configurata. Vedi `docs/mcp-setup.md`.

---

## Skills rimosse (non pertinenti allo stack Cloud3)

| Skill | Motivo rimozione |
|---|---|
| `remotion`, `remotion-best-practices` | Generazione video, non nel nostro stack |
| `gsap-awwwards-website` | Landing page SPYLT-specifica, troppo di nicchia |
| `tauri-v2` | Desktop app con Rust, non pertinente |
| `rust-best-practices` | Nessun progetto Rust attivo |
| `business-central-development` | Microsoft Dynamics, concorrente di Frappe |
| `microsoft-foundry` | Azure AI Foundry, non in uso |
| `stitch-design`, `stitch-loop`, `taste-design`, `design-md` | Piattaforma Google Stitch, non in uso |
