import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:via_app/utils/color.dart';
import 'package:via_app/utils/text_style.dart';

class AppTheme {
  static ThemeData get light {
    return ThemeData(
      fontFamily: GoogleFonts.googleSans().fontFamily,
      brightness: Brightness.light,
      textTheme: mainTextTheme(),
      scaffoldBackgroundColor: AppColors.background,
      dividerColor: AppColors.gray100,
      colorScheme: const ColorScheme.light(
        primary: AppColors.primary,
        onPrimary: AppColors.black,
        secondary: AppColors.gray100,
        onSecondary: AppColors.black,
        surface: AppColors.white,
        onSurface: AppColors.black,
        error: AppColors.destructive,
        onError: AppColors.white,
      ),
      useMaterial3: true,
    );
  }

  static ThemeData get dark {
    final darkTextTheme = mainTextTheme().apply(
      bodyColor: AppColors.white,
      displayColor: AppColors.white,
    );

    return ThemeData(
      fontFamily: GoogleFonts.googleSans().fontFamily,
      brightness: Brightness.dark,
      textTheme: darkTextTheme,
      scaffoldBackgroundColor: AppColors.allBlack,
      dividerColor: AppColors.primaryNearBlack,
      colorScheme: const ColorScheme.dark(
        primary: AppColors.primary,
        onPrimary: AppColors.black,
        secondary: AppColors.primaryNearBlack,
        onSecondary: AppColors.white,
        surface: AppColors.black,
        onSurface: AppColors.white,
        error: AppColors.destructive,
        onError: AppColors.white,
      ),
      useMaterial3: true,
    );
  }
}