import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:porsi_pas/core/theme/app_colors.dart';
import 'package:porsi_pas/core/theme/app_theme.dart';
import 'package:porsi_pas/core/widgets/core_widgets.dart';

Widget _wrapWithTheme(Widget child) {
  return MaterialApp(
    theme: AppTheme.light(useGoogleFonts: false),
    home: Scaffold(body: child),
  );
}

void main() {
  setUpAll(() {
    GoogleFonts.config.allowRuntimeFetching = false;
  });

  group('AppTheme & Core Widgets', () {
    test('AppTheme.light configures Fresh Organik Light palette', () {
      final theme = AppTheme.light(useGoogleFonts: false);

      expect(theme.useMaterial3, isTrue);
      expect(theme.brightness, Brightness.light);
      expect(theme.colorScheme.primary, AppColors.primary);
      expect(theme.colorScheme.secondary, AppColors.secondary);
      expect(theme.scaffoldBackgroundColor, AppColors.background);
    });

    testWidgets('PorsiCard renders child and handles tap', (tester) async {
      var tapped = false;
      await tester.pumpWidget(
        _wrapWithTheme(
          PorsiCard(
            onTap: () => tapped = true,
            child: const Text('Nasi Putih 100 g'),
          ),
        ),
      );

      expect(find.text('Nasi Putih 100 g'), findsOneWidget);
      await tester.tap(find.text('Nasi Putih 100 g'));
      expect(tapped, isTrue);
    });

    testWidgets('PorsiPrimaryButton triggers tap and blocks when loading',
        (tester) async {
      var pressed = 0;

      await tester.pumpWidget(
        _wrapWithTheme(
          PorsiPrimaryButton(
            label: 'Simpan ke Diary',
            onPressed: () => pressed++,
          ),
        ),
      );

      await tester.tap(find.text('Simpan ke Diary'));
      expect(pressed, 1);

      await tester.pumpWidget(
        _wrapWithTheme(
          PorsiPrimaryButton(
            label: 'Simpan ke Diary',
            isLoading: true,
            onPressed: () => pressed++,
          ),
        ),
      );

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
      await tester.tap(find.byType(FilledButton));
      expect(pressed, 1);
    });

    testWidgets('PorsiTextField displays label, accepts text, and validates',
        (tester) async {
      final formKey = GlobalKey<FormState>();
      final controller = TextEditingController();
      addTearDown(controller.dispose);

      await tester.pumpWidget(
        _wrapWithTheme(
          Form(
            key: formKey,
            child: PorsiTextField(
              label: 'Berat Bahan (gram)',
              hintText: 'Contoh: 150',
              controller: controller,
              validator: (v) =>
                  (v == null || v.isEmpty) ? 'Wajib diisi' : null,
            ),
          ),
        ),
      );

      expect(find.text('Berat Bahan (gram)'), findsOneWidget);
      expect(formKey.currentState!.validate(), isFalse);
      await tester.pump();
      expect(find.text('Wajib diisi'), findsOneWidget);

      await tester.enterText(find.byType(TextFormField), '150');
      expect(controller.text, '150');
      expect(formKey.currentState!.validate(), isTrue);
    });

    testWidgets('PorsiEmptyState renders content and invokes CTA',
        (tester) async {
      var clicked = false;
      await tester.pumpWidget(
        _wrapWithTheme(
          PorsiEmptyState(
            icon: Icons.rice_bowl_outlined,
            title: 'Belum ada catatan makan',
            description: 'Catat makanan pertamamu hari ini.',
            actionLabel: 'Buka Kalkulator',
            onAction: () => clicked = true,
          ),
        ),
      );

      expect(find.text('Belum ada catatan makan'), findsOneWidget);
      await tester.tap(find.text('Buka Kalkulator'));
      expect(clicked, isTrue);
    });

    testWidgets('PorsiErrorView displays message and triggers retry',
        (tester) async {
      var retried = false;
      await tester.pumpWidget(
        _wrapWithTheme(
          PorsiErrorView(
            message: 'Gagal memuat data pangan.',
            onRetry: () => retried = true,
          ),
        ),
      );

      expect(find.text('Gagal memuat data pangan.'), findsOneWidget);
      await tester.tap(find.text('Coba Lagi'));
      expect(retried, isTrue);
    });

    testWidgets('PorsiLoadingIndicator displays spinner and optional message',
        (tester) async {
      await tester.pumpWidget(
        _wrapWithTheme(
          const PorsiLoadingIndicator(message: 'Menyiapkan data...'),
        ),
      );

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
      expect(find.text('Menyiapkan data...'), findsOneWidget);
    });
  });
}
