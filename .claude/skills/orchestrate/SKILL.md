---
name: orchestrate
description: >
  Launch parallel research tracks on multiple angles of a topic. Spawns
  subagents for each research angle (supply chain, construction history,
  state-of-the-art, policy, ecology, adjacent fields) and synthesizes
  their findings into a unified picture. Finds cross-track confirmations,
  contradictions, gaps, and surprising connections. Use when a student
  wants comprehensive, multi-perspective coverage of a topic in one
  operation. Produces: individual track documents, a synthesis document,
  and a visual map of track relationships.
---

# Orchestrated Multi-Track Research

## 1. Understand the Topic and Configure Tracks

When the student provides a topic, present the **6 default research tracks**
and ask if they want to modify them:

| Track | Angle | What it investigates |
|-------|-------|---------------------|
| **Supply Chain** | Origin, production, logistics, actors, economics | Where does this come from? Who is involved? What does it cost? |
| **Construction History** | Historical precedents, evolution, traditional methods | How has this been built or used before? What changed over time? |
| **State-of-the-Art** | Current research, robotics, digital fabrication, emerging methods | What is the cutting edge? What labs, projects, startups are pushing this? |
| **Policy** | Regulations, standards, subsidies, political context | What rules govern this? Who decides? What incentives or barriers exist? |
| **Ecology** | LCA, circularity, resource limits, environmental impact | What are the ecological consequences? What does the data say? |
| **Adjacent Fields** | Analogies from food, textiles, aerospace, logistics, agriculture | What can construction learn from how other industries handle this? |

Tell the student they can:
- **Accept all 6** tracks (default)
- **Remove** tracks not relevant to their topic
- **Add custom tracks** (specify angle + description)
- **Modify** the angle of any existing track

Wait for the student's response before proceeding.

## 2. Launch Parallel Research Tracks

For each confirmed track, spawn the `research-track` agent with a
prompt that specifies:
- The overall **TOPIC**
- The specific **ANGLE** (track name + description from the table)
- Any additional context the student provided
- Instructions to search 8-12 sources and return structured findings

**Spawn all tracks in parallel** using the Agent tool. Each track
runs independently as a `research-track` subagent.

Example prompt for one track:
```
TOPIC: [student's topic]
ANGLE: Supply Chain — Origin, production, logistics, actors, economics.
Investigate where this material/technology comes from, who is involved
in its production and distribution, what it costs, and what the market
dynamics look like.

[Any additional student context]
```

**If parallel spawning fails** (rate limits, context limits), fall back
to batches of 2-3 tracks at a time. Tell the student: "Running tracks
in batches — this will take longer but produces the same results."

## 3. Collect and Review Findings

As tracks complete, collect their structured findings. For each track,
review the output for:
- Completeness (did it find 8-12 sources?)
- Quality (are sources diverse, with evidence ratings?)
- Cross-angle connections (did it flag relevant findings for other tracks?)

If a track returned thin results (fewer than 5 sources, no data points),
note this as a gap for the synthesis step.

## 4. Save Individual Track Documents

Transform each track's raw findings into a proper research document.
For each track:

- Add a **Zusammenfassung** (German, 100-200 words) summarizing the
  track's key findings from its specific angle
- Structure the findings into readable sections (not raw agent output)
- Include all sources with full URLs and access dates
- Include evidence quality ratings for key claims
- Note cross-angle connections found (these feed into synthesis)

Save each track document to:
`research/orchestrate-[topic-slug]-[track-name]-[YYYY-MM-DD].md`

Track name in filename should be lowercase, hyphenated:
`supply-chain`, `construction-history`, `state-of-the-art`,
`policy`, `ecology`, `adjacent-fields`

## 5. Cross-Track Synthesis

This is the core value of orchestration. Systematically compare
findings across ALL tracks:

### Confirmations
Where do multiple tracks report the same finding? This strengthens
confidence. Example: "Both the supply chain and ecology tracks
identify [X] as a key constraint."

### Contradictions
Where do tracks report conflicting information? Why might this be?
Different sources? Different timeframes? Different methodologies?
Example: "The policy track cites [standard] as requiring [X], but
the state-of-the-art track shows recent projects that achieve [Y]
without meeting that standard."

### Gaps
What angle is missing from ALL tracks? What did no track find despite
searching? These are the most important research leads.

### Surprising Cross-Track Connections
Where does a finding from one track illuminate another track in an
unexpected way? These are the highest-value insights. Example:
"The adjacent fields track found that the textile industry solved
[problem] using [method], which could directly address the challenge
identified in the construction history track."

### Quantitative Cross-References
Do the numbers from one track match the numbers from another?
If the supply chain track says the material costs X EUR/m3, does
that match the economics data in the policy track?

## 6. Generate Track Relationship Map

Generate an interactive HTML visualization using the same D3.js
approach as the `/connections` skill.

**Node structure:**
- **6 track nodes** — large circles (size: 30), color-coded:
  - Supply Chain = `#50C878` (green)
  - Construction History = `#C9A96E` (tan)
  - State-of-the-Art = `#4A90D9` (blue)
  - Policy = `#D94A4A` (red)
  - Ecology = `#6BCB77` (light green)
  - Adjacent Fields = `#9B59B6` (purple)
- **Key concept nodes** — smaller circles (size: 8-16), extracted
  from track findings, colored lighter versions of their source track

**Edge structure:**
- **Confirmation** — solid green line between track nodes that agree
- **Contradiction** — dashed red line between tracks that disagree
- **Surprising connection** — thick gold line (`#F0C75E`)
- **Concept shared across tracks** — thin grey line connecting a
  concept node to multiple track nodes

**Layout:**
- Track nodes arranged in a rough hexagon (they are the anchors)
- Concept nodes cluster around their source track
- Cross-track edges are visually prominent — they are the key insight

**Interactive features:** Same as `/connections` — hover tooltips,
click to highlight, zoom/pan, legend, dark background (#1a1a2e).

Follow the same HTML template structure and D3.js patterns documented
in the connections skill (`connections/SKILL.md` section 4).

Save to `output/maps/orchestrate-[topic-slug]-map-[YYYY-MM-DD].html`

## 7. Write the Synthesis Document

This is the primary output. Structure:

- **Zusammenfassung** (German, 200-400 words) — longer than usual
  because this is a multi-track synthesis
- **Topic Overview** — what was investigated, which tracks were run,
  how many sources were found across all tracks
- **Cross-Track Synthesis** (the main section):
  - **Confirmations** — what multiple tracks agree on, with references
    to the specific track documents
  - **Contradictions** — what tracks disagree on, with analysis of
    why and which evidence is stronger
  - **Surprising Connections** — the most valuable output. Spend
    **500+ words** on the top 3-5 cross-track insights. Explain
    WHY these connections matter and what they suggest.
  - **Gaps** — what no track found, what remains unknown, what
    needs further investigation
- **Track Summaries** — brief summary (100-200 words each) of each
  track's key findings, with link to the full track document
- **Open Questions** — specific questions that emerged from the
  synthesis, not answerable from the existing tracks
- **Suggested Follow-ups** — specific commands:
  - `/research` for deeper investigation of a specific finding
  - `/explore` for creative connections
  - `/connections` to map these findings against prior research
- **Sources** — consolidated from all tracks, deduplicated, with
  evidence quality noted

Save to `research/orchestrate-[topic-slug]-synthesis-[YYYY-MM-DD].md`

## 8. Present Results

Tell the student:
- Where the **synthesis document** is saved (this is the primary output)
- Where each **track document** is saved (supporting detail)
- Where the **visual map** is saved (open in a browser)
- Highlight the **3-5 most interesting cross-track findings**
- Suggest the most productive next research steps

Emphasize that track documents can be individually imported into
NotebookLM for deeper exploration.
