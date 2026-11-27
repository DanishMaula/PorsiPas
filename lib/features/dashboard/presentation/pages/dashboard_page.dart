import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/utils/formatters.dart';
import '../../../../core/widgets/core_widgets.dart';

/// Halaman preview Beranda / Dashboard (akan dilengkapi pada Phase 7).
class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final formattedDate = PorsiFormatters.formatIndonesianDate(DateTime.now());

    return Scaffold(
      appBar: AppBar(
        title: const Text('Beranda PorsiPas'),
      ),
      body: ListView(
        padding: AppSpacing.screenPadding,
        children: <Widget>[
          Text(
            'Halo, Sahabat PorsiPas',
            style: textTheme.headlineMedium,
          ),
          const SizedBox(height: AppSpacing.xs),
          Text(
            formattedDate,
            style: textTheme.bodyMedium?.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          PorsiCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: const BoxDecoration(
                        color: AppColors.primaryLight,
                        borderRadius: AppRadius.mdAll,
                      ),
                      child: const Icon(
                        Icons.local_fire_department_rounded,
                        color: AppColors.calories,
                      ),
                    ),
                    const SizedBox(width: AppSpacing.md),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'Target Energi Harian',
                            style: textTheme.titleMedium,
                          ),
                          Text(
                            'Berdasarkan rumus Mifflin-St Jeor (Phase 4)',
                            style: textTheme.bodySmall,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: AppSpacing.md),
                const Wrap(
                  spacing: AppSpacing.sm,
                  runSpacing: AppSpacing.sm,
                  children: <Widget>[
                    _MacroBadge(label: 'Energi', color: AppColors.calories),
                    _MacroBadge(label: 'Protein', color: AppColors.protein),
                    _MacroBadge(label: 'Lemak', color: AppColors.fat),
                    _MacroBadge(label: 'Karbohidrat', color: AppColors.carbs),
                    _MacroBadge(label: 'Serat', color: AppColors.fiber),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          PorsiCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text('Panduan Isi Piringku (50 / 50)', style: textTheme.titleMedium),
                const SizedBox(height: AppSpacing.xs),
                Text(
                  'Keseimbangan 50% makanan pokok & lauk pauk serta 50% sayur & buah.',
                  style: textTheme.bodySmall,
                ),
                const SizedBox(height: AppSpacing.md),
                const Wrap(
                  spacing: AppSpacing.sm,
                  runSpacing: AppSpacing.sm,
                  children: <Widget>[
                    _MacroBadge(
                      label: 'Makanan Pokok',
                      color: AppColors.isiPiringkuPokok,
                    ),
                    _MacroBadge(
                      label: 'Lauk Pauk',
                      color: AppColors.isiPiringkuLauk,
                    ),
                    _MacroBadge(
                      label: 'Sayur',
                      color: AppColors.isiPiringkuSayur,
                    ),
                    _MacroBadge(
                      label: 'Buah',
                      color: AppColors.isiPiringkuBuah,
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          PorsiCard(
            child: Row(
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: AppColors.water.withValues(alpha: 0.12),
                    borderRadius: AppRadius.mdAll,
                  ),
                  child: const Icon(
                    Icons.water_drop_rounded,
                    color: AppColors.water,
                  ),
                ),
                const SizedBox(width: AppSpacing.md),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text('Pelacak Air Minum', style: textTheme.titleMedium),
                      Text(
                        'Target standar ${2000} ml / hari siap aktif di Phase 7.',
                        style: textTheme.bodySmall,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _MacroBadge extends StatelessWidget {
  const _MacroBadge({
    required this.label,
    required this.color,
  });

  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: AppRadius.pillAll,
        border: Border.all(color: color.withValues(alpha: 0.3)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
            width: 8,
            height: 8,
            decoration: BoxDecoration(color: color, shape: BoxShape.circle),
          ),
          const SizedBox(width: 6),
          Text(
            label,
            style: Theme.of(context).textTheme.labelMedium?.copyWith(
                  color: AppColors.textPrimary,
                ),
          ),
        ],
      ),
    );
  }
}
