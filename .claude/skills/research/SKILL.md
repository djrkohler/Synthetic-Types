---
name: research
description: >
  Deep, flexible research on any topic. Auto-detects the right approach
  based on the student's question: general research, quantitative/scientific
  analysis, supply chain tracing, academic literature mapping, or video
  analysis. Works for any domain. Use for all research requests.
---

# Research

When the student provides a research topic:

## 1. Detect the Research Approach

Read the student's input and determine the right approach. You may
combine approaches when the topic spans multiple modes.

**Video Analysis** — input contains a YouTube URL:
→ Extract transcript, deep-scan full content, timestamp findings,
contextualize claims. See [Video Analysis](#video-analysis).

**Scientific / Quantitative** — question asks for numbers, comparisons,
measurements, material properties, or evidence assessment:
→ Prioritize peer-reviewed sources, extract data with units, create
comparison tables, grade evidence quality. See [Scientific](#scientific).

**Supply Chain** — asks where a material comes from, how it's made,
who's involved, or the journey of a product:
→ Trace the material from origin to site and beyond. Investigate actors,
economics, politics, ecology. See [Supply Chain](#supply-chain).

**Academic Literature** — asks about papers, research landscape, who
studies this, citations, or the state of a field:
→ Search arxiv/Semantic Scholar, trace citation networks, map the
intellectual landscape. See [Academic Literature](#academic-literature).

**General Research** — everything else:
→ Broad, multi-source investigation with flexible structure.

Tell the student briefly what approach you plan to take and what angles
you see. Be open about what you don't know yet.

## 2. Search Broadly

Regardless of approach, search across source types and domains:

- **Web search**: 4-6 searches with different angles and framings.
  Don't just search the obvious — try unexpected combinations.
- **Academic sources**: papers, conference proceedings (ACADIA, Rob|Arch,
  IASS, AA, Bartlett), dissertations
- **YouTube**: search for relevant videos — lectures, demos,
  documentaries, factory tours. Use yt-dlp for search:
  `yt-dlp --flat-playlist "ytsearch10:[terms]" --print "%(title)s | %(channel)s | %(duration_string)s | %(url)s"`
- **Non-obvious sources**: exhibitions, podcasts, patent filings,
  policy documents, EPDs, manufacturer specs, historical archives
- **Context**: check `references/` for relevant background (don't force
  connections)

Aim for **10-15 diverse sources**. Diversity of perspective matters more
than quantity. One factory tour, one academic paper, one news article,
and one policy document are more valuable than five news articles saying
the same thing.

## 3. Note Key Visual Sources

Identify **3-5 key visual sources** per document:

```
**[Visual: description]** — [Why it matters]
Source: [URL] | [Author/Org, Date]
```

Prioritize: technical diagrams, process flows, material close-ups,
data charts, project documentation, microscopy images.

Do NOT take screenshots — students click through to view in context.

## 4. Synthesize

- Cross-reference findings across sources
- Note where sources agree, disagree, or reveal different aspects
- Identify what is well-established vs. speculative or contested
- Note gaps: what could you not find? What remains unclear?
- Look for unexpected connections to other topics
- Flag when information may be outdated or biased

Spend real time on cross-referencing. Don't just list what each source
says — show how they speak to each other.

## 5. Write the Document

Every document must include:
- **Zusammenfassung** (German, 150-300 words) at the top
- **Sources** (numbered, full URLs, access dates) at the bottom

Structure should emerge from content. Possible structures:
- Chronological narrative (historical topics)
- Comparative analysis (contrasting approaches)
- Technical deep-dive with case studies
- Actor/relationship map (industry landscapes)
- Debate structure (contested topics)
- Material journey (supply chain topics)

### Depth Requirements

- Major findings: 2-3 paragraphs each, not just bullet points
- At least one detailed case study or worked example
- **Deep Dive**: 500+ words on the most surprising/significant finding
- **Open Questions**: always — research is never finished

### Applications & Interpretations

Research the topic **on its own terms first**. Then, in a separate
section near the end, offer possible applications and interpretations
across fields — design, engineering, policy, ecology, and architecture
as one lens among many. Do not frame the entire research through
architecture.

## 6. Save and Suggest

Save to the appropriate path (see approach-specific sections below)
and suggest 2-3 follow-up directions.

---

## Approach-Specific Protocols

### Video Analysis

When input contains a YouTube URL.

#### Establish the Research Question
If the student provided a URL directly, ask: "What specifically are you
hoping to learn from this video?" This guides what you extract.

#### Extract Transcript — Multi-Step Fallback
Attempt ALL methods in order before concluding unavailable. Document
which methods you tried and what happened with each.

1. **MCP YouTube Transcript**: `get_transcript` — try English, German,
   then auto-generated
2. **yt-dlp manual subs**: `yt-dlp --write-subs --sub-lang en --skip-download -o "research/sources/transcript-%(id)s" "URL"`
3. **yt-dlp auto subs**: `yt-dlp --write-auto-sub --sub-lang en --skip-download -o "research/sources/transcript-%(id)s" "URL"`
4. **WebFetch transcript services**:
   - `https://youtubetranscript.com/?v=VIDEO_ID`
   - `https://kome.ai/tools/youtube-transcript-generator`
5. **Playwright DOM extraction**: navigate to video, click "Show
   transcript", extract from DOM

Save transcript to `research/sources/transcript-[topic]-[YYYY-MM-DD].md` with
a note of which method succeeded.

**If ALL five steps fail**: state this clearly in the document, list
each method and its error. Search web for the video title + "transcript",
speaker's name + topic, hosting institution for published text.

#### Deep-Scan the Full Transcript
Read the ENTIRE transcript, not just the introduction. Extract with
the research question in mind:
- **Specific data**: numbers, measurements, costs, timelines
- **Named entities**: projects, institutions, companies, standards
- **Technical processes**: step-by-step descriptions
- **Admissions/uncertainty**: "we don't know," "this failed" — often
  the most valuable parts
- **Counter-narratives**: what complicates the mainstream story
- **Tangential insights**: casual remarks that open new directions

Note timestamps `[MM:SS]` for each finding. Organize by relevance to
the research question, not chronologically.

#### Key Visual Moments
Identify 3-5 key visual moments:
```
**[Visual at MM:SS]**: What is shown — why it matters.
```

**Depth**: 1,500-3,000 words minimum for a video analysis.

Save to `research/video-[topic-slug]-[YYYY-MM-DD].md`

#### Video Search Mode
When a topic is given (not a URL), search YouTube:
```
yt-dlp --flat-playlist "ytsearch10:[terms]" --print "%(title)s | %(channel)s | %(duration_string)s | %(upload_date>%Y-%m-%d)s | %(url)s"
```
Search with diverse framings: technical, critical, visual, academic,
cultural, historical, process-focused. Present results with relevance
assessments. Offer to analyze the most promising videos in depth.

---

### Scientific

When the question needs quantitative rigor.

#### Define the Question Precisely
Narrow to something measurable or falsifiable.
- Vague: "Is rammed earth sustainable?"
- Precise: "What are the measured embodied carbon values (kg CO2e/m3)
  for unstabilized rammed earth vs. concrete block walls in Central
  European LCA studies after 2018?"

If broad, help the student narrow it — propose 2-3 precise formulations.

#### Source Hierarchy
Search in this priority order:
1. **Peer-reviewed papers**: Google Scholar, journals (Construction and
   Building Materials, Automation in Construction, Journal of Cleaner
   Production, Nature Materials, Materials & Design)
2. **Standards & EPDs**: DIN, EN, ISO; ÖKOBAUDAT, IBU, EPD International
3. **Government/institutional data**: UBA, BBSR, Fraunhofer, BAM, EU JRC
4. **Industry technical docs**: test reports, material data sheets,
   certifications (abZ, ETA)
5. **Conference proceedings**: ACADIA, Rob|Arch, IASS, WCTE, RILEM, fib
6. **Theses and dissertations**: often most detailed experimental data

Aim for 8-15 sources with at least 3 peer-reviewed papers.

#### Extract Quantitative Data
For every finding: specific numbers with units (MPa, kWh/kg, kg CO2e/m3,
W/(m·K)), sample sizes, test conditions, ranges/standard deviations,
comparison baselines, geographic/temporal context.

Create **data tables**:
| Property | Value | Range | Source | Method | Year | Notes |
|----------|-------|-------|--------|--------|------|-------|

#### Evidence Quality Assessment
Rate each key finding:
- **Strong**: Multiple peer-reviewed studies, consistent results
- **Moderate**: 1-2 studies or consistent industry data
- **Weak**: Single source, no peer review, marketing as data
- **Contested**: Sources disagree — document full range and reasons

Be explicit about what you could NOT find.

#### Additional Document Sections
- **Research Question** (precisely stated, with scope)
- **Methodology** (databases searched, terms, criteria)
- **Evidence Assessment** summary
- **Limitations** (caveats, gaps, what more thorough review would need)

Save to `research/scientific-[topic-slug]-[YYYY-MM-DD].md`

---

### Supply Chain

When tracing a material's journey.

#### Investigative Questions
Start here, follow where they lead:
- **Origin**: geology, biology, geography of extraction/harvest
- **Transformation**: steps from raw to product, energy at each stage
- **Actors**: miners, farmers, factory workers, drivers, craftspeople
  — working conditions
- **Geography**: local, regional, or global logistics
- **Economics**: costs, profits, market dynamics, monopolies
- **Environment**: carbon, water, biodiversity, waste vs. alternatives
- **End of life**: reuse, recycling, composting, or landfill
- **Politics**: conflicts, regulations, trade disputes, ethics
- **History**: how has this chain changed over time? What was
  gained/lost through industrialization?
- **Future**: innovations, disruptions, circular economy models
- **Adjacent industries**: compare to food, textiles, electronics
- **Material culture**: craft knowledge, meaning to workers

Not all questions apply to every material. Let the material guide
which matter most.

#### Search Strategy
Material + "supply chain" / "production process" / "LCA" / "EPD",
industry reports, YouTube factory tours, investigative journalism,
historical sources, DIN/EN/ISO standards.

#### Structure
Let the material dictate the structure — a linear journey, a network
description, a comparison with alternatives, or a story told through
the people involved.

Save to `research/supply-chain-[material-slug]-[YYYY-MM-DD].md`

---

### Academic Literature

When mapping the academic landscape.

#### Formulate Academic Search
Generate 3-5 search queries with different framings:
- Specific technical terms
- Broader conceptual framing
- Named methods or frameworks
- Key author names if known

#### Search Academic Sources

**Primary — MCP Tools (when available):**

*arxiv*: `search_papers`, `get_abstract`, `download_paper`/`read_paper`,
`citation_graph`. Categories: cs.RO, cs.AI, cs.CG, cs.CV, eess.SP,
physics.app-ph.

*Semantic Scholar*: `paper_relevance_search`, `paper_details`,
`paper_citations`, `paper_references`, `author_search`,
`get_paper_recommendations_single`.

**Fallback — Web Search:**
Google Scholar, arxiv.org, ResearchGate, specific journals, conference
proceedings, EPD databases, thesis repositories.

Do NOT silently degrade — tell the student which method you're using.

Aim for 10-15 sources with at least 5 peer-reviewed papers.

#### Trace Citation Networks
For the 3-5 most relevant papers:
- **Forward citations**: who cites this?
- **Backward citations**: what does it build on?
- **Bridge papers**: connecting sub-fields
- **Foundational papers**: high citation, canonical references
- **Author clusters**: competing schools, geographic clusters
- **Recency**: latest preprints updating older findings

If MCP tools unavailable, trace manually through Google Scholar
"Cited by" links.

#### Additional Document Sections
- **Research Landscape** narrative
- **Key Papers** (5-8 detailed: citation, abstract, methodology,
  findings, limitations, significance)
- **Citation Network** analysis
- **Current Frontiers**
- **Debates & Tensions** with evidence on each side

Save to `research/literature-[topic-slug]-[YYYY-MM-DD].md`
