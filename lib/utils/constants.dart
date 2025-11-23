import 'package:flutter/material.dart';

class AppConstants {
  static const String appName = 'The Alphermix';
  static const String tagline = 'Where Ideas Collide';
  
  static const double borderRadius = 24.0;
  static const double cardPadding = 24.0;
  static const double spacing = 16.0;
  static const double largeSpacing = 32.0;
  
  static const Duration shortAnimation = Duration(milliseconds: 300);
  static const Duration mediumAnimation = Duration(milliseconds: 500);
  static const Duration longAnimation = Duration(milliseconds: 800);
  
  static List<String> funFacts = [
    'The Post-it Note was invented by accident in 1968',
    'The Slinky was created by accident during WWII',
    'Velcro was inspired by burrs stuck to a dog\'s fur',
    'Super Glue was discovered while trying to make clear plastic gunsights',
    'The microwave was invented after a researcher noticed a chocolate bar melting',
    'Play-Doh was originally wallpaper cleaner',
    'Coca-Cola was initially sold as a medicine',
    'The pacemaker was invented accidentally during heart research',
  ];
  
  static LinearGradient getFusionGradient(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: isDark
        ? [const Color(0xFF6B4CE6), const Color(0xFFFF6B9D)]
        : [const Color(0xFF6B4CE6), const Color(0xFFFF6B9D)],
    );
  }
  
  static BoxShadow getGlowShadow(Color color) => BoxShadow(
    color: color.withValues(alpha: 0.4),
    blurRadius: 20,
    spreadRadius: 2,
  );
}
