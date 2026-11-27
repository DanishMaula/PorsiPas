import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/core_widgets.dart';

/// Halaman preview Profil & Target Gizi (aktif penuh pada Phase 3 & 4).
class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Profil & Target Gizi'),
      ),
      body: ListView(
        padding: AppSpacing.screenPadding,
        children: <Widget>[
          PorsiCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    const CircleAvatar(
                      radius: 26,
                      backgroundColor: AppColors.primaryLight,
                      child: Icon(
                        Icons.person_rounded,
                        color: AppColors.primary,
                        size: 28,
                      ),
                    ),
                    const SizedBox(width: AppSpacing.md),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'Akun Belum Terhubung',
                            style: textTheme.titleMedium,
                          ),
                          Text(
                            'Autentikasi Email & Google Sign-In aktif di Phase 3.',
                            style: textTheme.bodySmall,
                          ),
                        ],
                      ),
                    ),
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
                Text(
                  'Kalkulator Target Mifflin-St Jeor',
                  style: textTheme.titleMedium,
                ),
                const SizedBox(height: AppSpacing.xs),
                Text(
                  'Menghitung BMR, TDEE (kkal), makronutrien, dan kebutuhan air harian berdasarkan berat badan, tinggi badan, usia, jenis kelamin, serta aktivitas fisik pada Phase 4.',
                  style: textTheme.bodySmall,
                ),
                const SizedBox(height: AppSpacing.md),
                const PorsiPrimaryButton(
                  label: 'Atur Profil Gizi (Phase 4)',
                  icon: Icons.tune_rounded,
                  onPressed: null,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
