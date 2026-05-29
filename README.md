# CIT — Check Inspection Tool

SAP BTP application — CAP backend, SAPUI5 frontend, SAP AI Core (Mistral) for BRM authoring.

## Documentation

- [Architecture & approach (Figma Slides)](https://www.figma.com/slides/mW0gvAev5nydbfkRwUtTso)

## Stack

- **Backend** : SAP CAP (Node.js)
- **Frontend** : SAPUI5 / Fiori Elements
- **BRM authoring** : SAP AI Core + Mistral
- **Database** : HANA Cloud (SQLite for local dev)
- **Integration** : SAP ECC P83 via OData / Integration Suite

## Getting started

```bash
npm install
npm run dev
```

## Project structure

```
db/          — CDS data model
srv/         — OData services & business logic
app/admin/   — Admin UI (rule management)
app/engineer/— Shop Engineer UI (inspection levels)
ai/          — AI Core prompts & DSL schemas
```
