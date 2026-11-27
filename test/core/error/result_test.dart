import 'package:flutter_test/flutter_test.dart';
import 'package:porsi_pas/core/error/failures.dart';
import 'package:porsi_pas/core/error/result.dart';

void main() {
  group('Result<T>', () {
    test('Success exposes data, folds onSuccess, and maps value', () {
      const Result<int> result = Success<int>(42);

      expect(result.isSuccess, isTrue);
      expect(result.isFailure, isFalse);
      expect(result.dataOrNull, 42);
      expect(result.failureOrNull, isNull);

      final folded = result.fold(
        onSuccess: (data) => 'Nilai: $data',
        onFailure: (failure) => failure.message,
      );
      expect(folded, 'Nilai: 42');

      final mapped = result.map((data) => data * 2);
      expect(mapped, const Success<int>(84));
    });

    test('ResultFailure exposes failure, folds onFailure, and skips map', () {
      const failure = ValidationFailure(
        message: 'Berat bahan harus lebih dari 0 gram.',
        code: 'INVALID_WEIGHT',
      );
      const Result<int> result = ResultFailure<int>(failure);
      var transformCalled = false;

      expect(result.isSuccess, isFalse);
      expect(result.isFailure, isTrue);
      expect(result.dataOrNull, isNull);
      expect(result.failureOrNull, failure);

      final folded = result.fold(
        onSuccess: (data) => 'Nilai: $data',
        onFailure: (f) => '${f.code}:${f.message}',
      );
      expect(folded, 'INVALID_WEIGHT:Berat bahan harus lebih dari 0 gram.');

      final mapped = result.map((data) {
        transformCalled = true;
        return data.toString();
      });
      expect(transformCalled, isFalse);
      expect(mapped, const ResultFailure<String>(failure));
    });

    test('supports exhaustive Dart 3 switch pattern matching', () {
      const Result<String> result = Success<String>('Tempe Goreng');

      final label = switch (result) {
        Success<String>(:final data) => data,
        ResultFailure<String>(:final failure) => failure.message,
      };

      expect(label, 'Tempe Goreng');
    });
  });

  group('Failure hierarchy', () {
    test('all Failure subclasses provide Indonesian default messages', () {
      const failures = <Failure>[
        DatabaseFailure(),
        AuthFailure(),
        NetworkFailure(),
        ValidationFailure(),
        UnexpectedFailure(),
      ];

      for (final failure in failures) {
        expect(failure.message.trim(), isNotEmpty);
      }

      expect(
        const DatabaseFailure(message: 'Gagal', code: 'DB_01'),
        const DatabaseFailure(message: 'Gagal', code: 'DB_01'),
      );
      expect(
        const AuthFailure(message: 'A'),
        isNot(const AuthFailure(message: 'B')),
      );
    });
  });
}
