# Synthetic Types — Research Toolkit

**ABK Stuttgart · SS2026 · Prof. Daniel Koehler**
**Studio "Synthetische Typen / Modelling Models"**

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
  - [Tutorial 1: Exploring a New Material](#tutorial-1-exploring-a-new-material)
  - [Tutorial 2: Analyzing a YouTube Video](#tutorial-2-analyzing-a-youtube-video)
  - [Tutorial 3: Getting Hard Numbers](#tutorial-3-getting-hard-numbers)
  - [Tutorial 4: Tracing a Supply Chain](#tutorial-4-tracing-a-supply-chain)
  - [Tutorial 5: Finding Academic Papers](#tutorial-5-finding-academic-papers)
  - [Tutorial 6: Mapping Your Research](#tutorial-6-mapping-your-research)
  - [Tutorial 7: Writing a Synthesis from the Map](#tutorial-7-writing-a-synthesis-from-the-map)
  - [Tutorial 8: Multi-Track Deep Investigation](#tutorial-8-multi-track-deep-investigation)
  - [Tutorial 9: Full Research Arc (Start to Finish)](#tutorial-9-full-research-arc-start-to-finish)
- [Visual Outputs](#visual-outputs)
- [Using Research in NotebookLM](#using-research-in-notebooklm)
- [Tips for Better Research](#tips-for-better-research)
- [Folder Structure](#folder-structure)
- [Troubleshooting](#troubleshooting)

---

## Installation

### What You Need

| Requirement | Why | Where to get it |
|-------------|-----|-----------------|
| **Claude Pro or Max** | Powers the research companion | [claude.ai](https://claude.ai) ($20/month) |
| **Node.js 18+** | Required by Claude Code and Playwright | [nodejs.org](https://nodejs.org) |
| **Git** | To clone the repository | [git-scm.com](https://git-scm.com) |

### Step 1: Install Node.js

Download and install from [nodejs.org](https://nodejs.org). Choose the **LTS** (Long Term Support) version.

Verify it works by opening a terminal and typing:
```bash
node --version
```
You should see `v18.x.x` or higher.

### Step 2: Install Claude Code

**macOS / Linux:**
```bash
curl -fsSL https://claude.ai/install.sh | bash
```

**Windows (PowerShell as Administrator):**
```powershell
irm https://claude.ai/install.ps1 | iex
```

After installation, **restart your terminal**. Verify:
```bash
claude --version
```

If you haven't already, log in to Claude Code:
```bash
claude login
```
This opens a browser window to authenticate with your Claude account.

### Step 3: Clone and Set Up the Toolkit

**macOS / Linux:**
```bash
git clone https://github.com/djrkohler/Synthetic-Types.git
cd Synthetic-Types
chmod +x setup.sh
./setup.sh
```

**Windows:**
```powershell
git clone https://github.com/djrkohler/Synthetic-Types.git
cd Synthetic-Types
powershell -ExecutionPolicy Bypass -File setup.ps1
```

The setup script:
- Verifies Node.js 18+ is installed
- Installs Playwright browser (for transcript extraction fallback)
- Optionally installs yt-dlp (for YouTube search and video download)

### Step 4: Start

```bash
cd Synthetic-Types
claude
```

Claude Code opens in the terminal. You can now type commands or ask questions freely.

### Optional: Install yt-dlp

yt-dlp enables YouTube search and video downloads. Not required — Claude can still extract transcripts without it — but recommended.

**macOS:**
```bash
brew install yt-dlp
```

**Windows:**
```powershell
pip install yt-dlp
```

**Linux:**
```bash
pip3 install --user yt-dlp
```

---

## Quick Start

After installation, open a terminal in the `Synthetic-Types` folder and type `claude`. Then try:

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

Open the HTML map in your browser. Click nodes, Ctrl+click to select several, then "Copy for Report" and paste into Claude to generate a synthesis essay.

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

### Tutorial 1: Exploring a New Material

**Scenario:** You're interested in foam glass (Schaumglas) but don't know much about it.

**Step 1 — Explore:**
```
/explore "Schaumglas"
```

Claude branches out: production from waste glass, thermal properties, Stuttgart kiln experiments, foam glass as a visible architectural surface, market players (Glapor, Misapor, Glavel), circularity potential... The output is an **exploration map** with 5-8 directions, each with sources and open questions.

**Step 2 — Read the output.** You notice the "visible surface" angle is unusual. Follow it:

```
That foam glass surface idea is interesting — it looks like pumice.
Can it be an architectural surface instead of hidden insulation?
```

Claude investigates further. No slash command needed — just ask.

**Step 3 — Save the exploration.** Claude saves to `research/explore-schaumglas-2026-04-09.md`. This file is now part of your research corpus for `/connections` later.

**What you get:** A map of 8 research directions with sources, YouTube videos, creative/scientific reflections per branch, and provocations. Not a polished paper — a springboard.

---

### Tutorial 2: Analyzing a YouTube Video

**Scenario:** Your professor shared a lecture video and you want to understand the speaker's claims.

**Step 1 — Analyze the video:**
```
/research "https://www.youtube.com/watch?v=abc123"
```

Claude asks: *"What specifically are you hoping to learn from this video?"*

**Step 2 — Tell it what you're looking for:**
```
I want to understand their claim about AI-designed materials
and whether the numbers they cite are real
```

**Step 3 — Claude works:**
- Extracts the full transcript (tries 5 methods automatically)
- Deep-scans the ENTIRE transcript (not just the intro)
- Pulls out specific data points with timestamps `[12:34]`
- Identifies admissions of uncertainty ("we don't know yet...")
- Cross-references claims against published sources
- Flags what's evidence-based vs. speculation

**What you get:** A 1,500-3,000 word analysis in `research/video-[topic]-2026-04-09.md` with timestamped findings, visual moments, and source verification.

**Scenario B — Find videos on a topic:**
```
/research "robotic construction site videos"
```

Claude searches YouTube with multiple framings (technical, critical, cultural, historical), presents the best results, and offers to analyze the most promising ones in depth.

---

### Tutorial 3: Getting Hard Numbers

**Scenario:** You need actual data for a studio argument — "Is rammed earth structurally viable?"

**Step 1 — Ask a quantitative question:**
```
/research "compressive strength rammed earth vs concrete — actual test data"
```

Claude recognizes this needs scientific rigor and shifts into quantitative mode:
- Searches peer-reviewed papers, standards (DIN, EN), EPDs
- Extracts specific numbers with units (MPa, kg/m3)
- Creates **data tables**:

  | Property | Rammed Earth | Concrete C20/25 | Source | Year |
  |----------|-------------|-----------------|--------|------|
  | Compressive Strength | 1-5 MPa | 20-25 MPa | Houben & Guillaud | 2006 |

- Rates evidence: **Strong** / **Moderate** / **Weak** / **Contested**
- Notes exactly what data is missing or contradictory

**What you get:** A research document with precise numbers, comparison tables, evidence ratings, methodology transparency, and explicit gaps. Saved to `research/scientific-[topic]-2026-04-09.md`.

**Tip:** Be precise. Vague: "Is rammed earth sustainable?" Precise: "What are the measured embodied carbon values (kg CO2e/m3) for unstabilized rammed earth vs. concrete block walls in Central European studies after 2018?"

---

### Tutorial 4: Tracing a Supply Chain

**Scenario:** You want to understand where cross-laminated timber actually comes from.

```
/research "Brettsperrholz supply chain from Austrian forest to Stuttgart building site"
```

Claude recognizes the supply-chain framing and investigates:
- **Origin:** Spruce forests in Austria, forestry practices, certification (PEFC, FSC)
- **Transformation:** Sawmill → drying → lamellas → gluing → pressing → CNC cutting
- **Actors:** Who profits? Forestry workers, sawmill operators, CLT manufacturers (Stora Enso, Binderholz, KLH)
- **Geography:** Transport routes, distances, logistics
- **Economics:** Cost per m3, market dynamics
- **Environment:** Carbon sequestration, LCA data, comparison to concrete
- **End of life:** Can it be reused? Recycled? What happens to the glue?
- **Politics:** Building code barriers, fire regulations, insurance
- **History:** How was timber construction replaced by concrete in the 20th century?

**What you get:** A narrative that follows the material's journey, structured however the supply chain itself demands. Saved to `research/supply-chain-brettsperrholz-2026-04-09.md`.

---

### Tutorial 5: Finding Academic Papers

**Scenario:** You want to understand the research landscape around robotic timber assembly.

```
/research "robotic timber assembly — who is publishing, what are the key papers?"
```

Claude recognizes the academic framing and activates literature mode:
- Searches arxiv, Semantic Scholar (when available), Google Scholar
- Identifies **5-8 key papers** with full citations, abstracts, methods, findings
- **Traces citation networks:** who cites whom, foundational papers, competing research groups
- Maps **author clusters** and institutions (ETH Zurich, Stuttgart ICD, MIT, University of Tokyo...)
- Identifies **debates** (timber vs. metal jointery for robots, accuracy vs. speed)
- Finds **gaps** — what hasn't been studied

**What you get:** An intellectual landscape map. Who works on this, where the field came from, where it's going, and where the open questions are. Saved to `research/literature-robotic-timber-2026-04-09.md`.

---

### Tutorial 6: Mapping Your Research

**Scenario:** You've done 5-6 research sessions and want to see the big picture.

**Step 1 — Generate the map:**
```
/connections
```

Claude reads everything in `research/` and `sources/`:
- Extracts concepts from every document
- Finds shared themes, contradictions, gaps, surprising links
- Generates two outputs:
  1. **Interactive HTML map** → `output/maps/connections-map-2026-04-09.html`
  2. **Narrative document** → `research/connections-2026-04-09.md`

**Step 2 — Open the map in your browser.**

Double-click the HTML file or drag it into Chrome/Firefox. You'll see a force-directed graph:
- **Rectangles** = your research documents (color-coded by type)
- **Circles** = concepts that appear across documents (sized by frequency)
- **Lines** = connections (green = complementary, red dashed = contradiction, gold = surprising)

**Step 3 — Interact:**
- **Click** a node → sidebar opens with synthesis and connections
- **Ctrl+Click** multiple nodes → multi-select for report generation
- **Scroll** to zoom, **drag** to pan
- **Double-click** background to reset

**Step 4 — Optional: focus on a theme:**
```
/connections "focus on materials and circular economy"
```

---

### Tutorial 7: Writing a Synthesis from the Map

**Scenario:** On the connection map, you see that your foam glass research, rammed earth research, and circular economy exploration are connected in interesting ways. You want a coherent essay.

**Step 1 — Select nodes on the map:**
- Click the foam glass node
- Ctrl+click the rammed earth node
- Ctrl+click the circular economy node
- Click **"Copy for Report"** button (top right of the map)

This copies a structured prompt to your clipboard.

**Step 2 — Paste into Claude Code:**
Press Ctrl+V (or Cmd+V on Mac). Claude receives the full context — selected nodes, their connections, and guiding questions — and starts writing immediately.

**What you get:** A 1,500-3,000 word synthesis essay that:
- Reads the source documents for each selected topic
- Weaves them into a coherent narrative
- Strengthens weak connections with additional web research
- Identifies new questions that emerge from reading them together
- Saved to `research/connections-report-2026-04-09.md`

---

### Tutorial 8: Multi-Track Deep Investigation

**Scenario:** You've chosen "robotic timber construction" as your studio topic and want comprehensive coverage from every angle.

**Step 1 — Launch orchestrate:**
```
/orchestrate "robotic timber construction"
```

Claude presents 6 research tracks:

| Track | What it investigates |
|-------|---------------------|
| Supply Chain | Timber sourcing, prefab logistics, robotic component costs |
| Construction History | Timber joinery traditions, prefab evolution, industrialization |
| State-of-the-Art | ICD Stuttgart, ETH Zurich, NCCR, current robotic timber projects |
| Policy | Building codes, fire regulations, insurance barriers |
| Ecology | Carbon sequestration, LCA, end-of-life, forestry sustainability |
| Adjacent Fields | How automotive/aerospace/furniture handle robotic assembly |

**Step 2 — Modify if you want:**
```
Replace "adjacent fields" with "craft knowledge" — I want to know
what hand-building traditions could inform robotic approaches
```

**Step 3 — Claude launches all tracks in parallel.** Each runs as a separate agent searching 8-12 sources. This takes a few minutes.

**Step 4 — Read the synthesis.** Claude produces:
- **6 individual track documents** (one per angle)
- **1 synthesis document** — cross-track confirmations, contradictions, surprising connections, gaps
- **1 interactive map** — showing how tracks relate to each other

The synthesis might reveal that the policy track found insurance barriers the state-of-the-art track doesn't mention, and the craft knowledge track identifies joinery techniques no current robot can replicate. These contradictions become the core of your design argument.

**Step 5 — Map everything:**
```
/connections
```

Now your orchestrate results appear alongside your earlier research, revealing new connections across everything you've investigated.

---

### Tutorial 9: Full Research Arc (Start to Finish)

A complete research workflow for a studio project:

```
Week 1 — Explore
> /explore "Schaumglas"
> /explore "robotische Montage"
> /explore "cooperative housing Stuttgart"

Week 2 — Go deep on what's interesting
> /research "foam glass production from waste glass"
> /research "foam glass thermal vs mechanical properties"
> /research "recycled glass foam glass supply chain"
> /research "https://youtube.com/watch?v=... "  ← video from /explore

Week 3 — Get comprehensive
> /orchestrate "foam glass in robotic construction"

Week 4 — Synthesize
> /connections
  [open map, explore, select nodes]
> /connections-report [paste selection]

Ongoing — Ask freely
> "Summarize my foam glass research in 500 words for a crit"
> "What are the strongest arguments against using foam glass structurally?"
> "Compare the supply chains I've researched — what do they share?"
> "Translate this Zusammenfassung into English"
```

Each step builds on the previous. Claude remembers your conversation.

---

## Visual Outputs

The toolkit generates interactive HTML visualizations in `output/maps/`. Open them in any web browser — no server needed.

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
├── research/          ← Your research documents (Markdown)
├── sources/           ← Raw transcripts, notes, PDFs
├── output/
│   └── maps/          ← Interactive HTML visualizations
├── references/        ← Studio brief, DE/EN glossary
├── .claude/           ← Skills, commands, agents, settings
├── CLAUDE.md          ← Instructions for Claude
├── README.md          ← This file
├── setup.sh           ← macOS/Linux setup script
└── setup.ps1          ← Windows setup script
```

**Where your work lives:**
- `research/` — every research document Claude produces
- `output/maps/` — interactive visualizations (open in browser)
- `sources/` — raw transcripts and notes

These are standard Markdown files (`.md`). They open in any text editor, VS Code, Obsidian, or directly in NotebookLM.

---

## Troubleshooting

| Problem | Solution |
|---------|----------|
| `claude` command not found | Restart your terminal after installation. If still missing, reinstall Claude Code (see [Installation](#installation)) |
| Claude doesn't respond to `/explore` | Make sure you're running `claude` from inside the `Synthetic-Types/` folder, not a parent or different directory |
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
- **Claude Code Hilfe** → Tippe `/help` im Terminal / Type `/help` in the terminal
