/// Exception terstruktur untuk data layer sebelum dipetakan menjadi [Failure].
sealed class AppException implements Exception {
  const AppException({
    required this.message,
    this.code,
    this.cause,
  });

  final String message;
  final String? code;
  final Object? cause;

  @override
  String toString() => '$runtimeType(message: $message, code: $code)';
}

/// Exception untuk kegagalan operasi database lokal (Drift / SQLite).
final class DatabaseException extends AppException {
  const DatabaseException({
    super.message = 'Gagal mengakses database lokal.',
    super.code,
    super.cause,
  });
}

/// Exception untuk kegagalan autentikasi (Firebase Auth / Google Sign-In).
final class AuthException extends AppException {
  const AuthException({
    super.message = 'Gagal memproses autentikasi akun.',
    super.code,
    super.cause,
  });
}

/// Exception untuk kegagalan jaringan atau Cloud Firestore.
final class NetworkException extends AppException {
  const NetworkException({
    super.message = 'Terjadi gangguan jaringan atau sinkronisasi cloud.',
    super.code,
    super.cause,
  });
}

/// Exception untuk kegagalan seeding dataset lokal dari assets.
final class SeedException extends AppException {
  const SeedException({
    super.message = 'Gagal memuat data awal bahan pangan dari aset lokal.',
    super.code,
    super.cause,
  });
}
