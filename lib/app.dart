import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'core/constants/app_constants.dart';
import 'core/di/injection_container.dart';
import 'core/router/app_router.dart';
import 'core/theme/app_theme.dart';

/// Root widget aplikasi PorsiPas.
class PorsiPasApp extends StatelessWidget {
  const PorsiPasApp({
    super.key,
    this.router,
    this.useGoogleFonts = true,
  });

  final GoRouter? router;
  final bool useGoogleFonts;

  @override
  Widget build(BuildContext context) {
    final activeRouter = router ?? sl<AppRouter>().router;

    return MaterialApp.router(
      title: AppConstants.appName,
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light(useGoogleFonts: useGoogleFonts),
      routerConfig: activeRouter,
    );
  }
}
