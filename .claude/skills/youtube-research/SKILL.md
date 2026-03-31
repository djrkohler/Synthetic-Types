---
name: youtube-research
description: Extract and analyze YouTube video transcripts for research. Use when a student provides a YouTube URL or asks to analyze a video, conference talk, factory tour, robotics demo, or construction documentation video.
allowed-tools: Read, Write, Bash, mcp__youtube-transcript, WebSearch, WebFetch
---

# YouTube Research Skill

When the student provides a YouTube URL or asks to find and analyze a video:

## Step 1: Extract Transcript
- Use the YouTube transcript MCP tool `get_transcript` with the video URL
- Request English transcript first, fall back to German or auto-generated
- If MCP fails, try: `yt-dlp --write-auto-sub --sub-lang en --skip-download "URL"` as fallback
- Save raw transcript to `sources/transcript-[topic]-[YYYY-MM-DD].md`

## Step 2: Analyze Content
- Identify the main topics discussed
- Extract key claims, data points, and expert opinions
- Note timestamps for the most important sections
- Identify speakers if multiple are present
- Flag any technical terminology relevant to architecture/construction/robotics

## Step 3: Write Summary Document
- Create a research document following the template in CLAUDE.md
- Include German Zusammenfassung
- Structure by topic/theme, not chronologically
- Include timestamped references to key moments: `[12:34]`
- Save to `research/video-[topic-slug]-[YYYY-MM-DD].md`

## Step 4: Contextualize
- Search the web for additional context on key claims from the video
- Cross-reference claims with other sources
- Note the speaker's credentials and potential biases
- Suggest related videos or sources for further research
