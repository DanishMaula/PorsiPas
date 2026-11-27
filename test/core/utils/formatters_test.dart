import 'package:flutter_test/flutter_test.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:porsi_pas/core/constants/app_constants.dart';
import 'package:porsi_pas/core/utils/formatters.dart';

void main() {
  setUpAll(() async {
    await initializeDateFormatting(AppConstants.defaultLocale);
  });

  group('PorsiFormatters', () {
    test('formats calories with Indonesian thousand separator', () {
      expect(PorsiFormatters.formatCalories(0), '0 kkal');
      expect(PorsiFormatters.formatCalories(1850.4), '1.850 kkal');
      expect(PorsiFormatters.formatCalories(1850.6), '1.851 kkal');
    });

    test('formats macro and weight grams compactly in Indonesian format', () {
      expect(PorsiFormatters.formatMacroGrams(100), '100 g');
      expect(PorsiFormatters.formatMacroGrams(12.5), '12,5 g');
      expect(PorsiFormatters.formatMacroGrams(12.04), '12 g');
      expect(PorsiFormatters.formatWeightGrams(1500), '1.500 g');
      expect(PorsiFormatters.formatWeightGrams(7.25), '7,3 g');
    });

    test('formats water volume in ml', () {
      expect(PorsiFormatters.formatWaterMl(250), '250 ml');
      expect(PorsiFormatters.formatWaterMl(2000), '2.000 ml');
    });

    test('formats Indonesian date cleanly', () {
      final date = DateTime(2026, 11, 23);
      expect(
        PorsiFormatters.formatIndonesianDate(date),
        'Senin, 23 Nov 2026',
      );
    });
  });
}
