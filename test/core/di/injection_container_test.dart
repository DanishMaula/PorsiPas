import 'package:flutter_test/flutter_test.dart';
import 'package:porsi_pas/core/di/injection_container.dart';
import 'package:porsi_pas/core/router/app_router.dart';

void main() {
  tearDown(() async {
    await resetDependencies();
  });

  group('DI Container (get_it)', () {
    test('initDependencies is idempotent and registers AppRouter singleton',
        () async {
      await initDependencies();
      await initDependencies();

      expect(sl.isRegistered<AppRouter>(), isTrue);
      final first = sl<AppRouter>();
      final second = sl<AppRouter>();
      expect(identical(first, second), isTrue);

      await resetDependencies();
      expect(sl.isRegistered<AppRouter>(), isFalse);

      await initDependencies();
      expect(sl.isRegistered<AppRouter>(), isTrue);
    });
  });
}
