namespace cit;

// ── Nomenclature moteur (chargée depuis S/4 / ECC P83) ──────────────────────
entity EngineModels {
  key ID          : UUID;
  code            : String(20);
  description     : String(200);
  modules         : Composition of many Modules on modules.model = $self;
}

entity Modules {
  key ID          : UUID;
  model           : Association to EngineModels;
  code            : String(20);
  description     : String(200);
  items           : Composition of many Items on items.module = $self;
}

entity Items {
  key ID          : UUID;
  module          : Association to Modules;
  functionCode    : String(20);
  description     : String(200);
  partNumber      : String(50);
}

// ── Moteur de règles ─────────────────────────────────────────────────────────
entity Rules {
  key ID          : UUID;
  title           : String(200);
  nlpText         : LargeString;       // règle en langage naturel (admin)
  compiledDSL     : LargeString;       // JSON/DSL compilé par le LLM
  scope           : String(20);        // GLOBAL | SHOP | CLIENT
  shopCode        : String(20);        // si scope = SHOP
  clientCode      : String(20);        // si scope = CLIENT
  status          : String(20);        // DRAFT | ACTIVE | ARCHIVED
  version         : Integer default 1;
  createdBy       : String(100);
  createdAt       : Timestamp;
  activatedBy     : String(100);
  activatedAt     : Timestamp;
  history         : Composition of many RuleVersions on history.rule = $self;
}

entity RuleVersions {
  key ID          : UUID;
  rule            : Association to Rules;
  version         : Integer;
  nlpText         : LargeString;
  compiledDSL     : LargeString;
  changedBy       : String(100);
  changedAt       : Timestamp;
}

// ── Révisions moteur ─────────────────────────────────────────────────────────
entity Revisions {
  key ID          : UUID;
  engineModel     : Association to EngineModels;
  serialNumber    : String(50);
  shopCode        : String(20);
  visitReason     : String(100);       // FOD | ROUTINE | AOG | ...
  status          : String(20);        // OPEN | IN_PROGRESS | COMPLETED;
  createdAt       : Timestamp;
  inspectionLines : Composition of many InspectionLines on inspectionLines.revision = $self;
}

entity InspectionLines {
  key ID          : UUID;
  revision        : Association to Revisions;
  item            : Association to Items;
  level           : String(1);         // A | B | C
  ruleApplied     : Association to Rules;
  ruleVersion     : Integer;
  decisionLog     : LargeString;       // trace audit : quelle règle → quel niveau
}

// ── Audit trail ──────────────────────────────────────────────────────────────
entity AuditLog {
  key ID          : UUID;
  entity          : String(50);
  entityId        : UUID;
  action          : String(50);
  performedBy     : String(100);
  performedAt     : Timestamp;
  details         : LargeString;
}
