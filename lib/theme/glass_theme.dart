import 'package:flutter/material.dart';

class GlassTheme {
  static Color get glassColor => Colors.white.withOpacity(0.1);
  static Color get glassBorderColor => Colors.white.withOpacity(0.2);
  
  static BoxDecoration get glassDecoration => BoxDecoration(
    color: glassColor,
    borderRadius: BorderRadius.circular(20),
    border: Border.all(color: glassBorderColor),
  );

  static TextStyle get titleStyle => const TextStyle(
    color: Colors.white,
    fontSize: 18,
    fontWeight: FontWeight.bold,
  );

  static TextStyle get subtitleStyle => const TextStyle(
    color: Colors.white70,
    fontSize: 14,
  );
}
