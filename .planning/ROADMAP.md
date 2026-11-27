# Roadmap: PorsiPas (v1.0 MVP)

## Overview

Roadmap ini membangun **PorsiPas** secara bertahap dari fondasi arsitektur Flutter (Feature-First Clean Architecture), database master lokal offline berbasis **Drift** dengan **Versioned Asset Seeder**, autentikasi & backend cloud **Firebase**, mesin kalkulator target **Mifflin-St Jeor**, kalkulator penakaran & gizi **TKPI + URT + metode masak**, **Food Diary**, hingga **Dashboard "Isi Piringku"** lengkap dengan **Water Tracker** dan umpan balik gizi berbahasa manusiawi.

Setiap fase bersifat terverifikasi mandiri dan wajib memenuhi *quality gate* (`flutter analyze` tanpa warning dan unit test domain lulus 100%).

## Phases

- [x] **Phase 1: Project Foundation, Clean Architecture & Design System** — Struktur Feature-First Clean Architecture, DI (`get_it`), routing (`go_router`), BLoC/Equatable, tema UI, dan baseline quality gate. (Completed 2026-11-27)
- [ ] **Phase 2: Local Master Data (Drift SQLite) & Versioned Asset Seeder** — Skema `foods`, `urt_conversions`, `cooking_factors`, mekanisme `seed_version` dari `assets/data/`, dan 15–20 sample bahan pangan Indonesia.
- [ ] **Phase 3: Firebase Integration, Authentication & Firestore Rules** — Konfigurasi Firebase (Android/iOS), Login/Register Email & Google Sign-In, `firestore.rules`, dan auth route guard.
- [ ] **Phase 4: Profile Setup & Mifflin-St Jeor Nutrition Target Engine** — Domain calculator Mifflin-St Jeor (BMR, TDEE, makro, air) dengan unit test 100%, form profil, dan sinkronisasi Firestore.
- [ ] **Phase 5: Portioning & Nutrition Calculator (TKPI, URT, Cooking Factors & Composite)** — Mesin kalkulasi BDD, URT, 5 metode masak (yield/retention), resep komposit + unit test 100%, UI pencarian offline, panduan URT, dan Kartu Ringkasan Detail Gizi.
- [ ] **Phase 6: Food Diary & Daily History** — Pencatatan log ke Firestore per tanggal & waktu makan (Sarapan, Makan Siang, Makan Malam, Camilan) serta tampilan riwayat & pengelolaan log.
- [ ] **Phase 7: Dashboard, "Isi Piringku", Water Tracker & Human Feedback** — Ringkasan progres harian, visualisasi 50/50 "Isi Piringku", Water Tracker, engine umpan balik gizi berbahasa manusiawi, dan verifikasi akhir v1.0.

## Phase Details

### Phase 1: Project Foundation, Clean Architecture & Design System
**Goal:** Menyediakan fondasi proyek Flutter yang rapi, terstruktur, dan siap dikembangkan lintas fitur dengan standar kualitas ketat.
**Depends on:** Nothing (first phase)
**Requirements:** `ARCH-01`, `ARCH-02`, `QUAL-02`
**Success Criteria** (what must be TRUE):
1. Struktur direktori `lib/core/` dan kerangka `lib/features/` sesuai Feature-First Clean Architecture (`data`, `domain`, `presentation`).
2. Dependency `flutter_bloc`, `equatable`, `go_router`, `get_it`, dan package pendukung terpasang (diverifikasi via `context7` MCP untuk versi & API terbaru) serta container DI dan router shell berjalan.
3. Tema Material 3 PorsiPas, komponen UI dasar, dan shell navigasi (bottom nav placeholder) tampil bersih saat app dijalankan.
4. `flutter analyze` menghasilkan 0 warning/error dan smoke test dasar lulus.
**Plans:** 3 plans (`01-01-PLAN.md`, `01-02-PLAN.md`, `01-03-PLAN.md`)

### Phase 2: Local Master Data (Drift SQLite) & Versioned Asset Seeder
**Goal:** Membangun penyimpanan lokal offline-first untuk data master TKPI, URT, dan metode masak dengan mekanisme `seed_version` yang siap menerima dataset final tim Gizi tanpa perubahan kode.
**Depends on:** Phase 1
**Requirements:** `DATA-01`, `DATA-02`, `DATA-03`, `QUAL-02`
**Success Criteria** (what must be TRUE):
1. Tabel Drift (`foods`, `urt_conversions`, `cooking_factors`, `seed_metadata`) terdefinisi lengkap beserta relasi dan DAO/repository query.
2. File data `assets/data/` memuat 15–20 mock bahan pangan rumahan umum Indonesia (nasi, dada ayam, telur, tempe, tahu, bayam, wortel, minyak goreng, dll.) lengkap dengan TKPI per 100g, persentase BDD, kategori Isi Piringku, URT, dan faktor 5 metode masak.
3. Asset Seeder otomatis mengisi database saat pertama kali dijalankan dan melakukan re-seed bersih saat `seed_version` dinaikkan tanpa duplikasi data.
4. Unit test memverifikasi initial seeding, idempotensi pada restart dengan versi sama, dan re-seeding saat `seed_version` naik; `flutter analyze` 0 warning.
**Plans:** TBD

### Phase 3: Firebase Integration, Authentication & Firestore Rules
**Goal:** Menghubungkan aplikasi ke Firebase dengan autentikasi Email/Password & Google Sign-In serta aturan keamanan Cloud Firestore yang ketat.
**Depends on:** Phase 1
**Requirements:** `AUTH-01`, `AUTH-02`, `AUTH-03`, `AUTH-04`, `QUAL-02`
**Success Criteria** (what must be TRUE):
1. Konfigurasi Firebase (Android & iOS) aktif dan `firestore.rules` membatasi akses dokumen `users/{uid}/**` hanya kepada `uid` terautentikasi (diauthor lewat `firestore-rules-author`).
2. Pengguna dapat Register & Login menggunakan Email/Password serta Google Sign-In dengan penanganan error berbahasa Indonesia.
3. Sesi login bertahan setelah restart, tombol Logout bekerja bersih, dan `go_router` mengarahkan alur Unauthenticated → Auth, Authenticated tanpa profil → Profile Setup, Authenticated dengan profil → Dashboard.
4. Unit test Auth BLoC/usecase dan `flutter analyze` lulus tanpa warning.
**Plans:** TBD

### Phase 4: Profile Setup & Mifflin-St Jeor Nutrition Target Engine
**Goal:** Memungkinkan pengguna menghitung dan menyimpan target kebutuhan gizi harian menggunakan persamaan Mifflin-St Jeor dengan akurasi domain 100%.
**Depends on:** Phase 3
**Requirements:** `PROF-01`, `PROF-02`, `PROF-03`, `QUAL-01`, `QUAL-02`
**Success Criteria** (what must be TRUE):
1. Usecase domain Mifflin-St Jeor menghitung BMR (pria/wanita), TDEE berdasarkan faktor aktivitas, target Protein/Lemak/Karbohidrat/Serat, dan target air harian secara akurat.
2. Unit test domain memverifikasi akurasi 100% terhadap contoh kasus perhitungan manual lintas usia, jenis kelamin, BB/TB, dan level aktivitas.
3. Pengguna dapat mengisi form onboarding profil dan mengubah profil kapan saja; data tersimpan & sinkron dengan Cloud Firestore (`users/{uid}`).
4. `flutter analyze` 0 warning dan seluruh test lulus.
**Plans:** TBD

### Phase 5: Portioning & Nutrition Calculator (TKPI, URT, Cooking Factors & Composite)
**Goal:** Menyediakan fitur inti penakaran dan perhitungan gizi otomatis (bahan tunggal & resep komposit) yang akurat berbasis TKPI 100g BDD, URT, dan yield/retention factor metode masak.
**Depends on:** Phase 2, Phase 4
**Requirements:** `CALC-01`, `CALC-02`, `CALC-03`, `CALC-04`, `CALC-05`, `QUAL-01`, `QUAL-02`
**Success Criteria** (what must be TRUE):
1. Pencarian bahan pangan di Drift berjalan instan secara offline dengan filter kategori.
2. Pengguna dapat menginput berat gram aktual maupun memilih satuan URT (dengan panduan visual/deskripsi takaran) serta memilih metode masak (**Mentah, Rebus, Kukus, Goreng, Panggang**).
3. Mesin kalkulasi domain menghitung BDD, konversi URT → gram, *yield factor*, *retention factor*, serta penjumlahan **resep komposit** (multi-bahan & pembagian porsi) dengan akurasi 100% tervalidasi unit test.
4. **Kartu Ringkasan Detail Gizi** menampilkan Energi (kkal), Protein (g), Lemak (g), Karbohidrat (g), dan Serat (g) serta aksi siap simpan ke Food Diary.
5. `flutter analyze` 0 warning dan seluruh test lulus.
**Plans:** TBD

### Phase 6: Food Diary & Daily History
**Goal:** Menyediakan pencatatan dan riwayat konsumsi harian yang terstruktur per tanggal dan waktu makan di Cloud Firestore.
**Depends on:** Phase 3, Phase 5
**Requirements:** `DIARY-01`, `DIARY-02`, `QUAL-02`
**Success Criteria** (what must be TRUE):
1. Dari Kartu Ringkasan Detail Gizi, pengguna dapat menyimpan log bahan tunggal maupun masakan campuran ke slot **Sarapan, Makan Siang, Makan Malam, atau Camilan** pada tanggal yang dipilih.
2. Halaman Food Diary mendukung navigasi tanggal, mengelompokkan catatan per waktu makan, menampilkan subtotal per slot & total gizi harian, serta mendukung lihat detail dan hapus item.
3. Data tersimpan rapi di Cloud Firestore (`users/{uid}/food_logs`) dan terefleksi langsung pada state aplikasi.
4. Unit test repository/BLoC & `flutter analyze` lulus tanpa warning.
**Plans:** TBD

### Phase 7: Dashboard, "Isi Piringku", Water Tracker & Human Feedback
**Goal:** Menghadirkan pusat pemantauan gizi harian yang informatif, visual, dan berbahasa manusiawi, sekaligus menutup verifikasi menyeluruh v1.0 MVP.
**Depends on:** Phase 4, Phase 6
**Requirements:** `DASH-01`, `DASH-02`, `DASH-03`, `DASH-04`, `QUAL-01`, `QUAL-02`
**Success Criteria** (what must be TRUE):
1. Dashboard menampilkan progres kalori & makronutrien harian dibandingkan target Mifflin-St Jeor pengguna secara real-time dari Food Diary.
2. Visualisasi **"Isi Piringku"** menampilkan keseimbangan proporsi 50% makanan pokok + lauk pauk dan 50% sayur + buah secara intuitif.
3. **Water Tracker** memungkinkan tambah/kurangi asupan air harian dan menyimpannya per tanggal di Cloud Firestore.
4. Engine umpan balik gizi menghasilkan saran singkat berbahasa Indonesia yang manusiawi dan kontekstual sesuai defisit/kelebihan gizi hari itu, teruji lewat unit test domain.
5. Seluruh suite unit test (termasuk 100% domain nutrition formulas) lulus dan `flutter analyze` melaporkan 0 warning/error.
**Plans:** TBD

## Progress

| Phase | Plans Complete | Status | Completed |
|-------|----------------|--------|-----------|
| 1. Project Foundation, Clean Architecture & Design System | 3/3 | Complete | 2026-11-27 |
| 2. Local Master Data (Drift SQLite) & Versioned Asset Seeder | 0/TBD | Not started | - |
| 3. Firebase Integration, Authentication & Firestore Rules | 0/TBD | Not started | - |
| 4. Profile Setup & Mifflin-St Jeor Nutrition Target Engine | 0/TBD | Not started | - |
| 5. Portioning & Nutrition Calculator | 0/TBD | Not started | - |
| 6. Food Diary & Daily History | 0/TBD | Not started | - |
| 7. Dashboard, "Isi Piringku", Water Tracker & Human Feedback | 0/TBD | Not started | - |

---
*Roadmap created: 2026-11-20*
