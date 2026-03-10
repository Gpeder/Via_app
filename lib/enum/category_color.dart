import 'package:flutter/material.dart';

enum CategoryColor {
  animais,
  alimentacao,
  criancaeidosos,
  meioambiente,
  educacao,
  saude,
  culturaearte,
  tecnologia,
  esportes,
  geraloutros;

  static CategoryColor fromDisplayName(String name) {
    return CategoryColor.values.firstWhere(
      (e) => e.displayName.toLowerCase() == name.toLowerCase(),
      orElse: () => CategoryColor.geraloutros,
    );
  }

  String get displayName {
    switch (this) {
      case CategoryColor.animais:
        return 'Animais';
      case CategoryColor.alimentacao:
        return 'Alimentação';
      case CategoryColor.criancaeidosos:
        return 'Crianças e Jovens';
      case CategoryColor.meioambiente:
        return 'Meio Ambiente';
      case CategoryColor.educacao:
        return 'Educação';
      case CategoryColor.saude:
        return 'Saúde';
      case CategoryColor.culturaearte:
        return 'Cultura e Arte';
      case CategoryColor.tecnologia:
        return 'Tecnologia';
      case CategoryColor.esportes:
        return 'Esportes';
      case CategoryColor.geraloutros:
        return 'Geral / Outros';
    }
  }

  Color get bgColor {
    switch (this) {
      case CategoryColor.animais:
        return Color(0xFFFFE0B5);
      case CategoryColor.alimentacao:
        return Color(0xFFD4E6F1);
      case CategoryColor.criancaeidosos:
        return Color(0xFFFADADD);
      case CategoryColor.meioambiente:
        return Color(0xFFD5F0D5);
      case CategoryColor.educacao:
        return Color(0xFFFFF1C1);
      case CategoryColor.saude:
        return Color(0xFFFED9B7);
      case CategoryColor.culturaearte:
        return Color(0xFFE6D5F0);
      case CategoryColor.tecnologia:
        return Color(0xFFD1EEF5);
      case CategoryColor.esportes:
        return Color(0xFFFFD6A5);
      case CategoryColor.geraloutros:
        return Color(0xFFE0E0E0);
    }
  }

  Color get textColor {
    return bgColor.darken(0.4);
  }
}

extension DarkenColor on Color {
  Color darken(double amount) {
    assert(amount >= 0 && amount <= 1);
    final hsl = HSLColor.fromColor(this);
    final hslDark = hsl.withLightness((hsl.lightness - amount).clamp(0.0, 1.0));
    return hslDark.toColor();
  }
}