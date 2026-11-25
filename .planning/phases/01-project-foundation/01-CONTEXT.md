# Phase 1: Project Foundation, Clean Architecture & Design System — Context

**Gathered:** 2026-11-23
**Status:** Ready for planning
**Requirements:** `ARCH-01`, `ARCH-02`, `QUAL-02`

<domain>
## Phase Boundary

Phase 1 menetapkan fondasi teknis dan visual aplikasi **PorsiPas** agar seluruh fitur pada Phase 2–7 dapat dibangun di atas struktur yang konsisten, terisolasi, dan mudah diuji:
- Struktur folder Feature-First Clean Architecture (`lib/core/` dan `lib/features/<feature>/{data,domain,presentation}`).
- Dependency injection (`get_it`), routing deklaratif (`go_router`), dan dasar state management (`flutter_bloc` + `equatable`).
- Design system Material 3 (warna Fresh Organik, tipografi `Plus Jakarta Sans`, komponen UI dasar) serta shell navigasi 4 tab dengan halaman placeholder rapi.
- Baseline quality gate: `analysis_options.yaml` diperketat, `flutter analyze` nol warning/error, dan baseline unit/widget test lulus.

Tidak termasuk dalam Phase 1: skema Drift & Asset Seeder (Phase 2), integrasi Firebase & Auth nyata (Phase 3), logika kalkulasi gizi/Mifflin-St Jeor (Phase 4–5), maupun Dark Mode (ditunda ke v2).
</domain>

<decisions>
## Implementation Decisions

### 1. Identitas Visual, Tema & Tipografi (`ARCH-02`)
- **Arah Visual:** **Fresh Organik** — warna primer **Hijau Daun** segar yang merepresentasikan bahan pangan sehat dan alami, dipadukan dengan **Aksen Hangat** (oranye/terracotta lembut atau amber) untuk elemen aksi/kalori serta permukaan terang yang bersih (*off-white / soft warm neutral*).
- **Mode Tema:** Fokus **Light Mode** penuh untuk v1.0 (Dark Mode secara eksplisit ditunda agar kualitas kontras & konsistensi visual Light Mode optimal).
- **Tipografi:** Menggunakan **`Plus Jakarta Sans`** (menggunakan package `google_fonts` atau font asset lokal yang tetap aman dipakai offline dengan fallback bersih).
- **Token Semantik Gizi & "Isi Piringku":** Disiapkan sejak Phase 1 di `lib/core/theme/` agar Phase 4–7 konsisten:
  - Token warna makronutrien: Energi/Kalori, Protein, Lemak, Karbohidrat, Serat, dan Air.
  - Token warna 4 kelompok pangan **"Isi Piringku"**: Makanan Pokok, Lauk Pauk, Sayur, Buah.
- **Bahasa UI:** Seluruh label, navigasi, tombol, pesan kosong/error, dan komponen menggunakan **Bahasa Indonesia** yang ramah dan mudah dipahami.

### 2. Struktur Navigasi Utama (`go_router` Shell) (`ARCH-01`)
- **Bottom Navigation Bar:** **4 Tab Utama**:
  1. **Beranda** (`/dashboard`) — Dashboard, progres kalori, Isi Piringku, Water Tracker, umpan balik gizi.
  2. **Kalkulator** (`/calculator`) — Pencarian TKPI, input gram/URT, metode masak, resep komposit.
  3. **Diary** (`/diary`) — Riwayat konsumsi harian per waktu makan.
  4. **Profil** (`/profile`) — Profil gizi, target Mifflin-St Jeor, dan pengaturan akun.
- **Preservasi State Tab:** Wajib menggunakan `StatefulShellRoute.indexedStack` di `go_router` agar state setiap tab (seperti draft input kalkulator atau tanggal Food Diary) tidak reset saat berpindah tab.
- **Reservasi Rute & Guard Hook:** Menyediakan konstanta rute untuk `/login`, `/register`, `/profile-setup` serta mekanisme redirect hook yang siap disambungkan ke `AuthBloc` pada Phase 3 (di Phase 1 langsung masuk ke shell utama agar semua 4 tab placeholder bisa diuji langsung).

### 3. Error Handling & Immutability Clean Architecture (`ARCH-01`)
- **Pola Return Repository/UseCase:** Menggunakan **Dart 3 native `sealed class Result<T>`** (`Success<T>` dan `ResultFailure<T>`/`Error<T>` yang membungkus `sealed class Failure` terstruktur) tanpa menambah dependency functional programming eksternal seperti `fpdart`.
- **Immutability Model & BLoC State:** Menggunakan **`equatable`** + `copyWith` manual tanpa `freezed` agar tidak ada overhead code generation di domain & presentation (`build_runner` dikhususkan hanya untuk **Drift** mulai Phase 2).
- **Hierarki `Failure` Dasar:** Menyiapkan tipe dasar di `lib/core/error/failures.dart` (mis. `DatabaseFailure`, `AuthFailure`, `NetworkFailure`, `ValidationFailure`, `UnexpectedFailure`) beserta pesan default Bahasa Indonesia.

### 4. Struktur Direktori, Linting & Cakupan Placeholder (`ARCH-01`, `QUAL-02`)
- **Struktur `lib/core/`:**
  - `lib/core/constants/` — konstanta aplikasi & route paths
  - `lib/core/di/` — `injection_container.dart` berbasis `get_it`
  - `lib/core/error/` — `result.dart`, `failures.dart`, `exceptions.dart`
  - `lib/core/router/` — `app_router.dart` berbasis `go_router`
  - `lib/core/theme/` — `app_colors.dart`, `app_typography.dart`, `app_theme.dart`, `app_spacing.dart`
  - `lib/core/utils/` — helper formatting angka/tanggal Indonesia
  - `lib/core/widgets/` — komponen UI reusable dasar (`PorsiCard`, `PorsiPrimaryButton`, `PorsiTextField`, `PorsiEmptyState`, `PorsiErrorView`, `PorsiLoadingIndicator`)
- **Struktur `lib/features/`:** Kerangka folder Feature-First (`dashboard`, `calculator`, `food_diary`, `profile`, `auth`, `food_catalog`) masing-masing mengikuti pola `{data, domain, presentation}` (halaman placeholder rapi untuk 4 tab utama di Phase 1).
- **Linting (`analysis_options.yaml`):** Memperpanjang `package:flutter_lints/flutter.yaml` dengan aturan strict terpilih:
  - `prefer_const_constructors`
  - `prefer_const_declarations`
  - `prefer_const_literals_to_create_immutables`
  - `always_declare_return_types`
  - `unawaited_futures`
  - `avoid_print`
  - `prefer_single_quotes`
  - `directives_ordering`
- **Verifikasi Package & Diagnostik:** Planner & executor menggunakan `context7` MCP untuk mengecek versi/API terbaru `flutter_bloc`, `equatable`, `go_router`, `get_it`, `google_fonts` serta `dart` MCP / `flutter analyze` untuk memastikan 0 warning.

### Claude's / Agent's Discretion
- Penentuan nilai hex pasti palet Hijau Daun + Aksen Hangat selama memenuhi rasio kontras keterbacaan WCAG AA di Light Mode.
- Pemilihan ikon Material Symbols / `Icons.*_rounded` yang paling harmonis untuk 4 tab navigasi dan halaman placeholder.
- Detail desain internal `Result<T>` helper methods (`fold`/`when`/pattern matching) selama idiomatik Dart 3.
</decisions>

<specifics>
## Specific Ideas

- Pastikan `Plus Jakarta Sans` tetap tampil rapi meski aplikasi digunakan dalam kondisi offline (karena master data TKPI offline-first); pertimbangkan konfigurasi `google_fonts` atau bundling font lokal jika sesuai saat planning.
- Halaman placeholder 4 tab di Phase 1 harus terasa rapi dan menunjukkan preview identitas visual **PorsiPas** (bukan sekadar `Center(child: Text('Tab 1'))`), sehingga sekaligus memverifikasi design system (`AppTheme`, tipografi, kartu, tombol).
</specifics>

<deferred>
## Deferred Ideas

- **Dark Mode:** Ditunda ke v2 agar v1 fokus pada eksekusi Light Mode yang tajam dan konsisten.
- **Freezed Code Generation:** Tidak dipakai di v1; menggunakan `equatable` untuk kesederhanaan build.
- **FAB Tengah Khusus Kalkulator:** Tidak digunakan; Kalkulator menjadi tab ke-2 standar pada 4-tab bottom navigation agar akses cepat dan tata letak konsisten di Android & iOS.
</deferred>

---
*Phase: 01-project-foundation*
*Context gathered: 2026-11-23*
