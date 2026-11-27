import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/core_widgets.dart';

/// Halaman preview Kalkulator Porsi & Gizi (aktif penuh pada Phase 2 & 5).
class CalculatorPage extends StatefulWidget {
  const CalculatorPage({super.key});

  @override
  State<CalculatorPage> createState() => _CalculatorPageState();
}

class _CalculatorPageState extends State<CalculatorPage> {
  static const List<String> _inputModes = <String>[
    'Timbangan (g)',
    'Takaran URT',
  ];

  static const List<String> _cookingMethods = <String>[
    'Mentah',
    'Rebus',
    'Kukus',
    'Goreng',
    'Panggang',
  ];

  String _selectedInputMode = _inputModes.first;
  String _selectedCookingMethod = _cookingMethods.first;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Kalkulator Porsi & Gizi'),
      ),
      body: ListView(
        padding: AppSpacing.screenPadding,
        children: <Widget>[
          const PorsiTextField(
            label: 'Cari Bahan Pangan TKPI',
            hintText: 'Contoh: Nasi putih, dada ayam, tempe...',
            prefixIcon: Icon(Icons.search_rounded),
            readOnly: true,
          ),
          const SizedBox(height: AppSpacing.md),
          PorsiCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text('Metode Input Takaran', style: textTheme.titleSmall),
                const SizedBox(height: AppSpacing.sm),
                Wrap(
                  spacing: AppSpacing.sm,
                  runSpacing: AppSpacing.sm,
                  children: _inputModes.map((mode) {
                    return ChoiceChip(
                      label: Text(mode),
                      selected: _selectedInputMode == mode,
                      onSelected: (_) {
                        setState(() => _selectedInputMode = mode);
                      },
                    );
                  }).toList(),
                ),
                const SizedBox(height: AppSpacing.md),
                Text('Metode Memasak', style: textTheme.titleSmall),
                const SizedBox(height: AppSpacing.xs),
                Text(
                  'Memperhitungkan yield & retention factor (Phase 5).',
                  style: textTheme.bodySmall,
                ),
                const SizedBox(height: AppSpacing.sm),
                Wrap(
                  spacing: AppSpacing.sm,
                  runSpacing: AppSpacing.sm,
                  children: _cookingMethods.map((method) {
                    return ChoiceChip(
                      label: Text(method),
                      selected: _selectedCookingMethod == method,
                      onSelected: (_) {
                        setState(() => _selectedCookingMethod = method);
                      },
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          const PorsiCard(
            backgroundColor: AppColors.surfaceVariant,
            child: PorsiEmptyState(
              icon: Icons.calculate_outlined,
              title: 'Dataset TKPI & URT Siap Dihubungkan',
              description:
                  'Database offline Drift (15–20 sampel pangan) dan mesin kalkulasi BDD/URT/komposit akan aktif pada Phase 2 & Phase 5.',
            ),
          ),
        ],
      ),
    );
  }
}
