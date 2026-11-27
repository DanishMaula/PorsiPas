# Project State: PorsiPas

## Project Reference

See: `.planning/PROJECT.md` (updated 2026-11-20)

**Core value:** Perhitungan kalori & makronutrien masakan rumahan Indonesia yang akurat berbasis TKPI (per 100g BDD), konversi URT, yield & retention factor metode masak, target Mifflin-St Jeor, dan visualisasi "Isi Piringku".
**Current focus:** Phase 1 complete & verified — ready for Phase 2 (`/gsd-discuss-phase 2` or `/gsd-plan-phase 2`).

## Current Position

- **Milestone:** v1.0 MVP
- **Phase:** 2 of 7 (Local Master Data (Drift SQLite) & Versioned Asset Seeder) — Next up
- **Plan:** Phase 1 complete (3/3 plans done & verified)
- **Status:** Phase 1 verified (`flutter analyze` 0 issues, 19/19 tests passing). Ready to discuss/plan Phase 2 per interactive mode.
- **Last activity:** 2026-11-27 — Completed and verified Phase 1 (`01-01`, `01-02`, `01-03`)

Progress: `[█░░░░░░░░░] 14%` (1/7 phases complete)

## Accumulated Context

### Key Architectural & Product Decisions
- **Architecture:** Feature-First Clean Architecture (`lib/core/`, `lib/features/<feature>/{data,domain,presentation}`), `flutter_bloc` + `equatable`, `go_router`, `get_it`.
- **Hybrid Storage:** Drift (SQLite) for local offline master data (`foods`, `urt_conversions`, `cooking_factors`, `seed_metadata`) + Firebase Auth & Cloud Firestore for user data.
- **Nutrition Formula:** Strictly **Mifflin-St Jeor** (not Harris-Benedict); domain unit tests must guarantee 100% accuracy for Mifflin-St Jeor, BDD/URT conversions, and 5 cooking methods' yield/retention factors.
- **Master Data Seeding:** Use `assets/data/` JSON/CSV with 15–20 mock Indonesian home-cooking items and `seed_version` so the final Nutrition/Food Tech dataset can replace the asset file + bump `seed_version` with zero code changes.
- **Phase 1 Completed Baseline (2026-11-27):**
  - **Packages Resolved (Dart SDK 3.12.0):** `flutter_bloc ^9.1.2`, `equatable ^3.0.0`, `go_router ^18.1.4`, `get_it ^9.3.0`, `google_fonts ^8.0.0` (8.2.1), `intl ^0.20.2`.
  - **Design System:** Fresh Organik (Hijau Daun `#1E7A46` + Aksen Hangat `#C2590B`), Light Mode only, `Plus Jakarta Sans`, macro & Isi Piringku semantic tokens, 6 `Porsi*` widgets.
  - **Navigation:** 4-tab `StatefulShellRoute.indexedStack` (`Beranda`, `Kalkulator`, `Diary`, `Profil`) + reserved `/login`, `/register`, `/profile-setup` + injectable redirect hook.
  - **Error Handling:** Dart 3 native `sealed class Result<T>` + `Failure` hierarchy + `Equatable` (no `freezed`).
  - **Linting:** `flutter_lints` + 8 strict rules + `analyzer.exclude: ['**/*.g.dart']`.
- **Execution Mode:** Interactive — always request user approval before executing each phase and plan.
- **Active MCPs:** `context7` (package docs), `dart` (diagnostics/analysis), `firebase` (Firebase config & deployment). Use `firestore-rules-author` subagent for `firestore.rules`.

### Pending Todos
- Mulai Phase 2: `/gsd-discuss-phase 2` (atau `/gsd-plan-phase 2`) untuk merancang skema Drift (`foods`, `urt_conversions`, `cooking_factors`), format `assets/data/`, dan mekanisme `seed_version`.

### Blockers / Concerns
- Dataset final TKPI, URT, dan yield/retention factor masih dalam penyusunan tim Gizi & Teknologi Pangan — dimitigasi dengan arsitektur Versioned Asset Seeder (`seed_version`) dan 15–20 mock data pada Phase 2.

## Session Continuity

- **Last session:** 2026-11-27
- **Stopped at:** Completed & verified Phase 1 (`01-01`, `01-02`, `01-03`), updated `ROADMAP.md`, `REQUIREMENTS.md`, `STATE.md`.
- **Next step:** Run `/gsd-discuss-phase 2` or `/gsd-plan-phase 2` to prepare Phase 2 (Drift SQLite + Versioned Asset Seeder).
