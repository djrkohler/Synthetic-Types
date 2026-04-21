# Synthetic Types — Research Toolkit

**ABK Stuttgart · SS2026 · Prof. Daniel Koehler**
**Studio "Synthetische Typen / Modelling Models"**
**AM Kristof Gavrielides, KTL Volker Menke**

---

## Was ist das? / What is this?

Dieses Toolkit verwandelt **Claude Code** in einen Forschungsbegleiter, der mit euch recherchiert, Verbindungen entdeckt und strukturierte Dokumente erstellt. Es ist kein Berichts-Generator — es ist ein Denkwerkzeug.

This toolkit turns **Claude Code** into a research companion that investigates alongside you, discovers connections, and produces structured documents. It is not a report generator — it is a thinking tool.

Ihr koennt auf Deutsch oder Englisch arbeiten. / You can work in German or English.

---

## Table of Contents

- [Installation](#installation)
- [Quick Start](#quick-start)
- [Commands](#commands)
- [Tutorials](#tutorials)
  - [1. Open up a new topic — `/explore`](#1-open-up-a-new-topic--explore)
  - [2. Go deep on anything — `/research`](#2-go-deep-on-anything--research)
  - [3. Map your research — `/connections`](#3-map-your-research--connections)
  - [4. Write a synthesis — `/connections-report`](#4-write-a-synthesis--connections-report)
  - [5. Multi-track deep dive — `/orchestrate`](#5-multi-track-deep-dive--orchestrate)
  - [6. A full research arc](#6-a-full-research-arc)
- [Visual Outputs](#visual-outputs)
- [Using Research in NotebookLM](#using-research-in-notebooklm)
- [Tips for Better Research](#tips-for-better-research)
- [Folder Structure](#folder-structure)
- [Troubleshooting](#troubleshooting)

---

## Installation

The simplest path is **Claude Desktop + Claude Code** — no terminal workflow required beyond one `git clone`.

### What You Need

| Requirement | Why | Where to get it |
|-------------|-----|-----------------|
| **Claude Pro or Max** | Powers the research companion | [claude.ai](https://claude.ai) (~$20/month) |
| **Claude Desktop** | Runs Claude Code and loads this project's skills | [claude.ai/download](https://claude.ai/download) |
| **Git** | Cloning the toolkit | [git-scm.com](https://git-scm.com) |
| **Node.js 18+ LTS** | Powers the MCP servers (YouTube, Playwright) | [nodejs.org](https://nodejs.org) |

### Step 1: Install Claude Desktop and sign in

Download from [claude.ai/download](https://claude.ai/download), install, and sign in with your Claude Pro/Max account.

### Step 2: Clone the toolkit

Open a terminal (Terminal on macOS, PowerShell on Windows) and clone the repo into a location of your choice:

```bash
git clone https://github.com/djrkohler/Synthetic-Types.git
cd Synthetic-Types
```

Run the setup script once — it installs the Playwright browser and (optionally) yt-dlp:

**macOS / Linux:**
```bash
./setup.sh
```

**Windows:**
```powershell
powershell -ExecutionPolicy Bypass -File setup.ps1
```

### Step 3: Open the project in Claude Code

In Claude Desktop, open the **Claude Code** panel and point it at the `Synthetic-Types` folder you just cloned. That loads the project's skills and slash commands automatically.

Type `/` to see the available commands. If you see `/explore`, `/research`, `/connections`, `/connections-report`, and `/orchestrate`, you're ready.

---

## Quick Start

With the `Synthetic-Types` project open in Claude Code, try:

```
/explore "Stampflehm"
```

Claude branches out in 5-8 directions, finds YouTube videos, generates provocations. Read the output, then follow what interests you:

```
/research "rammed earth supply chain in Germany"
```

After a few research sessions, map the connections:

```
/connections
```

Open the HTML map in your browser. Click nodes, Ctrl+click to select several, then "Copy for Report" and paste back into Claude to generate a synthesis essay.

---

## Commands

There are **5 commands**. Type them in Claude Code. You can also talk to Claude freely — ask questions, discuss ideas, request summaries, argue, change direction.

| Command | What it does | Example |
|---------|-------------|---------|
| `/explore` | Brainstorm, branch out, find surprising connections | `/explore "Holz und Politik"` |
| `/research` | Deep research — auto-detects the right approach | `/research "rammed earth Germany"` |
| `/connections` | Map patterns across all your research | `/connections` |
| `/connections-report` | Write a synthesis from selected map nodes | `/connections-report [paste]` |
| `/orchestrate` | 6 parallel research tracks on one topic | `/orchestrate "Schaumglas"` |

### `/explore` — Open up a topic

Produces a **map of possibilities**, not a finished report. Branches out across domains (politics, history, art, science, ecology), finds YouTube videos, generates "what if" provocations. **Start here when you have a new idea.**

### `/research` — Go deep on anything

The workhorse command. It reads your question and **auto-detects** the right approach:

| You type... | Claude does... |
|-------------|---------------|
| `/research "rammed earth Germany"` | Broad multi-source research (10-15 sources) |
| `/research "https://youtube.com/watch?v=..."` | Deep video analysis with transcript + timestamps |
| `/research "embodied carbon CLT vs concrete"` | Scientific mode: data tables, evidence grading |
| `/research "Brettsperrholz supply chain"` | Supply chain tracing: origin to site |
| `/research "robotic timber assembly papers"` | Academic literature with citation networks |

You never need to pick a mode — just ask naturally.

### `/connections` — See the big picture

Reads all your research documents and generates an **interactive map** showing how they connect. Requires 3+ research documents to be useful.

### `/connections-report` — Write from your map

Select nodes on the connection map, click "Copy for Report", paste into Claude. Produces a 1,500-3,000 word synthesis essay.

### `/orchestrate` — Go wide

Launches 6 parallel research tracks (supply chain, history, state-of-the-art, policy, ecology, adjacent fields). Most powerful command. Produces 7+ documents.

---

## Tutorials

Six short walk-throughs, one per command plus a full-arc example.

### 1. Open up a new topic — `/explore`

You're interested in foam glass but don't know much about it.

```
/explore "Schaumglas"
```

Claude branches out in 5–8 directions (production from waste glass, thermal properties, visible surface vs. hidden insulation, market players, circularity) with sources, YouTube links, and provocations for each branch.

Follow what interests you with a free-form question — no slash command needed:

```
That foam glass surface idea is interesting — it looks like pumice.
Can it be an architectural surface instead of hidden insulation?
```

**Output:** `research/explore-schaumglas-[date].md` — a springboard, not a finished paper.

---

### 2. Go deep on anything — `/research`

One command, four behaviours. Claude auto-detects from how you phrase the question:

| You ask... | Mode it picks | What you get |
|---|---|---|
| `/research "https://youtube.com/watch?v=..."` | **Video** | Full transcript (5 fallback methods), timestamped findings, uncertainty flagged, cross-referenced against published sources. 1,500–3,000 words. |
| `/research "compressive strength rammed earth vs concrete — test data"` | **Scientific** | Data tables with units, evidence rated Strong/Moderate/Weak/Contested, gaps explicit. |
| `/research "Brettsperrholz supply chain from Austrian forest to Stuttgart"` | **Supply chain** | Origin → transformation → actors → economics → ecology → end-of-life → politics, as a narrative. |
| `/research "robotic timber assembly — who is publishing the key papers?"` | **Literature** | 5–8 key papers with citations, abstracts, author clusters, debates, gaps in the field. |
| `/research "rammed earth in Germany"` | **General** | Broad multi-source investigation, 10–15 diverse sources. |

You never pick a mode. Phrase the question naturally — a URL means video, a quantitative question triggers scientific mode, "supply chain" triggers the supply chain pass.

**Tip:** precise questions get precise answers. "Is rammed earth sustainable?" drifts. "Measured embodied carbon values (kg CO₂e/m³) for unstabilized rammed earth vs. concrete block walls in Central European studies after 2018" doesn't.

**Output:** `research/[mode]-[topic]-[date].md`.

---

### 3. Map your research — `/connections`

Once you have 5+ research documents, map them:

```
/connections
```

Claude reads everything under `research/` recursively, extracts shared concepts, and produces:
- **Interactive HTML map** → `research/maps/connections-map-[date].html`
- **Narrative document** → `research/connections-[date].md`

Open the HTML in a browser. Rectangles are documents, circles are shared concepts, lines are connections (green = complementary, red dashed = contradiction, gold = surprising). Click a node for a sidebar; Ctrl+click to multi-select; scroll to zoom; drag to pan.

Focus on a theme if you want:

```
/connections "focus on materials and circular economy"
```

---

### 4. Write a synthesis — `/connections-report`

On the map, Ctrl+click the nodes you want tied together (e.g. foam glass + rammed earth + circular economy), then click **"Copy for Report"**. Paste into Claude Code.

Claude reads each source document, weaves them into a coherent 1,500–3,000 word essay, strengthens weak connections with additional web research, and surfaces new questions.

**Output:** `research/connections-report-[date].md`.

---

### 5. Multi-track deep dive — `/orchestrate`

When you've committed to a studio topic and want comprehensive coverage:

```
/orchestrate "robotic timber construction"
```

Claude proposes 6 parallel tracks — Supply Chain, Construction History, State-of-the-Art, Policy, Ecology, Adjacent Fields — and you can swap any track before it runs ("replace 'adjacent fields' with 'craft knowledge'"). Each track is a separate agent searching 8–12 sources in parallel.

**Output:** 6 track documents + 1 cross-track synthesis (confirmations, contradictions, surprising links, gaps) + 1 interactive map of how the tracks relate.

Then run `/connections` again — your orchestrate results join the rest of your research.

---

### 6. A full research arc

A month of studio work:

```
Week 1 — Explore
> /explore "Schaumglas"
> /explore "robotische Montage"
> /explore "cooperative housing Stuttgart"

Week 2 — Go deep on what's interesting
> /research "foam glass production from waste glass"
> /research "foam glass thermal vs mechanical properties"
> /research "https://youtube.com/watch?v=..."   ← a video from /explore

Week 3 — Get comprehensive
> /orchestrate "foam glass in robotic construction"

Week 4 — Synthesize
> /connections                              ← open the map, select nodes
> /connections-report [paste selection]

Anytime — ask freely
> "Summarize my foam glass research in 500 words for a crit"
> "What are the strongest arguments against using foam glass structurally?"
> "Compare the supply chains I've researched — what do they share?"
```

Each step builds on the previous. Claude remembers the conversation.

---

## Visual Outputs

The toolkit generates interactive HTML visualizations in `research/maps/`. Open them in any web browser — no server needed.

| Visualization | Generated by | When it appears |
|--------------|-------------|-----------------|
| **Connection map** | `/connections` | Always — force-directed graph of your research landscape |
| **Track map** | `/orchestrate` | After multi-track research — shows how angles relate |
| **Timeline** | `/connections` | When your documents span >6 months or include historical content |
| **Sankey diagram** | `/connections` | When supply chain data exists in your research |
| **Scatter plot** | `/connections` | When 3+ materials have quantitative property data |

All visualizations use a dark theme, D3.js, and are self-contained (no internet required to view).

---

## Using Research in NotebookLM

Research documents are already formatted for NotebookLM import — no export step needed.

1. Do your research with Claude Code — files are saved in `research/`
2. Open [notebooklm.google.com](https://notebooklm.google.com)
3. Create a new notebook
4. Click **"+ Add source"** → **"Upload"** → select `.md` files from `research/`
5. Use NotebookLM to:
   - **Audio Overview** — podcast-style discussion of your research
   - **Cross-source questions** — "Compare the supply chains of rammed earth and CLT"
   - **Study guides** — summaries and key takeaways for presentations

**Tip:** Upload the `/connections-report` synthesis essays — they work especially well as NotebookLM sources because they already weave multiple topics together.

---

## Tips for Better Research

### Be curious, not prescriptive
```
Less effective:  /research "Write me a report about rammed earth"
More effective:  /research "rammed earth in Germany — who are the key players and why isn't it more common?"
```

### Start broad, then narrow
```
/explore "Schaumglas"                              ← What's out there?
/research "foam glass production from waste glass"  ← Go deep
/research "foam glass thermal vs mechanical"        ← Get the numbers
/connections                                        ← See how it connects
```

### Use your own language
German, English, mixed — Claude adapts. Use Fachbegriffe:
```
/research "Tragwerk aus Stampflehm — was sind die statischen Grenzen?"
/explore "Schalung und Robotik"
/research "Bewehrungsstahl supply chain"
```

### Follow tangents
If Claude mentions something unexpected, follow it:
```
"You mentioned BC Materials in Brussels — tell me more about urban earth mining"
"That 0.19% synthesis rate is shocking — where does that come from?"
"The comparison to the wine industry is interesting — explore that further"
```

### Push back and disagree
```
"This source seems biased — it's from a manufacturer. Find independent data"
"I don't buy the sustainability claim — the robot's electricity isn't accounted for"
"The analysis misses labor. Who actually builds with this material?"
```

### Ask freely — beyond slash commands
```
"Summarize all my foam glass research in 500 words for my crit"
"Compare the three supply chains I've researched"
"What are the strongest arguments against my thesis?"
"Create a timeline of robotic construction milestones"
```

---

## Folder Structure

```
Synthetic-Types/
├── research/             ← All research output lives here
│   ├── sources/          ← Raw subagent outputs, transcripts, notes, PDFs
│   ├── videos/           ← Downloaded YouTube videos
│   └── maps/             ← Interactive HTML visualizations
├── references/           ← Studio brief, DE/EN glossary
├── .claude/              ← Skills, commands, agents, settings
├── CLAUDE.md             ← Instructions for Claude
├── README.md             ← This file
├── setup.sh              ← macOS/Linux setup script
└── setup.ps1             ← Windows setup script
```

**Where your work lives:**
- `research/` — every final research document Claude produces
- `research/sources/` — raw subagent findings, transcripts, notes (so you can retrieve details later)
- `research/videos/` — downloaded videos
- `research/maps/` — interactive visualizations (open in browser)

These are standard Markdown files (`.md`). They open in any text editor, VS Code, Obsidian, or directly in NotebookLM.

---

## Related Projects (Optional)

For students interested in computational materials simulation (PDE solvers,
numerical stability, ontology mapping, HPC job scripts) — a separate skill
suite lives at [materials-simulation-skills](https://github.com/HeshamFS/materials-simulation-skills).
Clone it next to this project and install its skills if you want that
capability. It is **not required** for the studio.

---

## Troubleshooting

| Problem | Solution |
|---------|----------|
| Slash commands don't show up | In Claude Desktop, make sure the Claude Code panel has the `Synthetic-Types/` folder opened as the project — not a parent folder. Restart Claude Desktop after first opening. |
| Claude doesn't respond to `/explore` | Same cause as above — the `Synthetic-Types/` folder must be the opened project so `.claude/commands/` is discovered. |
| YouTube transcript fails | Claude tries 5 methods automatically. If all fail, it will research the topic from web sources instead and tell you what happened |
| `/connections` shows few or no nodes | You need at least 3-5 research documents before connections become meaningful. Do more `/research` or `/explore` first |
| Connection map doesn't open | The `.html` files need a web browser. Double-click the file, or right-click → "Open with" → Chrome/Firefox |
| Research feels shallow | Push back: "Find primary sources" or "Go beyond the first page of Google results" or "This isn't deep enough" |
| Claude repeats what you already know | Tell it: "I already know the basics — focus on what's surprising or contested" |
| Setup script fails on Windows | Run PowerShell as Administrator. If `ExecutionPolicy` is the issue: `Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser` |
| `yt-dlp` not found | Optional dependency. Install with `pip install yt-dlp` (or `brew install yt-dlp` on Mac). Claude can still work without it |
| Node.js version too old | Download the latest LTS from [nodejs.org](https://nodejs.org). Verify with `node --version` |

---

## Hilfe / Help

- **Fragen zum Toolkit?** → Schreib Prof. Koehler oder poste ein Issue auf GitHub
- **Questions about the toolkit?** → Contact Prof. Koehler or post a GitHub issue
- **Claude Code Hilfe** → Tippe `/help` in Claude Code / Type `/help` in Claude Code
