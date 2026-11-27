import 'package:flutter/material.dart';

import '../theme/app_spacing.dart';

/// Tombol aksi utama PorsiPas dengan dukungan ikon dan indikator loading.
class PorsiPrimaryButton extends StatelessWidget {
  const PorsiPrimaryButton({
    required this.label,
    required this.onPressed,
    super.key,
    this.icon,
    this.isLoading = false,
    this.expand = true,
  });

  final String label;
  final VoidCallback? onPressed;
  final IconData? icon;
  final bool isLoading;
  final bool expand;

  @override
  Widget build(BuildContext context) {
    final effectiveOnPressed = isLoading ? null : onPressed;
    final style = expand
        ? null
        : FilledButton.styleFrom(minimumSize: const Size(0, 50));

    final Widget child;
    if (isLoading) {
      child = const SizedBox(
        width: 20,
        height: 20,
        child: CircularProgressIndicator(
          strokeWidth: 2.2,
          valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
        ),
      );
    } else if (icon != null) {
      child = Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(icon, size: 20),
          const SizedBox(width: AppSpacing.sm),
          Text(label),
        ],
      );
    } else {
      child = Text(label);
    }

    return FilledButton(
      onPressed: effectiveOnPressed,
      style: style,
      child: child,
    );
  }
}
