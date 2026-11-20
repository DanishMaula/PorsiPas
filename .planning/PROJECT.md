# PorsiPas

## What This Is

**PorsiPas** adalah aplikasi mobile pendamping penakaran bahan pangan dan perhitungan gizi masakan rumahan berbasis **Flutter** (Android & iOS). Aplikasi ini membantu pengguna di Indonesia menghitung kalori dan makronutrien dari masakan rumahan secara akurat menggunakan standar **TKPI (Tabel Komposisi Pangan Indonesia per 100g BDD)**, konversi **URT (Ukuran Rumah Tangga)** ke gram, serta perhitungan **yield & retention factor** berdasarkan metode memasak.

## Core Value

Memberikan perhitungan gizi masakan rumahan Indonesia yang akurat, cepat (offline-first untuk master data), dan mudah dipahami sehari-hari—menjembatani konversi takaran rumah tangga (URT), perubahan berat/gizi akibat memasak, target kebutuhan individu (**Mifflin-St Jeor**), serta panduan porsi seimbang **"Isi Piringku"**.

## Target Audience

- **Pelajar / Mahasiswa (15–22 tahun):** Mulai belajar mengatur pola makan sehat dan mandiri.
- **Pekerja / Karyawan (22–35 tahun):** Membutuhkan pencatatan gizi masakan rumahan yang cepat dan praktis.
- **Ibu Rumah Tangga (>35 tahun):** Memasak harian untuk keluarga dan membutuhkan konversi takaran URT serta pemantauan gizi seimbang.

## Architecture & Technical Stack

- **Platform:** Flutter (Android & iOS), Dart SDK `^3.12.0`.
- **Architecture:** Feature-First Clean Architecture (`lib/core/` dan `lib/features/<feature_name>/{data,domain,presentation}`).
- **State Management:** `flutter_bloc` (BLoC & Cubit) + `equatable`.
- **Routing & DI:** `go_router` dan `get_it`.
- **Hybrid Storage (Local-First + Cloud):**
  - **Local Master Data (Drift / SQLite):** Tabel `foods`, `urt_conversions`, `cooking_factors`, dan metadata versi seed (`seed_metadata`). Di-prepopulate dari file JSON/CSV lokal di `assets/data/` agar pencarian instan dan berfungsi penuh secara offline.
  - **Cloud User Data (Firebase):** **Firebase Auth** (Email/Password & Google Sign-In) dan **Cloud Firestore** (Profil Gizi, Food Diary, Water Tracker) yang dilindungi `firestore.rules`.
- **Tooling & MCP:**
  - `context7` MCP untuk memastikan penggunaan API package terbaru.
  - `dart` MCP untuk diagnostik dan analisis kode.
  - `firebase` MCP untuk konfigurasi Firebase & deployment rules.

## Master Data Strategy (`seed_version`)

Dataset final TKPI, konversi URT, dan *yield/retention factor* sedang disusun oleh tim Gizi & Teknologi Pangan. Oleh karena itu:
1. Aplikasi menyediakan skema Drift final (`foods`, `urt_conversions`, `cooking_factors`) bersama **Asset Seeder** yang membaca `assets/data/`.
2. Tersedia **15–20 mock/sample data** bahan pangan rumahan umum Indonesia (nasi, dada ayam, telur ayam, tempe, tahu, bayam, wortel, minyak goreng, dll.) untuk pengembangan dan pengujian penuh.
3. Mekanisme seeding dilengkapi **`seed_version`** agar saat dataset final siap, cukup menimpa file di `assets/data/` dan menaikkan `seed_version` tanpa mengubah struktur kode aplikasi.

## Requirements Overview

### Validated (Existing Codebase)
- [x] Inisialisasi proyek Flutter dasar (`porsi_pas`, SDK `^3.12.0`, `flutter_lints ^6.0.0`, target Android & iOS).

### Active (v1.0 MVP)
- [ ] Arsitektur Feature-First Clean Architecture (`flutter_bloc`, `equatable`, `go_router`, `get_it`) & tema UI.
- [ ] Database lokal Drift (`foods`, `urt_conversions`, `cooking_factors`) + Versioned Asset Seeder (`seed_version`) dengan 15–20 sample data pangan Indonesia.
- [ ] Autentikasi Firebase (Email/Password & Google Sign-In) + Firestore Security Rules.
- [ ] Setup Profil & Kalkulator Target Gizi berbasis **Mifflin-St Jeor** (BMR, TDEE, makronutrien, air).
- [ ] Kalkulator Penakaran & Gizi Otomatis (TKPI 100g BDD, input gram & URT + panduan visual, 5 metode masak dengan yield & retention factor, bahan tunggal & resep komposit).
- [ ] Kartu Ringkasan Detail Gizi (Energi, Protein, Lemak, Karbohidrat, Serat) + simpan ke Food Diary.
- [ ] Food Diary (riwayat harian berdasarkan tanggal: Sarapan, Makan Siang, Makan Malam, Camilan).
- [ ] Dashboard, Visualisasi **"Isi Piringku"** (50% pokok-lauk, 50% sayur-buah), Water Tracker, dan umpan balik gizi berbahasa manusiawi.
- [ ] Quality Gate: `flutter analyze` nol warning & Unit Test domain 100% untuk seluruh rumus gizi.

### Out of Scope (v2+ / Future Milestones)
- Pemindai foto makanan berbasis Computer Vision / AI — ditunda ke milestone berikutnya agar v1 fokus pada akurasi perhitungan manual/URT tervalidasi.
- Fitur premium Meal Plan personal, rekomendasi menu sehat *low-budget*, dan pengingat jadwal makan.
- Monetisasi penuh (Google AdMob & In-App Purchase / Subscription).
- Perluasan masif database masakan daerah & jajanan kekinian (v1 fokus pada dataset inti TKPI + URT).

## Constraints & Quality Gates

- **Formula Wajib:** Target BMR/TDEE wajib menggunakan **Mifflin-St Jeor** (bukan Harris-Benedict).
- **Akurasi Domain:** Unit test khusus di *domain layer* wajib menjamin akurasi 100% pada rumus Mifflin-St Jeor, konversi BDD/URT, *yield & retention factor*, dan resep komposit.
- **Static Analysis:** Wajib lulus `flutter analyze` tanpa warning maupun error di setiap fase.
- **Mode Eksekusi:** Interaktif — setiap fase dan plan harus mendapat persetujuan pengguna sebelum eksekusi.

## Key Decisions

| Decision | Rationale | Outcome |
|----------|-----------|---------|
| Hybrid Local-First (Drift) + Cloud (Firebase) | Master data TKPI/URT butuh pencarian instan & offline; data user butuh sinkronisasi lintas sesi | Locked |
| Persamaan Mifflin-St Jeor (bukan Harris-Benedict) | Lebih akurat untuk populasi modern sesuai standar gizi yang dipilih | Locked |
| Feature-First Clean Architecture + `flutter_bloc` + `go_router` + `get_it` | Memisahkan domain formula murni agar mudah di-unit-test 100% terisolasi dari UI & DB | Locked |
| Versioned Asset Seeder (`seed_version`) + 15–20 mock data | Memungkinkan pengembangan penuh paralel dengan penyusunan dataset final tim Gizi | Locked |
| Skip `.planning/research/` terpisah | Riset domain & formula gizi sudah diselesaikan sebelum inisialisasi | Locked |

---
*Last updated: 2026-11-20 after project initialization*
