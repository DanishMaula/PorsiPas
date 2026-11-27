import 'package:equatable/equatable.dart';

/// Representasi error domain yang aman ditampilkan ke lapisan presentasi.
sealed class Failure extends Equatable {
  const Failure({
    required this.message,
    this.code,
  });

  final String message;
  final String? code;

  @override
  List<Object?> get props => [message, code];
}

/// Kegagalan operasi penyimpanan lokal (Drift / SQLite / Seeder).
final class DatabaseFailure extends Failure {
  const DatabaseFailure({
    super.message = 'Terjadi kesalahan pada database lokal.',
    super.code,
  });
}

/// Kegagalan autentikasi atau otorisasi pengguna.
final class AuthFailure extends Failure {
  const AuthFailure({
    super.message = 'Gagal memproses autentikasi akun.',
    super.code,
  });
}

/// Kegagalan koneksi jaringan atau layanan cloud.
final class NetworkFailure extends Failure {
  const NetworkFailure({
    super.message = 'Koneksi internet bermasalah. Silakan coba lagi.',
    super.code,
  });
}

/// Kegagalan validasi input atau aturan bisnis domain.
final class ValidationFailure extends Failure {
  const ValidationFailure({
    super.message = 'Data yang dimasukkan belum valid.',
    super.code,
  });
}

/// Kegagalan umum yang tidak terklasifikasi.
final class UnexpectedFailure extends Failure {
  const UnexpectedFailure({
    super.message = 'Terjadi kesalahan tak terduga. Silakan coba lagi.',
    super.code,
  });
}
