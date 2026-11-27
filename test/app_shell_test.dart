import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:porsi_pas/app.dart';
import 'package:porsi_pas/core/constants/app_constants.dart';
import 'package:porsi_pas/core/constants/route_paths.dart';
import 'package:porsi_pas/core/di/injection_container.dart';
import 'package:porsi_pas/core/router/app_router.dart';

void main() {
  setUpAll(() async {
    GoogleFonts.config.allowRuntimeFetching = false;
    await initializeDateFormatting(AppConstants.defaultLocale);
  });

  tearDown(() async {
    await resetDependencies();
  });

  group('PorsiPas Navigation Shell', () {
    testWidgets(
      'renders 4 Indonesian tabs and switches between all branches cleanly',
      (tester) async {
        final appRouter = AppRouter();
        addTearDown(appRouter.dispose);

        await tester.pumpWidget(
          PorsiPasApp(
            router: appRouter.router,
            useGoogleFonts: false,
          ),
        );
        await tester.pumpAndSettle();

        expect(find.text('Halo, Sahabat PorsiPas'), findsOneWidget);
        expect(find.text('Beranda'), findsOneWidget);
        expect(find.text('Kalkulator'), findsOneWidget);
        expect(find.text('Diary'), findsOneWidget);
        expect(find.text('Profil'), findsOneWidget);

        await tester.tap(find.text('Kalkulator'));
        await tester.pumpAndSettle();
        expect(find.text('Kalkulator Porsi & Gizi'), findsOneWidget);

        await tester.tap(find.text('Diary'));
        await tester.pumpAndSettle();
        expect(find.text('Food Diary'), findsOneWidget);

        await tester.tap(find.text('Profil'));
        await tester.pumpAndSettle();
        expect(find.text('Profil & Target Gizi'), findsOneWidget);
      },
    );

    testWidgets(
      'preserves Kalkulator state across tab switches via StatefulShellRoute.indexedStack',
      (tester) async {
        final appRouter = AppRouter();
        addTearDown(appRouter.dispose);

        await tester.pumpWidget(
          PorsiPasApp(
            router: appRouter.router,
            useGoogleFonts: false,
          ),
        );
        await tester.pumpAndSettle();

        await tester.tap(find.text('Kalkulator'));
        await tester.pumpAndSettle();

        await tester.tap(find.text('Goreng'));
        await tester.pumpAndSettle();

        final gorengChipBefore = tester.widget<ChoiceChip>(
          find.widgetWithText(ChoiceChip, 'Goreng'),
        );
        expect(gorengChipBefore.selected, isTrue);

        await tester.tap(find.text('Diary'));
        await tester.pumpAndSettle();
        expect(find.text('Food Diary'), findsOneWidget);

        await tester.tap(find.text('Kalkulator'));
        await tester.pumpAndSettle();

        final gorengChipAfter = tester.widget<ChoiceChip>(
          find.widgetWithText(ChoiceChip, 'Goreng'),
        );
        expect(gorengChipAfter.selected, isTrue);
      },
    );

    testWidgets(
      'supports redirect callback to reserved auth route without infinite loop',
      (tester) async {
        final appRouter = AppRouter(
          redirect: (_, state) =>
              state.matchedLocation == RoutePaths.login ? null : RoutePaths.login,
        );
        addTearDown(appRouter.dispose);

        await tester.pumpWidget(
          PorsiPasApp(
            router: appRouter.router,
            useGoogleFonts: false,
          ),
        );
        await tester.pumpAndSettle();

        expect(find.text('Masuk Akun PorsiPas'), findsOneWidget);
      },
    );
  });
}
