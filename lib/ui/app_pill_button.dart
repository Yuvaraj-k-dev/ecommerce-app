import 'package:flutter/material.dart';

class AppPillButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final Widget label;
  final Widget? icon;
  final bool filled;

  const AppPillButton({
    super.key,
    required this.onPressed,
    required this.label,
    this.icon,
    this.filled = false,
  });

  const AppPillButton.filled({
    super.key,
    required this.onPressed,
    required this.label,
    this.icon,
  }) : filled = true;

  @override
  Widget build(BuildContext context) {
    final child =
        icon == null
            ? label
            : Row(
              mainAxisSize: MainAxisSize.min,
              children: [icon!, const SizedBox(width: 8), label],
            );

    if (filled) {
      return FilledButton(
        onPressed: onPressed,
        style: FilledButton.styleFrom(
          backgroundColor: Colors.black,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(999),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        ),
        child: child,
      );
    }

    return OutlinedButton(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        foregroundColor: Colors.black87,
        backgroundColor: Colors.white,
        side: const BorderSide(color: Colors.black12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(999)),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      ),
      child: child,
    );
  }
}
