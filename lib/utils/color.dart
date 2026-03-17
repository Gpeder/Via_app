import 'package:flutter/material.dart';

class AppColors {
  static final Color background = const Color(0xFFF6F7F9);
  static final Color primaryLight = const Color(
    0xFFF2BE24,
  ).withValues(alpha: 0.2);
  static const Color primary = Color(0xFFF2BE24);
  static const Color primaryDark = Color(0xFFC49000);
  static const Color primaryNearBlack = Color(0xFF1C1A14);
  static const Color black = Color(0xFF1F1F1F);
  static const Color allBlack = Color(0xFF000000);
  static const Color white = Color(0xFFFFFFFF);
  static const Color gray100 = Color(0xFFDEE0E3);
  static const Color gray200 = Color(0xFF808080);
  static const Color destructive = Color(0xFFDC2828);
  static const Color success = Color(0xFF2E7D32);

  static const LinearGradient gradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF1F1F1F), Color(0xFF374151)],
  );

  static LinearGradient getShimmerGradient(BuildContext context) {
    final isLight = Theme.of(context).brightness == Brightness.light;
    return LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: isLight
          ? [
              const Color(0xFFEBEBF4),
              const Color(0xFFF4F4F4),
              const Color(0xFFEBEBF4),
            ]
          : [
              const Color(0xFF3A3A3C),
              const Color(0xFF48484A),
              const Color(0xFF3A3A3C),
            ],
      stops: const [0.1, 0.3, 0.4],
    );
  }
}
