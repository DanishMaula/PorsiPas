# Project State: PorsiPas

## Project Reference

See: `.planning/PROJECT.md` (updated 2026-11-20)

**Core value:** Perhitungan kalori & makronutrien masakan rumahan Indonesia yang akurat berbasis TKPI (per 100g BDD), konversi URT, yield & retention factor metode masak, target Mifflin-St Jeor, dan visualisasi "Isi Piringku".
**Current focus:** Project initialized — ready to review roadmap and plan Phase 1.

## Current Position

- **Milestone:** v1.0 MVP
- **Phase:** 0 of 7 (Initialization complete)
- **Plan:** Not started
- **Status:** Ready for Phase 1 planning (awaiting user approval per interactive mode)
- **Last activity:** 2026-11-20 — Initialized `.planning/` artifacts (`PROJECT.md`, `config.json`, `REQUIREMENTS.md`, `ROADMAP.md`, `STATE.md`)

Progress: `[░░░░░░░░░░] 0%` (0/7 phases complete)

## Accumulated Context

### Key Architectural & Product Decisions
- **Architecture:** Feature-First Clean Architecture (`lib/core/`, `lib/features/<feature>/{data,domain,presentation}`), `flutter_bloc` + `equatable`, `go_router`, `get_it`.
- **Hybrid Storage:** Drift (SQLite) for local offline master data (`foods`, `urt_conversions`, `cooking_factors`, `seed_metadata`) + Firebase Auth & Cloud Firestore for user data.
- **Nutrition Formula:** Strictly **Mifflin-St Jeor** (not Harris-Benedict); domain unit tests must guarantee 100% accuracy for Mifflin-St Jeor, BDD/URT conversions, and 5 cooking methods' yield/retention factors.
- **Master Data Seeding:** Use `assets/data/` JSON/CSV with 15–20 mock Indonesian home-cooking items and `seed_version` so the final Nutrition/Food Tech dataset can replace the asset file + bump `seed_version` with zero code changes.
- **Execution Mode:** Interactive — always request user approval before executing each phase and plan.
- **Active MCPs:** `context7` (package docs), `dart` (diagnostics/analysis), `firebase` (Firebase config & deployment). Use `firestore-rules-author` subagent for `firestore.rules`.

### Pending Todos
- Konfirmasi persetujuan `REQUIREMENTS.md` dan `ROADMAP.md` oleh pengguna.
- Mulai Phase 1 (`/gsd-plan-phase 1` atau `/gsd-discuss-phase 1`).

### Blockers / Concerns
- Dataset final TKPI, URT, dan yield/retention factor masih dalam penyusunan tim Gizi & Teknologi Pangan — dimitigasi dengan arsitektur Versioned Asset Seeder (`seed_version`) dan 15–20 mock data pada Phase 2.

## Session Continuity

- **Last session:** 2026-11-20
- **Stopped at:** Completed `/gsd-new-project` initialization and committed `.planning/` artifacts.
- **Next step:** Review roadmap with user, then proceed to `/gsd-plan-phase 1` (or `/gsd-discuss-phase 1` if UI/UX design details for Phase 1 need discussion first).
