---
name: format-for-notebooklm
description: Format and prepare research documents for optimal import into Google NotebookLM. Cleans up markdown, ensures proper structure, consolidates sources, and creates an import-ready version. Use when a student wants to export their research to NotebookLM, prepare documents for synthesis, or clean up research files.
allowed-tools: Read, Write, Bash
---

# Format for NotebookLM Skill

## What This Does
Prepares research documents for import into Google NotebookLM.
NotebookLM works best with clean, well-structured text documents
that have clear sections and inline source references.

## Step 1: Inventory
- List all files in `research/` directory
- Show the student what's available
- Let them choose which documents to prepare (or all)

## Step 2: Clean and Optimize Each Document
For each selected document:
- Remove any HTML tags (NotebookLM prefers plain markdown)
- Ensure all headings use ## and ### (not # for title — use bold text instead)
- Convert bullet-point-heavy sections into flowing prose paragraphs
- Ensure every claim has its source URL inline, not just in the footer
- Remove duplicate information across sections
- Ensure the Zusammenfassung is at the top and clearly labeled
- Check that all URLs are complete (not relative links)
- Target 2,000-10,000 words per document (NotebookLM sweet spot)

## Step 3: Create Combined Documents (Optional)
If the student has many short research docs on related topics:
- Offer to combine them into thematic collections
- Example: all supply chain docs → `output/collection-supply-chains.md`
- Maintain clear section breaks between original documents
- Add a table of contents at the top

## Step 4: Save to Output
- Save formatted documents to `output/notebooklm-[topic].md`
- Tell the student:
  "Your documents are ready in the output/ folder.
   To use them in NotebookLM:
   1. Go to notebooklm.google.com
   2. Create a new notebook
   3. Click '+ Add source' → 'Upload' → select your .md files
   4. NotebookLM will process them as sources
   5. You can then generate Audio Overviews, ask questions across sources, and create study guides."
