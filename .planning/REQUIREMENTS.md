# Requirements: PorsiPas

**Defined:** 2026-11-20
**Core Value:** Perhitungan kalori & makronutrien masakan rumahan Indonesia yang akurat berbasis TKPI (per 100g BDD), konversi URT, yield & retention factor metode masak, target Mifflin-St Jeor, dan visualisasi "Isi Piringku".

## v1 Requirements

### Architecture & Core Foundation

- [ ] **ARCH-01**: Struktur proyek menggunakan Feature-First Clean Architecture (`lib/core/` dan `lib/features/<feature_name>/{data,domain,presentation}`) dengan dependency injection (`get_it`), routing deklaratif (`go_router`), dan state management (`flutter_bloc` + `equatable`).
- [ ] **ARCH-02**: Tersedia design system dasar (warna, tipografi, komponen input/kartu/loading/error dalam Bahasa Indonesia) yang konsisten di Android & iOS.

### Local Master Data & Versioned Asset Seeder

- [ ] **DATA-01**: Skema database lokal **Drift (SQLite)** menyediakan tabel `foods` (data TKPI per 100g: energi, protein, lemak, karbohidrat, serat, persentase BDD, serta kategori kelompok pangan Isi Piringku: makanan pokok, lauk pauk, sayur, buah, minyak/bumbu), `urt_conversions` (pemetaan satuan URT seperti sendok makan, sendok teh, gelas, potong, butir, mangkok ke gram beserta deskripsi/panduan visual), `cooking_factors` (*yield factor* & *retention factor* per metode masak: Mentah, Rebus, Kukus, Goreng, Panggang), serta pelacak `seed_version`.
- [ ] **DATA-02**: **Asset Seeder** membaca file data lokal (JSON/CSV) dari `assets/data/` saat inisialisasi aplikasi, membandingkan `seed_version`, dan melakukan seeding/re-seeding otomatis ketika `seed_version` dinaikkan tanpa perlu mengubah kode Dart.
- [ ] **DATA-03**: Tersedia **15–20 mock/sample data** bahan pangan rumahan umum Indonesia (nasi putih, dada ayam, telur ayam, tempe, tahu, bayam, wortel, minyak goreng, ikan, buah, dll.) lengkap dengan data TKPI, konversi URT, dan faktor metode masak agar seluruh alur aplikasi dan pengujian berjalan penuh.

### Authentication & Cloud Security

- [ ] **AUTH-01**: Integrasi **Firebase Auth** dan **Cloud Firestore** untuk Android & iOS, lengkap dengan `firestore.rules` yang membatasi akses baca/tulis data pengguna hanya untuk pemilik akun terautentikasi (`request.auth.uid == userId`).
- [ ] **AUTH-02**: Pengguna dapat mendaftar (Register) dan masuk (Login) menggunakan Email & Password dengan validasi input dan pesan error berbahasa Indonesia yang jelas.
- [ ] **AUTH-03**: Pengguna dapat masuk menggunakan **Google Sign-In** yang terintegrasi dengan Firebase Auth.
- [ ] **AUTH-04**: Status sesi autentikasi dipertahankan antar-restart aplikasi; tersedia fitur Logout; `go_router` mengarahkan pengguna yang belum login ke halaman Auth dan pengguna baru tanpa profil gizi ke halaman Setup Profil.

### Profile Setup & Nutrition Target Calculator

- [ ] **PROF-01**: Pengguna dapat mengisi dan memperbarui profil gizi meliputi berat badan (BB, kg), tinggi badan (TB, cm), usia (tahun), jenis kelamin, dan tingkat aktivitas fisik.
- [ ] **PROF-02**: *Domain layer* menghitung target harian **BMR**, **TDEE (kkal)**, target makronutrien (Protein, Lemak, Karbohidrat, Serat dalam gram), dan target air minum menggunakan persamaan **Mifflin-St Jeor** (bukan Harris-Benedict).
- [ ] **PROF-03**: Profil dan target gizi pengguna tersimpan di **Cloud Firestore** dan otomatis memperbarui target pada Dashboard saat profil diubah.

### Portioning & Nutrition Calculator

- [ ] **CALC-01**: Pengguna dapat mencari bahan pangan lokal secara instan dan offline dari database lokal Drift (TKPI per 100g BDD) dengan dukungan filter kategori.
- [ ] **CALC-02**: Pengguna dapat memilih salah satu dari dua metode input takaran: berat aktual timbangan (**gram**) atau konversi standar **URT** (sendok, gelas, potong, butir, dll.) yang disertai panduan visual/referensi takaran.
- [ ] **CALC-03**: Pengguna dapat memilih **metode masak** (**Mentah, Rebus, Kukus, Goreng, Panggang**) yang otomatis menerapkan perhitungan **BDD**, **yield factor**, dan **retention factor** terhadap berat dan nilai gizi akhir.
- [ ] **CALC-04**: Kalkulator mendukung perhitungan **bahan tunggal** maupun **masakan campuran (resep komposit)** dengan menjumlahkan beberapa bahan (masing-masing dengan takaran gram/URT dan metode masak) serta pembagian porsi saji.
- [ ] **CALC-05**: **Kartu Ringkasan Detail Gizi** menampilkan hasil perhitungan **Energi (kkal), Protein (g), Lemak (g), Karbohidrat (g), dan Serat (g)** secara jelas beserta tombol simpan langsung ke Food Diary (memilih tanggal & waktu makan).

### Food Diary (Riwayat Harian)

- [ ] **DIARY-01**: Pengguna dapat menyimpan hasil kalkulasi (bahan tunggal maupun resep komposit) ke **Food Diary** di Cloud Firestore dengan tanggal dan slot waktu makan (**Sarapan, Makan Siang, Makan Malam, Camilan**).
- [ ] **DIARY-02**: Pengguna dapat melihat riwayat log konsumsi harian berdasarkan pemilih tanggal, dikelompokkan per waktu makan, lengkap dengan subtotal per waktu makan, total harian, serta kemampuan melihat detail dan menghapus log.

### Dashboard, "Isi Piringku" & Water Tracker

- [ ] **DASH-01**: Dashboard menampilkan ringkasan progres kalori dan makronutrien harian dibandingkan target Mifflin-St Jeor pengguna.
- [ ] **DASH-02**: Dashboard menampilkan grafik/indikator visual keseimbangan porsi **"Isi Piringku"** (proporsi **50% makanan pokok + lauk pauk** dan **50% sayur + buah**) berdasarkan konsumsi harian yang tercatat.
- [ ] **DASH-03**: Pengguna dapat mencatat dan memantau konsumsi **air minum harian** (tambah/kurangi gelas atau ml per tanggal) yang tersimpan di Cloud Firestore.
- [ ] **DASH-04**: Dashboard menampilkan **umpan balik singkat berbahasa manusiawi** berbasis aturan selisih gizi & Isi Piringku hari itu (contoh: *"Protein kamu kurang sedikit, tambahkan 1 butir telur"*).

### Quality Gates & Verification

- [ ] **QUAL-01**: Tersedia suite **Unit Test khusus di domain layer** yang memverifikasi akurasi 100% untuk persamaan Mifflin-St Jeor, konversi BDD & URT, perhitungan *yield & retention factor* pada kelima metode masak, agregasi resep komposit, serta kalkulasi proporsi Isi Piringku dan generator umpan balik.
- [ ] **QUAL-02**: Proyek lulus `flutter analyze` tanpa warning/error dan seluruh `flutter test` lolos hijau pada setiap akhir fase.

## v2 Requirements (Future Milestones)

- **AI-01**: Pemindai foto makanan berbasis Computer Vision / AI untuk estimasi bahan dan porsi otomatis.
- **PLAN-01**: Fitur premium Meal Plan personal & rekomendasi menu sehat *low-budget*.
- **NOTIF-01**: Pengingat jadwal makan dan minum air harian.
- **MON-01**: Integrasi monetisasi penuh (Google AdMob & In-App Purchase / Subscription).
- **DATA-04**: Perluasan masif database masakan daerah & jajanan kekinian Indonesia.

## Out of Scope

| Feature | Reason |
|---------|--------|
| Persamaan Harris-Benedict | Ditetapkan menggunakan Mifflin-St Jeor untuk konsistensi dan akurasi v1 |
| Computer Vision / AI Food Scanner | Kompleksitas tinggi; v1 berfokus pada akurasi kalkulator TKPI + URT tervalidasi |
| Google AdMob & Subscription Paywall | Fokus v1 adalah validasi fungsi inti & pengalaman pengguna bebas hambatan |
| Dataset masakan daerah/jajanan masif | Menunggu validasi penuh dataset inti TKPI + URT dari tim Gizi & Teknologi Pangan |

## Traceability

| Requirement | Phase | Status |
|-------------|-------|--------|
| ARCH-01 | Phase 1 | Pending |
| ARCH-02 | Phase 1 | Pending |
| DATA-01 | Phase 2 | Pending |
| DATA-02 | Phase 2 | Pending |
| DATA-03 | Phase 2 | Pending |
| AUTH-01 | Phase 3 | Pending |
| AUTH-02 | Phase 3 | Pending |
| AUTH-03 | Phase 3 | Pending |
| AUTH-04 | Phase 3 | Pending |
| PROF-01 | Phase 4 | Pending |
| PROF-02 | Phase 4 | Pending |
| PROF-03 | Phase 4 | Pending |
| CALC-01 | Phase 5 | Pending |
| CALC-02 | Phase 5 | Pending |
| CALC-03 | Phase 5 | Pending |
| CALC-04 | Phase 5 | Pending |
| CALC-05 | Phase 5 | Pending |
| DIARY-01 | Phase 6 | Pending |
| DIARY-02 | Phase 6 | Pending |
| DASH-01 | Phase 7 | Pending |
| DASH-02 | Phase 7 | Pending |
| DASH-03 | Phase 7 | Pending |
| DASH-04 | Phase 7 | Pending |
| QUAL-01 | Phases 4, 5, 7 | Pending |
| QUAL-02 | All Phases (1–7) | Pending |

**Coverage:**
- v1 requirements: 25 total
- Mapped to phases: 25
- Unmapped: 0 ✓

---
*Requirements defined: 2026-11-20*
*Last updated: 2026-11-20 after initial definition*
