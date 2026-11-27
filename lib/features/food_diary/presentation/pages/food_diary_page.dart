import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/utils/formatters.dart';
import '../../../../core/widgets/core_widgets.dart';

/// Halaman preview Food Diary harian (aktif penuh pada Phase 6).
class FoodDiaryPage extends StatelessWidget {
  const FoodDiaryPage({super.key});

  static const List<({String title, IconData icon})> _mealSlots =
      <({String title, IconData icon})>[
    (title: 'Sarapan', icon: Icons.wb_sunny_outlined),
    (title: 'Makan Siang', icon: Icons.restaurant_outlined),
    (title: 'Makan Malam', icon: Icons.nights_stay_outlined),
    (title: 'Camilan', icon: Icons.bakery_dining_outlined),
  ];

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final todayLabel = PorsiFormatters.formatIndonesianDate(DateTime.now());

    return Scaffold(
      appBar: AppBar(
        title: const Text('Food Diary'),
      ),
      body: ListView(
        padding: AppSpacing.screenPadding,
        children: <Widget>[
          Text(
            todayLabel,
            style: textTheme.titleMedium?.copyWith(color: AppColors.primary),
          ),
          const SizedBox(height: AppSpacing.md),
          ..._mealSlots.map((slot) {
            return Padding(
              padding: const EdgeInsets.only(bottom: AppSpacing.sm),
              child: PorsiCard(
                child: Row(
                  children: <Widget>[
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: const BoxDecoration(
                        color: AppColors.primaryLight,
                        borderRadius: AppRadius.mdAll,
                      ),
                      child: Icon(slot.icon, color: AppColors.primary),
                    ),
                    const SizedBox(width: AppSpacing.md),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(slot.title, style: textTheme.titleSmall),
                          Text('0 kkal tercatat', style: textTheme.bodySmall),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
          const SizedBox(height: AppSpacing.sm),
          const PorsiEmptyState(
            icon: Icons.menu_book_outlined,
            title: 'Riwayat Konsumsi Harian',
            description:
                'Simpan hasil kalkulator ke slot makan harian melalui Cloud Firestore mulai Phase 6.',
          ),
        ],
      ),
    );
  }
}
