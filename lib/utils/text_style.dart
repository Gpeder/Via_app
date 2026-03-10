import 'package:flutter/material.dart';
import 'package:via_app/utils/color.dart';

TextTheme mainTextTheme() {
  return TextTheme(
    //* Texto detalhes
    bodySmall: TextStyle(fontSize: 12, color: AppColors.gray200, letterSpacing: 0.5),
    //* Texto detalhes mais importante
    bodyMedium: TextStyle(fontSize: 14, color: AppColors.black, letterSpacing: 0.5),
    //* Texto padrão
    bodyLarge: TextStyle(fontSize: 16, color: AppColors.black, letterSpacing: 0.5),
    //* Título pequeno
    titleSmall: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.bold,
      color: AppColors.black,
      letterSpacing: 0.5,
    ),
    //* Título comum
    titleMedium: TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.bold,
      color: AppColors.black,
      letterSpacing: 0.5,
    ),
    //* Título grande
    titleLarge: TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.bold,
      color: AppColors.black,
      letterSpacing: 0.5,
    ),
  );
}