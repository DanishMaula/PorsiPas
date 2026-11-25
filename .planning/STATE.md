# Project State: PorsiPas

## Project Reference

See: `.planning/PROJECT.md` (updated 2026-11-20)

**Core value:** Perhitungan kalori & makronutrien masakan rumahan Indonesia yang akurat berbasis TKPI (per 100g BDD), konversi URT, yield & retention factor metode masak, target Mifflin-St Jeor, dan visualisasi "Isi Piringku".
**Current focus:** Phase 1 context locked — ready to run `/gsd-plan-phase 1`.

## Current Position

- **Milestone:** v1.0 MVP
- **Phase:** 1 of 7 (Project Foundation, Clean Architecture & Design System)
- **Plan:** Not yet planned (Context gathered)
- **Status:** Phase 1 context documented in `.planning/phases/01-project-foundation/01-CONTEXT.md` — ready for Phase 1 planning
- **Last activity:** 2026-11-23 — Completed `/gsd-discuss-phase 1` and locked Phase 1 visual, navigation, error-handling, and lint decisions

Progress: `[░░░░░░░░░░] 0%` (0/7 phases complete)

## Accumulated Context

### Key Architectural & Product Decisions
- **Architecture:** Feature-First Clean Architecture (`lib/core/`, `lib/features/<feature>/{data,domain,presentation}`), `flutter_bloc` + `equatable`, `go_router`, `get_it`.
- **Hybrid Storage:** Drift (SQLite) for local offline master data (`foods`, `urt_conversions`, `cooking_factors`, `seed_metadata`) + Firebase Auth & Cloud Firestore for user data.
- **Nutrition Formula:** Strictly **Mifflin-St Jeor** (not Harris-Benedict); domain unit tests must guarantee 100% accuracy for Mifflin-St Jeor, BDD/URT conversions, and 5 cooking methods' yield/retention factors.
- **Master Data Seeding:** Use `assets/data/` JSON/CSV with 15–20 mock Indonesian home-cooking items and `seed_version` so the final Nutrition/Food Tech dataset can replace the asset file + bump `seed_version` with zero code changes.
- **Phase 1 Locked Decisions (2026-11-23):**
  - **Design System:** Fresh Organik (Hijau Daun + Aksen Hangat), Light Mode only for v1, font `Plus Jakarta Sans`, semantic colors for macros & Isi Piringku.
  - **Navigation:** 4-tab bottom navigation (`Beranda`, `Kalkulator`, `Diary`, `Profil`) with `go_router` `StatefulShellRoute.indexedStack`.
  - **Error Handling & Models:** Dart 3 native `sealed class Result<T>` + `Failure` hierarchy + `Equatable` (no `freezed`, `build_runner` reserved for Drift).
  - **Linting:** `flutter_lints` + selected strict rules (`prefer_const_*`, `always_declare_return_types`, `unawaited_futures`, `avoid_print`, `prefer_single_quotes`, `directives_ordering`).
- **Execution Mode:** Interactive — always request user approval before executing each phase and plan.
- **Active MCPs:** `context7` (package docs), `dart` (diagnostics/analysis), `firebase` (Firebase config & deployment). Use `firestore-rules-author` subagent for `firestore.rules`.

### Pending Todos
- Jalankan `/gsd-plan-phase 1` untuk menyusun rencana implementasi detail Phase 1 berdasarkan `01-CONTEXT.md`.

### Blockers / Concerns
- Dataset final TKPI, URT, dan yield/retention factor masih dalam penyusunan tim Gizi & Teknologi Pangan — dimitigasi dengan arsitektur Versioned Asset Seeder (`seed_version`) dan 15–20 mock data pada Phase 2.

## Session Continuity

- **Last session:** 2026-11-23
- **Stopped at:** Completed `/gsd-discuss-phase 1`, wrote `.planning/phases/01-project-foundation/01-CONTEXT.md`, and updated `STATE.md`.
- **Next step:** Run `/gsd-plan-phase 1` to create executable Phase 1 plan(s) for user approval.
