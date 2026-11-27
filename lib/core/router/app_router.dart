import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../features/calculator/presentation/pages/calculator_page.dart';
import '../../features/dashboard/presentation/pages/dashboard_page.dart';
import '../../features/food_diary/presentation/pages/food_diary_page.dart';
import '../../features/profile/presentation/pages/profile_page.dart';
import '../constants/route_paths.dart';
import 'main_shell_page.dart';

/// Callback guard rute untuk autentikasi dan onboarding profil (Phase 3–4).
typedef RouteRedirectCallback = FutureOr<String?> Function(
  BuildContext context,
  GoRouterState state,
);

/// Konfigurasi GoRouter PorsiPas dengan 4-tab `StatefulShellRoute.indexedStack`.
class AppRouter {
  AppRouter({
    String initialLocation = RoutePaths.dashboard,
    RouteRedirectCallback? redirect,
    Listenable? refreshListenable,
  }) : router = GoRouter(
          navigatorKey: GlobalKey<NavigatorState>(debugLabel: 'rootNavigator'),
          initialLocation: initialLocation,
          redirect: redirect,
          refreshListenable: refreshListenable,
          routes: <RouteBase>[
            StatefulShellRoute.indexedStack(
              builder: (context, state, navigationShell) {
                return MainShellPage(navigationShell: navigationShell);
              },
              branches: <StatefulShellBranch>[
                StatefulShellBranch(
                  routes: <RouteBase>[
                    GoRoute(
                      path: RoutePaths.dashboard,
                      builder: (context, state) => const DashboardPage(),
                    ),
                  ],
                ),
                StatefulShellBranch(
                  routes: <RouteBase>[
                    GoRoute(
                      path: RoutePaths.calculator,
                      builder: (context, state) => const CalculatorPage(),
                    ),
                  ],
                ),
                StatefulShellBranch(
                  routes: <RouteBase>[
                    GoRoute(
                      path: RoutePaths.diary,
                      builder: (context, state) => const FoodDiaryPage(),
                    ),
                  ],
                ),
                StatefulShellBranch(
                  routes: <RouteBase>[
                    GoRoute(
                      path: RoutePaths.profile,
                      builder: (context, state) => const ProfilePage(),
                    ),
                  ],
                ),
              ],
            ),
            GoRoute(
              path: RoutePaths.login,
              builder: (context, state) => const _ReservedRoutePlaceholder(
                title: 'Masuk Akun PorsiPas',
                description:
                    'Halaman Login (Email/Password & Google Sign-In) akan tersedia pada Phase 3.',
              ),
            ),
            GoRoute(
              path: RoutePaths.register,
              builder: (context, state) => const _ReservedRoutePlaceholder(
                title: 'Daftar Akun PorsiPas',
                description:
                    'Halaman Registrasi akun baru akan tersedia pada Phase 3.',
              ),
            ),
            GoRoute(
              path: RoutePaths.profileSetup,
              builder: (context, state) => const _ReservedRoutePlaceholder(
                title: 'Pengaturan Profil Gizi',
                description:
                    'Onboarding target BMR/TDEE Mifflin-St Jeor akan tersedia pada Phase 4.',
              ),
            ),
          ],
        );

  final GoRouter router;

  void dispose() {
    router.dispose();
  }
}

class _ReservedRoutePlaceholder extends StatelessWidget {
  const _ReservedRoutePlaceholder({
    required this.title,
    required this.description,
  });

  final String title;
  final String description;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Text(description, textAlign: TextAlign.center),
        ),
      ),
    );
  }
}
