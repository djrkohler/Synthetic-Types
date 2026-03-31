---
name: research-topic
description: Deep multi-source research on any architecture, materials, construction, or robotics topic. Searches the web, reads full articles, cross-references sources, and produces a structured markdown research document with German summary. Use when a student asks to research a topic, investigate a material, explore a construction method, or learn about a technology.
allowed-tools: Read, Write, Bash, WebSearch, WebFetch, mcp__playwright, mcp__youtube-transcript
---

# Research Topic Skill

When the student provides a research topic:

## Step 1: Plan the Research
- Break the topic into 3-5 research questions
- Identify what types of sources to look for (academic, industry, news, video)
- Tell the student your research plan briefly

## Step 2: Gather Sources
- Search the web for 5-10 diverse sources
- Prioritize: company websites, academic papers, industry reports, recent news
- For each source, note the URL, author, date, and key claims
- If a YouTube video is relevant, use the YouTube transcript MCP to extract and analyze it
- If a website needs deeper exploration, use Playwright to navigate it

## Step 3: Synthesize
- Cross-reference findings across sources
- Note agreements and contradictions between sources
- Identify the most important findings
- Note gaps in the available information

## Step 4: Write the Research Document
- Follow the document template from CLAUDE.md
- Start with a German Zusammenfassung (150-300 words)
- Write in clear, structured English
- Include inline citations with URLs
- End with numbered source list

## Step 5: Save
- Save to `research/[topic-slug]-[YYYY-MM-DD].md`
- Use today's date
- Inform the student where the file was saved
- Suggest follow-up research directions
