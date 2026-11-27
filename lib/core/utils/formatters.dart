import 'package:intl/intl.dart';

import '../constants/app_constants.dart';

/// Helper formatting angka gizi, takaran, dan tanggal dalam format Indonesia (`id_ID`).
abstract final class PorsiFormatters {
  static String formatCalories(double kcal) {
    final formatter = NumberFormat('#,##0', AppConstants.defaultLocale);
    return '${formatter.format(kcal.round())} kkal';
  }

  static String formatMacroGrams(double grams) {
    return '${_formatCompactDecimal(grams)} g';
  }

  static String formatWeightGrams(double grams) {
    return '${_formatCompactDecimal(grams)} g';
  }

  static String formatWaterMl(int ml) {
    final formatter = NumberFormat('#,##0', AppConstants.defaultLocale);
    return '${formatter.format(ml)} ml';
  }

  static String formatIndonesianDate(DateTime date) {
    try {
      return DateFormat('EEEE, d MMM y', AppConstants.defaultLocale)
          .format(date);
    } catch (_) {
      return DateFormat('dd/MM/yyyy').format(date);
    }
  }

  static String _formatCompactDecimal(double value) {
    final rounded = (value * 10).round() / 10;
    final isWhole = (rounded - rounded.truncateToDouble()).abs() < 0.001;
    final pattern = isWhole ? '#,##0' : '#,##0.0';
    return NumberFormat(pattern, AppConstants.defaultLocale).format(rounded);
  }
}
