# Synthetic Types — Research Toolkit

**ABK Stuttgart · SS2026 · Prof. Daniel Koehler**

AI-gestütztes Recherche-Toolkit für das Studio "Synthetische Typen / Modelling Models".

---

## Was ist das? / What is this?

Dieses Projekt ist ein vorkonfiguriertes Forschungswerkzeug, das **Claude Code** (Anthropic's AI-Programmierassistent) nutzt, um Recherchen zu Materiallieferketten, Baumethoden und Robotik durchzuführen. Die Ergebnisse werden als strukturierte Markdown-Dokumente gespeichert, die in **Google NotebookLM** importiert werden können.

This is a pre-configured research toolkit using **Claude Code** (Anthropic's AI coding assistant) to research material supply chains, construction methods, and robotics. Results are saved as structured markdown documents ready for import into **Google NotebookLM**.

---

## Voraussetzungen / Prerequisites

1. **Claude Pro oder Max Abo** ($20/Monat) → [claude.ai](https://claude.ai)
2. **Node.js 18+** → [nodejs.org](https://nodejs.org)
3. **Claude Code** (wird vom Setup-Skript installiert)

---

## Installation

### macOS / Linux
```bash
git clone https://github.com/djrkohler/Synthetic-Types.git
cd Synthetic-Types
chmod +x setup.sh
./setup.sh
```

### Windows
```powershell
git clone https://github.com/djrkohler/Synthetic-Types.git
cd Synthetic-Types
powershell -ExecutionPolicy Bypass -File setup.ps1
```

### Starten / Start
```bash
claude
```

---

## Befehle / Commands

| Befehl | Beschreibung | Beispiel |
|--------|-------------|---------|
| `/research` | Thema recherchieren | `/research "Stampflehm Lieferkette Deutschland"` |
| `/youtube` | YouTube-Video analysieren | `/youtube "https://youtube.com/watch?v=..."` |
| `/supply-chain` | Lieferkette eines Materials | `/supply-chain "Brettsperrholz"` |
| `/construction` | Baumethode erforschen | `/construction "robotischer Lehmbau"` |
| `/robotics` | Robotik-Thema recherchieren | `/robotics "NEURA Robotics MAiRA"` |
| `/export` | Für NotebookLM vorbereiten | `/export` |

Du kannst auch einfach frei mit Claude sprechen — auf Deutsch oder Englisch.

You can also just chat freely with Claude — in German or English.

---

## NotebookLM Workflow

1. Recherchiere mit Claude Code → Dateien werden in `research/` gespeichert
2. Nutze `/export` um die Dokumente für NotebookLM zu formatieren
3. Öffne [notebooklm.google.com](https://notebooklm.google.com)
4. Erstelle ein neues Notebook → "Quelle hinzufügen" → `.md`-Dateien hochladen
5. Nutze NotebookLM für:
   - **Audio-Überblick** (Podcast-Zusammenfassung deiner Recherche)
   - **Quellenübergreifende Fragen** ("Vergleiche Stampflehm und CLT")
   - **Lernhilfen & Gliederungen** für Präsentationen

---

## Ordnerstruktur / Folder Structure

```
Synthetic-Types/
├── research/          ← Research results (Markdown)
├── sources/           ← Raw sources (transcripts, PDFs)
├── output/            ← Final documents (NotebookLM-ready)
├── templates/         ← Document templates
├── references/        ← Studio brief, companies, glossary
├── CLAUDE.md          ← Project instructions for Claude
└── .claude/           ← Skills, commands, settings
```

---

## Hilfe / Help

- **Claude antwortet nicht wie erwartet?** → Versuche, deine Frage anders zu formulieren
- **YouTube-Transkript funktioniert nicht?** → Nicht alle Videos haben Untertitel
- **Playwright-Fehler?** → Ist optional, die Recherche funktioniert auch ohne
- **Fragen?** → Schreib Prof. Koehler oder poste ein Issue auf GitHub
