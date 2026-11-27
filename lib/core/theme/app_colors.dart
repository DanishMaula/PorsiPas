import 'package:flutter/material.dart';

/// Palet warna **Fresh Organik** (Light Mode) dan token semantik gizi PorsiPas.
abstract final class AppColors {
  // Warna merek utama (Hijau Daun + Aksen Hangat)
  static const Color primary = Color(0xFF1E7A46);
  static const Color primaryLight = Color(0xFFE6F4EC);
  static const Color primaryDark = Color(0xFF145A32);

  // Secondary (>= 4.5:1 dengan teks putih) & secondaryAccent untuk ikon/grafik
  static const Color secondary = Color(0xFFC2590B);
  static const Color secondaryAccent = Color(0xFFE07A2F);
  static const Color secondaryLight = Color(0xFFFFF1E6);

  // Permukaan & netral terang
  static const Color background = Color(0xFFF6F8F5);
  static const Color surface = Color(0xFFFFFFFF);
  static const Color surfaceVariant = Color(0xFFEDF2EC);

  // Teks & batas
  static const Color textPrimary = Color(0xFF1A241E);
  static const Color textSecondary = Color(0xFF526358);
  static const Color border = Color(0xFFDCE5DD);

  // Status sistem
  static const Color success = Color(0xFF1E7A46);
  static const Color warning = Color(0xFFB45309);
  static const Color error = Color(0xFFC62828);
  static const Color info = Color(0xFF0277BD);

  // Token semantik makronutrien & hidrasi
  static const Color calories = Color(0xFFD96B27);
  static const Color protein = Color(0xFFC94A4A);
  static const Color fat = Color(0xFFD69E2E);
  static const Color carbs = Color(0xFF2E8B57);
  static const Color fiber = Color(0xFF0F766E);
  static const Color water = Color(0xFF0284C7);

  // Token semantik 4 kelompok pangan "Isi Piringku"
  static const Color isiPiringkuPokok = Color(0xFFD99B26);
  static const Color isiPiringkuLauk = Color(0xFFC94A4A);
  static const Color isiPiringkuSayur = Color(0xFF1E7A46);
  static const Color isiPiringkuBuah = Color(0xFFE07A2F);
}
