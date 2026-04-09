---
name: connections
description: >
  Cross-reference all research documents and generate a visual map of
  connections. Reads everything in research/ and sources/, extracts
  concepts and themes, finds patterns across documents, and produces
  two outputs: (1) an interactive HTML visualization showing concepts
  as nodes and connections as edges, and (2) a narrative markdown
  document explaining the connections found. Use when a student has
  accumulated multiple research documents and wants to see the bigger
  picture — what themes emerge, what contradicts, what gaps exist,
  what surprising connections appear.
---

# Cross-Reference & Visual Synthesis

## 1. Inventory

Read all markdown files in `research/` and `sources/` (skip images,
binary files, and templates). For each document, note:
- Filename and date
- Document type (exploration, supply chain, scientific, video analysis,
  literature review, orchestrate track, etc.)
- Primary topic (1-2 sentences)

Present the inventory to the student, organized by type or theme.
If `$ARGUMENTS` specifies a theme or focus, filter to relevant
documents only. Otherwise, analyze everything.

## 2. Extract Concepts

For each document, extract:

- **Primary concepts** (3-5): the main topics the document investigates
- **Secondary concepts** (5-10): materials, processes, people, places,
  institutions, standards, projects mentioned significantly
- **Key claims**: assertions the document makes, with evidence strength
- **Open questions**: questions the document raises but does not answer
- **Sources cited**: key references (URLs, authors, papers)

Build a **unified concept list** across all documents. Note which
concepts appear in multiple documents and how frequently.

## 3. Find Connections

Systematically compare documents to find:

- **Shared concepts**: which concepts appear across multiple documents?
  How is each document's treatment different?
- **Complementary findings**: where does document A provide context
  that illuminates document B's findings?
- **Contradictions**: where do documents disagree or present conflicting
  evidence? What might explain the disagreement?
- **Gaps**: topics referenced in multiple documents but never
  investigated in depth — these are promising research directions
- **Surprising links**: unexpected connections between documents from
  different domains (e.g., a supply chain finding that explains a
  policy puzzle, or a historical precedent that anticipates a
  current innovation)
- **Citation overlaps**: which sources appear in multiple documents?
  These are anchor points in the research landscape
- **Temporal threads**: how do findings build on each other
  chronologically? Is there a narrative arc across the research?

Rank connections by **significance**: how much does this connection
change or deepen the student's understanding?

## 4. Generate Interactive HTML Visualization

Generate a self-contained HTML file with D3.js for an interactive
force-directed graph. This is the most important output — architecture
students think visually and spatially.

### Data Structure

Prepare two arrays from your analysis:

**Nodes** — each with: `id`, `label`, `type`, `size`, `color`, `description`, `synthesis`

- `synthesis` (string, 50-200 words): narrative context from your
  analysis. For document nodes: what the document contributes to the
  research landscape. For concept nodes: how the concept connects across
  documents. For person/institution nodes: their role in the research.

Node types and their visual encoding:
- **document** — rectangles, colored by document type:
  - explore = `#4A90D9` (blue)
  - supply-chain = `#50C878` (green)
  - scientific = `#E8913A` (orange)
  - video = `#D94A4A` (red)
  - literature = `#9B59B6` (purple)
  - connections/orchestrate = `#95A5A6` (grey)
- **concept** — circles, sized by frequency across documents, fill `#F0C75E`
- **person/institution** — diamonds, fill `#E8E8E8`

**Edges** — each with: `source`, `target`, `type`, `label`, `weight`, `synthesis`

- `synthesis` (string, optional, 30-100 words): for significant edges
  (contradictions, complementary, surprising), explain the connection
  in detail. Not needed for basic shared-concept edges.

Edge types and their visual encoding:
- shared-concept — solid line, `#666`
- contradiction — dashed line, `#D94A4A` (red)
- citation-overlap — dotted line, `#999`
- complementary — solid line with arrow, `#50C878` (green)
- surprising — thick solid line, `#F0C75E` (gold), slightly glowing

### HTML Template

Generate a complete, self-contained HTML file following this structure.
The file must work when opened directly in a browser (no server needed).

**Key features** (all must be implemented):
1. Force-directed graph with zoom, pan, drag
2. **Synthesis sidebar**: click a node to open a right-side panel showing
   the node's description, synthesis text, and all its connections
3. **Multi-select**: Ctrl+click (or Cmd+click on Mac) to select multiple
   nodes. Selected nodes get a pulsing gold ring. Unselected nodes dim.
4. **Selection panel**: floating bottom panel showing selected nodes with
   "Clear" and "Copy for Report" buttons
5. **Copy for Report**: copies a structured markdown summary of selected
   nodes and their connections to clipboard, ready to paste into Claude
   Code with `/connections-report`

```html
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="utf-8">
  <title>Research Connections — [Student Topic/Date]</title>
  <script src="https://d3js.org/d3.v7.min.js"></script>
  <style>
    body {
      margin: 0; background: #1a1a2e; color: #e0e0e0;
      font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', sans-serif;
      overflow: hidden;
    }

    /* Flex layout: graph + sidebar */
    .container { display: flex; width: 100vw; height: 100vh; }
    #graph { flex: 1; height: 100vh; transition: flex 0.3s; }

    /* Synthesis sidebar (right) */
    .sidebar {
      width: 0; height: 100vh; background: #16213e;
      border-left: 1px solid #0f3460; overflow-y: auto;
      transition: width 0.3s; font-size: 13px; line-height: 1.6;
      box-sizing: border-box;
    }
    .sidebar.open { width: 360px; padding: 20px; }
    .sidebar h2 { font-size: 16px; margin: 0 0 8px 0; }
    .sidebar .type-badge {
      font-size: 11px; color: #999; text-transform: uppercase;
      letter-spacing: 0.5px; margin-bottom: 12px;
    }
    .sidebar .close-btn {
      float: right; cursor: pointer; color: #666; font-size: 20px;
      line-height: 1; padding: 4px;
    }
    .sidebar .close-btn:hover { color: #e0e0e0; }
    .sidebar .section { margin-bottom: 16px; }
    .sidebar .section-title {
      font-size: 11px; color: #999; text-transform: uppercase;
      letter-spacing: 0.5px; margin-bottom: 6px; font-weight: 600;
    }
    .sidebar .connection-item {
      padding: 8px 0; border-bottom: 1px solid #0f346044;
    }
    .sidebar .connection-type {
      font-size: 10px; padding: 2px 6px; border-radius: 3px;
      display: inline-block; margin-left: 6px;
    }

    /* Tooltip */
    .tooltip {
      position: absolute; padding: 10px 14px; background: #16213e;
      border: 1px solid #0f3460; border-radius: 6px; font-size: 13px;
      max-width: 320px; pointer-events: none; opacity: 0;
      transition: opacity 0.2s; line-height: 1.4; z-index: 30;
    }

    /* Legend */
    .legend {
      position: fixed; top: 20px; right: 20px; background: #16213eee;
      border: 1px solid #0f3460; border-radius: 8px; padding: 16px 20px;
      font-size: 11px; z-index: 10; max-width: 200px;
      transition: right 0.3s;
    }
    .legend.shifted { right: 380px; }
    .legend h3 { margin: 0 0 8px 0; font-size: 13px; font-weight: 600; }
    .legend-section {
      margin-top: 10px; font-weight: 600; font-size: 10px;
      text-transform: uppercase; color: #999; letter-spacing: 0.5px;
    }
    .legend-item { display: flex; align-items: center; margin: 3px 0; }
    .legend-swatch {
      width: 12px; height: 12px; margin-right: 8px; border-radius: 2px;
      flex-shrink: 0;
    }

    /* Title */
    .title {
      position: fixed; top: 20px; left: 20px; font-size: 18px;
      font-weight: 600; z-index: 10;
    }
    .subtitle { font-size: 12px; color: #999; margin-top: 4px; }

    /* Instructions */
    .instructions {
      position: fixed; bottom: 20px; left: 20px; font-size: 11px;
      color: #666; z-index: 10; transition: bottom 0.3s;
    }
    .instructions.shifted { bottom: 90px; }

    /* Node labels */
    .node-label, .doc-label {
      font-size: 10px; fill: #bbb; text-anchor: middle;
      pointer-events: none;
    }
    .doc-label { font-size: 9px; fill: #aaa; font-weight: 500; }

    /* Selection ring animation */
    @keyframes pulse {
      0%, 100% { stroke-opacity: 1; }
      50% { stroke-opacity: 0.3; }
    }
    .selection-ring {
      stroke: #F0C75E; stroke-width: 3; fill: none;
      stroke-dasharray: 5,3; animation: pulse 2s infinite;
    }

    /* Selection panel (bottom center) */
    .selection-panel {
      position: fixed; bottom: 20px; left: 50%; transform: translateX(-50%);
      background: #16213eee; border: 1px solid #0f3460; border-radius: 8px;
      padding: 12px 16px; font-size: 12px; z-index: 20;
      max-width: 700px; min-width: 300px; display: none;
    }
    .panel-header {
      display: flex; align-items: center; gap: 10px;
      margin-bottom: 8px;
    }
    .panel-count {
      background: #F0C75E; color: #1a1a2e; border-radius: 10px;
      padding: 1px 8px; font-weight: 600; font-size: 11px;
    }
    .panel-list {
      max-height: 80px; overflow-y: auto; margin-bottom: 8px;
    }
    .panel-list-item {
      display: inline-block; background: #0f3460; padding: 2px 8px;
      border-radius: 4px; margin: 2px; font-size: 11px;
    }
    .panel-btn {
      background: #0f3460; color: #e0e0e0; border: 1px solid #333;
      border-radius: 4px; padding: 5px 12px; cursor: pointer;
      font-size: 11px;
    }
    .panel-btn:hover { background: #1a3a6a; }
    .panel-btn.primary {
      background: #F0C75E; color: #1a1a2e; font-weight: 600;
      border-color: #F0C75E;
    }
    .panel-btn.primary:hover { background: #d4af37; }
  </style>
</head>
<body>
  <div class="title">
    Research Connections Map
    <div class="subtitle">[N] documents · [M] connections · [Date]</div>
  </div>
  <div class="tooltip" id="tooltip"></div>
  <div class="legend" id="legend">
    <h3>Legend</h3>
    <!-- Fill in legend items from actual data -->
    <div class="legend-section">Documents</div>
    <!-- One legend-item per document type present -->
    <div class="legend-section" style="margin-top:8px">Concepts</div>
    <div class="legend-item"><div class="legend-swatch" style="background:#F0C75E;border-radius:50%"></div> Concept (size = frequency)</div>
    <div class="legend-item"><div class="legend-swatch" style="background:#E8E8E8;transform:rotate(45deg);border-radius:0"></div> Person / Institution</div>
    <div class="legend-section" style="margin-top:8px">Connections</div>
    <!-- Edge type legend items with SVG line samples -->
    <div class="legend-section" style="margin-top:8px">Interaction</div>
    <div class="legend-item" style="color:#888">Click: sidebar · Ctrl+click: select</div>
  </div>
  <div class="instructions" id="instructions">
    Click: details · Ctrl+Click: select nodes ·
    Copy for Report: paste directly into Claude Code · Double-click: reset · Scroll: zoom
  </div>

  <div class="container">
    <svg id="graph"></svg>
    <div class="sidebar" id="sidebar">
      <span class="close-btn" onclick="closeSidebar()">&times;</span>
      <div id="sidebar-content"></div>
    </div>
  </div>

  <div class="selection-panel" id="selection-panel">
    <div class="panel-header">
      <strong>Selected Nodes</strong>
      <span class="panel-count" id="panel-count">0</span>
      <span style="flex:1"></span>
      <button class="panel-btn" onclick="clearSelection()">Clear</button>
      <button class="panel-btn primary" id="copy-btn"
              onclick="copyForReport()">Copy for Report</button>
    </div>
    <div class="panel-list" id="panel-list"></div>
  </div>

  <script>
    // === DATA (generated from analysis) ===
    const nodes = [/* node objects with synthesis field */];
    const edges = [/* edge objects with synthesis field */];

    // === STATE ===
    const selectedNodes = new Set();

    // === D3 SETUP ===
    const svg = d3.select('#graph');
    const width = window.innerWidth;
    const height = window.innerHeight;
    svg.attr('width', width).attr('height', height);
    const g = svg.append('g');

    // Zoom
    const zoom = d3.zoom()
      .scaleExtent([0.15, 5])
      .on('zoom', (event) => g.attr('transform', event.transform));
    svg.call(zoom);

    // Edge color map
    const edgeColorMap = {
      'shared': '#555', 'contradiction': '#D94A4A',
      'complementary': '#50C878', 'surprising': '#F0C75E',
      'citation': '#999'
    };

    // Force simulation
    const simulation = d3.forceSimulation(nodes)
      .force('link', d3.forceLink(edges).id(d => d.id).distance(d => {
        if (d.type === 'surprising') return 180;
        if (d.type === 'complementary' || d.type === 'contradiction') return 150;
        return 100;
      }))
      .force('charge', d3.forceManyBody().strength(d =>
        d.type === 'document' ? -400 : -200))
      .force('center', d3.forceCenter(width / 2, height / 2))
      .force('collision', d3.forceCollide().radius(d => d.size + 8))
      .force('x', d3.forceX(width / 2).strength(0.03))
      .force('y', d3.forceY(height / 2).strength(0.03));

    // Draw edges
    const link = g.selectAll('.link')
      .data(edges).enter().append('line')
      .attr('class', 'link')
      .attr('stroke', d => edgeColorMap[d.type] || '#555')
      .attr('stroke-width', d => d.weight || 1)
      .attr('stroke-dasharray', d =>
        d.type === 'contradiction' ? '6,4' :
        d.type === 'citation' ? '2,4' : null)
      .attr('stroke-opacity', 0.6);

    // Draw nodes
    const node = g.selectAll('.node')
      .data(nodes).enter().append('g')
      .attr('class', 'node').style('cursor', 'pointer')
      .call(d3.drag()
        .on('start', dragstarted)
        .on('drag', dragged)
        .on('end', dragended));

    node.each(function(d) {
      const el = d3.select(this);
      if (d.type === 'document') {
        el.append('rect')
          .attr('width', d.size * 2.2).attr('height', d.size * 1.4)
          .attr('x', -d.size * 1.1).attr('y', -d.size * 0.7)
          .attr('rx', 4).attr('ry', 4)
          .attr('fill', d.color).attr('fill-opacity', 0.85)
          .attr('stroke', d.color).attr('stroke-width', 1.5)
          .attr('stroke-opacity', 0.5);
      } else if (d.type === 'person') {
        el.append('rect')
          .attr('width', d.size * 1.2).attr('height', d.size * 1.2)
          .attr('x', -d.size * 0.6).attr('y', -d.size * 0.6)
          .attr('transform', 'rotate(45)')
          .attr('fill', d.color).attr('fill-opacity', 0.7)
          .attr('stroke', '#aaa').attr('stroke-width', 1);
      } else {
        el.append('circle').attr('r', d.size)
          .attr('fill', d.color).attr('fill-opacity', 0.8)
          .attr('stroke', d.color).attr('stroke-width', 1)
          .attr('stroke-opacity', 0.4);
      }
    });

    // Labels
    node.append('text')
      .attr('class', d => d.type === 'document' ? 'doc-label' : 'node-label')
      .attr('dy', d => {
        if (d.type === 'document') return d.size * 0.7 + 14;
        return d.size + 14;
      })
      .text(d => d.label);

    // === TOOLTIP ===
    const tooltip = d3.select('#tooltip');
    node.on('mouseover', (event, d) => {
      tooltip.style('opacity', 1)
        .html('<strong>' + d.label + '</strong><br>' +
          '<span style="color:#999;font-size:11px">' +
          (d.type === 'document' ? 'Document' :
           d.type === 'person' ? 'Person/Institution' : 'Concept') +
          '</span><br><br>' + d.description)
        .style('left', (event.pageX + 14) + 'px')
        .style('top', (event.pageY - 14) + 'px');
    }).on('mousemove', (event) => {
      tooltip.style('left', (event.pageX + 14) + 'px')
        .style('top', (event.pageY - 14) + 'px');
    }).on('mouseout', () => tooltip.style('opacity', 0));

    link.on('mouseover', (event, d) => {
      if (d.label) {
        tooltip.style('opacity', 1)
          .html('<strong>' + d.type.charAt(0).toUpperCase() +
            d.type.slice(1) + ' Connection</strong><br><br>' + d.label)
          .style('left', (event.pageX + 14) + 'px')
          .style('top', (event.pageY - 14) + 'px');
      }
    }).on('mouseout', () => tooltip.style('opacity', 0));

    // === CLICK: Sidebar (single click) or Multi-select (Ctrl+click) ===
    node.on('click', (event, d) => {
      event.stopPropagation();

      if (event.ctrlKey || event.metaKey) {
        // --- Multi-select mode ---
        if (selectedNodes.has(d.id)) {
          selectedNodes.delete(d.id);
        } else {
          selectedNodes.add(d.id);
        }
        updateSelectionVisuals();
        updateSelectionPanel();
      } else {
        // --- Sidebar mode: highlight connections + open sidebar ---
        const connected = new Set();
        edges.forEach(e => {
          const sid = typeof e.source === 'object' ? e.source.id : e.source;
          const tid = typeof e.target === 'object' ? e.target.id : e.target;
          if (sid === d.id) connected.add(tid);
          if (tid === d.id) connected.add(sid);
        });
        connected.add(d.id);
        node.style('opacity', n => connected.has(n.id) ? 1 : 0.1);
        link.style('opacity', e => {
          const sid = typeof e.source === 'object' ? e.source.id : e.source;
          const tid = typeof e.target === 'object' ? e.target.id : e.target;
          return sid === d.id || tid === d.id ? 0.9 : 0.03;
        });
        openSidebar(d);
      }
    });

    // Double-click: reset all
    svg.on('dblclick', () => {
      node.style('opacity', 1);
      link.style('opacity', 0.6);
      closeSidebar();
    });

    // === SIDEBAR FUNCTIONS ===
    function openSidebar(d) {
      const typeLabel = d.type === 'document' ? 'Document' :
        d.type === 'person' ? 'Person / Institution' : 'Concept';

      let html = '<h2>' + d.label + '</h2>';
      html += '<div class="type-badge">' + typeLabel + '</div>';
      html += '<div class="section"><p>' + d.description + '</p></div>';

      if (d.synthesis) {
        html += '<div class="section"><div class="section-title">Synthesis</div>';
        html += '<p>' + d.synthesis + '</p></div>';
      }

      // Connected edges
      const connectedEdges = edges.filter(e => {
        const sid = typeof e.source === 'object' ? e.source.id : e.source;
        const tid = typeof e.target === 'object' ? e.target.id : e.target;
        return sid === d.id || tid === d.id;
      });

      if (connectedEdges.length > 0) {
        // Show significant edges first (surprising, contradiction, complementary)
        const significant = connectedEdges.filter(e =>
          e.type !== 'shared' && e.type !== 'citation');
        const shared = connectedEdges.filter(e =>
          e.type === 'shared' || e.type === 'citation');

        if (significant.length > 0) {
          html += '<div class="section">';
          html += '<div class="section-title">Key Connections</div>';
          significant.forEach(e => {
            const sid = typeof e.source === 'object' ? e.source.id : e.source;
            const other = sid === d.id ? e.target : e.source;
            const otherLabel = typeof other === 'object' ? other.label : other;
            const typeColor = edgeColorMap[e.type] || '#666';
            html += '<div class="connection-item">';
            html += '<strong>' + otherLabel + '</strong>';
            html += '<span class="connection-type" style="background:' +
              typeColor + '22;color:' + typeColor + '">' + e.type + '</span>';
            if (e.label) html += '<br><em style="color:#ccc">' + e.label + '</em>';
            if (e.synthesis) html += '<br><span style="color:#aaa">' + e.synthesis + '</span>';
            html += '</div>';
          });
          html += '</div>';
        }

        if (shared.length > 0) {
          html += '<div class="section">';
          html += '<div class="section-title">Shared With (' + shared.length + ')</div>';
          const others = shared.map(e => {
            const sid = typeof e.source === 'object' ? e.source.id : e.source;
            const other = sid === d.id ? e.target : e.source;
            return typeof other === 'object' ? other.label : other;
          });
          html += '<p style="color:#aaa">' + others.join(', ') + '</p>';
          html += '</div>';
        }
      }

      document.getElementById('sidebar-content').innerHTML = html;
      document.getElementById('sidebar').classList.add('open');
      document.getElementById('legend').classList.add('shifted');
    }

    function closeSidebar() {
      document.getElementById('sidebar').classList.remove('open');
      document.getElementById('legend').classList.remove('shifted');
    }

    // === MULTI-SELECT FUNCTIONS ===
    function updateSelectionVisuals() {
      g.selectAll('.selection-ring').remove();

      node.each(function(d) {
        if (selectedNodes.has(d.id)) {
          const el = d3.select(this);
          if (d.type === 'document') {
            el.insert('rect', ':first-child')
              .attr('class', 'selection-ring')
              .attr('width', d.size * 2.2 + 8).attr('height', d.size * 1.4 + 8)
              .attr('x', -d.size * 1.1 - 4).attr('y', -d.size * 0.7 - 4)
              .attr('rx', 6);
          } else {
            el.insert('circle', ':first-child')
              .attr('class', 'selection-ring')
              .attr('r', (d.type === 'person' ? d.size * 0.85 : d.size) + 4);
          }
        }
      });

      if (selectedNodes.size > 0) {
        node.style('opacity', n => selectedNodes.has(n.id) ? 1 : 0.25);
        link.style('opacity', e => {
          const sid = typeof e.source === 'object' ? e.source.id : e.source;
          const tid = typeof e.target === 'object' ? e.target.id : e.target;
          return selectedNodes.has(sid) && selectedNodes.has(tid) ? 0.9 : 0.04;
        });
      } else {
        node.style('opacity', 1);
        link.style('opacity', 0.6);
      }

      // Shift instructions when panel is visible
      document.getElementById('instructions').classList.toggle(
        'shifted', selectedNodes.size > 0);
    }

    function updateSelectionPanel() {
      const panel = document.getElementById('selection-panel');
      const list = document.getElementById('panel-list');
      const count = document.getElementById('panel-count');

      if (selectedNodes.size === 0) {
        panel.style.display = 'none';
        return;
      }

      panel.style.display = 'block';
      count.textContent = selectedNodes.size;

      let html = '';
      selectedNodes.forEach(id => {
        const n = nodes.find(n => n.id === id);
        if (n) {
          html += '<span class="panel-list-item" style="border-left:3px solid ' +
            (n.color || '#666') + '">' + n.label + '</span>';
        }
      });
      list.innerHTML = html;
    }

    function clearSelection() {
      selectedNodes.clear();
      updateSelectionVisuals();
      updateSelectionPanel();
    }

    function copyForReport() {
      const selected = nodes.filter(n => selectedNodes.has(n.id));
      const relevantEdges = edges.filter(e => {
        const sid = typeof e.source === 'object' ? e.source.id : e.source;
        const tid = typeof e.target === 'object' ? e.target.id : e.target;
        return selectedNodes.has(sid) && selectedNodes.has(tid);
      });

      // Build a complete prompt — students just paste into Claude Code
      let text = '/connections-report ';
      text += 'Write a connections report synthesizing these selected research nodes. ';
      text += 'Read the full source documents for each, find how they connect, ';
      text += 'do additional research to strengthen weak connections, and write ';
      text += 'a coherent narrative essay (1500-3000 words) with Zusammenfassung.\n\n';

      text += '## Selected Research Nodes\n\n';
      selected.forEach(n => {
        text += '- **' + n.label + '** (' + n.type + '): ' + n.description + '\n';
        if (n.synthesis) text += '  Synthesis: ' + n.synthesis + '\n';
      });

      if (relevantEdges.length > 0) {
        text += '\n## Connections Between Selected\n\n';
        relevantEdges.forEach(e => {
          const sLabel = typeof e.source === 'object' ? e.source.label : e.source;
          const tLabel = typeof e.target === 'object' ? e.target.label : e.target;
          text += '- ' + sLabel + ' ↔ ' + tLabel + ' (' + e.type + ')';
          if (e.label) text += ': ' + e.label;
          text += '\n';
          if (e.synthesis) text += '  ' + e.synthesis + '\n';
        });
      }

      text += '\n## Key Questions to Address\n\n';
      text += '- What story emerges when these nodes are read together?\n';
      text += '- Where are the connections strong (well-documented) vs. weak (speculative)?\n';
      text += '- What new questions appear that no single document asks?\n';

      navigator.clipboard.writeText(text).then(() => {
        const btn = document.getElementById('copy-btn');
        btn.textContent = 'Copied! Paste into Claude Code';
        setTimeout(() => { btn.textContent = 'Copy for Report'; }, 3000);
      });
    }

    // === TICK ===
    simulation.on('tick', () => {
      link.attr('x1', d => d.source.x).attr('y1', d => d.source.y)
        .attr('x2', d => d.target.x).attr('y2', d => d.target.y);
      node.attr('transform', d => 'translate(' + d.x + ',' + d.y + ')');
    });

    // === DRAG ===
    function dragstarted(event, d) {
      if (!event.active) simulation.alphaTarget(0.3).restart();
      d.fx = d.x; d.fy = d.y;
    }
    function dragged(event, d) { d.fx = event.x; d.fy = event.y; }
    function dragended(event, d) {
      if (!event.active) simulation.alphaTarget(0);
      d.fx = null; d.fy = null;
    }

    // Initial zoom to fit
    setTimeout(() => {
      svg.call(zoom.transform,
        d3.zoomIdentity.translate(width * 0.05, height * 0.05).scale(0.9));
    }, 2000);
  </script>
</body>
</html>
```

### Important Notes for Generation

- Replace the placeholder `nodes` and `edges` arrays with actual data
  from your analysis. Every node and edge must have real data.
- **Every node MUST have a `synthesis` field** (50-200 words) with
  narrative context from your analysis. This powers the sidebar.
- **Significant edges** (contradiction, complementary, surprising) MUST
  have a `synthesis` field (30-100 words) explaining the connection.
- Set node `size` based on importance: documents = 16-24, frequent
  concepts = 10-20 (scaled by frequency), rare concepts = 6-10
- Set node `color` based on the color scheme above
- Fill in the legend HTML with the actual node and edge types present
- Update the title, subtitle, and date
- The file must be **complete and working** — test mentally that all
  variables are defined, all functions exist, all styles apply
- Keep node count manageable: **max 60 nodes**. If there are more
  concepts, show only the most significant ones.

Save to `output/maps/connections-map-[YYYY-MM-DD].html`

## 5. Write the Narrative Document

Structure:

- **Zusammenfassung** (German, 150-300 words) summarizing key
  connections, contradictions, and suggested directions
- **Documents Analyzed** — list of all documents included, grouped
  by type, with one-line summaries
- **Research Landscape** — what topics have been covered, what is the
  overall shape of the student's research so far?
- **Key Connections** (5-8) — detailed discussion of the most
  significant connections found. For each: which documents are
  connected, what the connection is, why it matters, what it suggests
  for further research. Reference specific passages or findings.
- **Contradictions & Tensions** — where documents disagree or present
  conflicting perspectives, with analysis of why and what it means
- **Gaps & Blind Spots** — topics mentioned but never investigated,
  perspectives missing, domains not yet explored
- **Surprising Connections** — the most unexpected links that emerged,
  especially across different domains or document types
- **Suggested Next Steps** — specific research commands that would
  fill gaps, strengthen weak connections, or resolve contradictions.
  Be specific: "A `/research` on [X] would test the claim in
  [document A] against the data in [document B]"
- **Sources** — list of all documents analyzed with file paths

Save to `research/connections-[YYYY-MM-DD].md`

## 6. Additional Visualizations (Generate Only When Appropriate)

Based on the data available in the research documents, propose which
of the following additional visualizations would be meaningful. Do NOT
generate all of them — only those where sufficient data exists.

All additional visualizations use the same dark theme (#1a1a2e), font
stack, and self-contained HTML pattern as the connection map. Include
D3.js v7 via CDN. Save each to `output/maps/`.

### Timeline View

**Generate when:** research documents span different time periods OR
the research includes historical precedents, chronological developments,
or dated publications.

**Output:** `output/maps/timeline-[YYYY-MM-DD].html`

Structure: Horizontal timeline using D3.js. X-axis is time (dates of
documents, historical events, publication dates extracted from research).
Each item is a card showing: title, date, type (color-coded same as
force graph), brief description, and concept tags. Cards stack
vertically when dates overlap. Interactive: hover for details, click
to expand, filter buttons by document type at the top.

Include a complete, working HTML file with:
- D3 time scale on x-axis, auto-ranging from earliest to latest date
- Cards positioned along the timeline, color-coded by type
- Hover tooltips with full description
- Filter toggles (show/hide by document type)
- Zoom on the time axis (scroll to zoom, drag to pan)

### Supply Chain Sankey Diagram

**Always generate when:** research includes ANY supply chain documents
OR documents describing material flows, transformation stages, or actor
networks. Do NOT ask — just generate it alongside the connection map.

**Output:** `output/maps/sankey-supply-chains-[YYYY-MM-DD].html`

Structure: A tabbed, scrollable page with one Sankey diagram per
material supply chain. Use an inline D3 sankey layout (no external
plugin). Each tab shows:

1. **Sankey flow diagram** at the top: nodes = supply chain stages
   (Collection → Processing → Manufacturing → Product → Construction →
   End of Life), color-coded by stage. Flow widths represent relative
   volume. Hover shows flow details with specific numbers, actors, costs.

2. **Material properties cards** below the diagram — architecture-relevant
   data organized as cards. Include ALL of these when data exists:
   - **Structural**: compressive/tensile strength, density, wall thickness
   - **Thermal**: conductivity, R-value, thermal mass, operating range
   - **Environmental**: embodied carbon (kg CO₂/m³), embodied energy,
     LCA comparison vs. concrete/brick/EPS, end-of-life circularity
   - **Economics**: cost per m², cost per m³, market size, cost vs.
     conventional alternatives (show as comparison bars)
   - **Building Codes**: which standards apply (DIN, EN, ISO), what
     gaps exist, certification pathway status
   - **Kiln Parameters** (if relevant): temperature, particle size,
     foaming agent, cycle time — for studio experimentation
   - **Architectural Potential**: which building elements (wall, facade,
     insulation, interior, roof, foundation), acoustic/fire/moisture
     behavior, and design opportunities

3. **Comparison table** when multiple materials are present — side-by-side
   thermal conductivity, strength, fire class, moisture, lifespan, cost

4. **Built examples**: specific buildings with architect, year, location,
   and what was notable about each

5. **Key producers**: company names, locations, capacities, founding dates

Same dark theme (#1a1a2e), same font stack, self-contained HTML. The
page should scroll vertically to accommodate the rich information below
each Sankey diagram.

### Material Property Scatter Plot

**Generate when:** scientific research documents contain quantitative
property data for **3+ materials or formulations** (strength,
conductivity, density, cost, embodied carbon, etc.).

**Output:** `output/maps/scatter-[topic-slug]-[YYYY-MM-DD].html`

Structure: D3.js scatter plot. Each point is a material or formulation.
Two dropdown menus let the user select which property maps to X-axis
and Y-axis. Point size can encode a third variable. Color encodes
material family or document source. Interactive: hover for full
property card, click to highlight source document, axis selection
dropdowns update the plot in real time.

### Auto-Generate vs. Propose

After completing the connection analysis (Section 3), assess the data:

**Always auto-generate (no confirmation needed):**
- If any supply chain documents exist → generate **Sankey Diagram**
  with full material properties, building codes, built examples, and
  comparison tables. This is core studio output.

**Propose and wait for confirmation:**
- If documents span >6 months or include historical content → propose
  **Timeline View**
- If ≥3 materials have quantitative property data → propose
  **Scatter Plot**

Tell the student which additional visualizations were generated and
which are available on request.

## 7. Present Results

Tell the student:
- Where all files are saved (connection map, narrative, any additional
  visualizations)
- How to open the HTML visualizations (open in any web browser)
- Interaction guide:
  - **Click** a node to open the synthesis sidebar
  - **Ctrl+Click** (Cmd+Click on Mac) to select multiple nodes
  - **"Copy for Report"** copies a complete prompt to clipboard —
    the student just pastes it directly into Claude Code and it runs.
    No need to type a command first; the clipboard already contains
    the `/connections-report` command with all selected nodes,
    their synthesis text, connection details, and guiding questions.
  - **Double-click** to reset all highlighting
  - **Scroll** to zoom, **drag** to pan or move nodes
- The **3 most interesting findings** from the analysis — lead with
  what is most surprising or most useful for their studio work

## 8. Report Mode — Generate Narrative from Selection

When invoked via `/connections-report` with a pasted selection (from
the connection map's "Copy for Report" button) or with the student
naming specific topics directly:

### 8a. Parse the Selection

Read the pasted selection to identify:
- Which documents are referenced (map to files in `research/`)
- Which concepts are highlighted
- Which connections were identified between them

If the student names topics by hand instead of pasting, search
`research/` for matching documents.

### 8b. Read Source Documents

Read the full text of each referenced research document. Extract:
- Key findings relevant to the selected concepts
- Direct quotes and specific data points
- Open questions and gaps identified in each document

### 8c. Strengthen Weak Connections

For each connection between selected nodes:
- If the connection is well-documented (both documents discuss it
  with evidence), synthesize the two perspectives into a coherent
  narrative
- If the connection is weak or speculative, do additional research:
  - WebSearch for the two concepts together
  - Look for academic papers that bridge the two topics
  - Search YouTube for talks or lectures that address both
- Note which connections are well-supported and which required
  additional research to substantiate

### 8d. Write the Report

Structure:
- **Zusammenfassung** (German, 150-300 words)
- **Selected Scope** — what topics were selected and why this subset
  is interesting as a unit
- **Narrative Synthesis** — a coherent essay (1,500-3,000 words)
  that tells the story of how these topics connect. This is NOT a
  list of connections — it is a flowing argument that uses each
  topic as evidence or context for a larger point. Use specific
  data, quotes, and findings from the source documents.
- **Strengthened Connections** — connections where additional research
  revealed new information not in the original documents
- **New Questions** — questions that emerge from reading these
  documents together that do not appear in any individual document
- **Sources** — all source documents referenced, plus any new sources
  found during additional research

Save to `research/connections-report-[YYYY-MM-DD].md`

### 8e. Present Results

Tell the student:
- Where the report is saved
- Which connections were strongest (well-documented in existing research)
- Which connections required new research (and what was found)
- What the most surprising insight was from reading these documents together
- Suggest follow-up: specific `/research` or `/explore` commands that
  would deepen the weakest connections
