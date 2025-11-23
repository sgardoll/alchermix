import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LightModeColors {
  // Original vibrant palette: purple → pink with cyan accent
  static const lightPrimary = Color(0xFF6B4CE6); // purple
  static const lightOnPrimary = Color(0xFFFFFFFF);
  static const lightPrimaryContainer = Color(0xFFE7E1FF); // soft purple tint
  static const lightOnPrimaryContainer = Color(0xFF20124D);

  static const lightSecondary = Color(0xFFFF6B9D); // pink
  static const lightOnSecondary = Color(0xFF3A0320);

  static const lightTertiary = Color(0xFF00D9FF); // cyan accent
  static const lightOnTertiary = Color(0xFF002B33);

  static const lightError = Color(0xFFB3261E);
  static const lightOnError = Color(0xFFFFFFFF);
  static const lightErrorContainer = Color(0xFFF9DEDC);
  static const lightOnErrorContainer = Color(0xFF410E0B);

  static const lightInversePrimary = Color(0xFFB7A7FF);
  static const lightShadow = Color(0xFF000000);
  static const lightSurface = Color(0xFFFCFCFC);
  static const lightOnSurface = Color(0xFF1A1A1A);
  static const lightAppBarBackground = Color(0xFFFCFCFC);

  // Accent gradients for emphasis
  static const lightFusionGradientStart = Color(0xFF6B4CE6);
  static const lightFusionGradientEnd = Color(0xFFFF6B9D);
  static const lightAccentGlow = Color(0xFF00D9FF);
}

class DarkModeColors {
  static const darkPrimary = Color(0xFFB7A7FF); // lighter purple for dark bg
  static const darkOnPrimary = Color(0xFF1B1440);
  static const darkPrimaryContainer = Color(0xFF3F2E96);
  static const darkOnPrimaryContainer = Color(0xFFE7E1FF);

  static const darkSecondary = Color(0xFFFF9BC0); // pink tint
  static const darkOnSecondary = Color(0xFF3A0320);

  static const darkTertiary = Color(0xFF66E6FF); // cyan accent
  static const darkOnTertiary = Color(0xFF002B33);

  static const darkError = Color(0xFFFFB4AB);
  static const darkOnError = Color(0xFF690005);
  static const darkErrorContainer = Color(0xFF93000A);
  static const darkOnErrorContainer = Color(0xFFFFDAD6);

  static const darkInversePrimary = Color(0xFF6B4CE6);
  static const darkShadow = Color(0xFF000000);
  static const darkSurface = Color(0xFF0F1113);
  static const darkOnSurface = Color(0xFFE8E8E8);
  static const darkAppBarBackground = Color(0xFF0F1113);

  static const darkFusionGradientStart = Color(0xFF6B4CE6);
  static const darkFusionGradientEnd = Color(0xFFFF6B9D);
  static const darkAccentGlow = Color(0xFF00D9FF);
}

class FontSizes {
  static const double displayLarge = 57.0;
  static const double displayMedium = 45.0;
  static const double displaySmall = 36.0;
  static const double headlineLarge = 32.0;
  static const double headlineMedium = 24.0;
  static const double headlineSmall = 22.0;
  static const double titleLarge = 22.0;
  static const double titleMedium = 18.0;
  static const double titleSmall = 16.0;
  static const double labelLarge = 16.0;
  static const double labelMedium = 14.0;
  static const double labelSmall = 12.0;
  static const double bodyLarge = 16.0;
  static const double bodyMedium = 14.0;
  static const double bodySmall = 12.0;
}

ThemeData get lightTheme => ThemeData(
  useMaterial3: true,
  colorScheme: ColorScheme.light(
    primary: LightModeColors.lightPrimary,
    onPrimary: LightModeColors.lightOnPrimary,
    primaryContainer: LightModeColors.lightPrimaryContainer,
    onPrimaryContainer: LightModeColors.lightOnPrimaryContainer,
    secondary: LightModeColors.lightSecondary,
    onSecondary: LightModeColors.lightOnSecondary,
    tertiary: LightModeColors.lightTertiary,
    onTertiary: LightModeColors.lightOnTertiary,
    error: LightModeColors.lightError,
    onError: LightModeColors.lightOnError,
    errorContainer: LightModeColors.lightErrorContainer,
    onErrorContainer: LightModeColors.lightOnErrorContainer,
    inversePrimary: LightModeColors.lightInversePrimary,
    shadow: LightModeColors.lightShadow,
    surface: LightModeColors.lightSurface,
    onSurface: LightModeColors.lightOnSurface,
  ),
  brightness: Brightness.light,
  appBarTheme: AppBarTheme(
    backgroundColor: LightModeColors.lightAppBarBackground,
    foregroundColor: LightModeColors.lightOnPrimaryContainer,
    elevation: 0,
  ),
  iconTheme: const IconThemeData(color: LightModeColors.lightOnSurface),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      backgroundColor: MaterialStatePropertyAll(LightModeColors.lightPrimary),
      foregroundColor: const MaterialStatePropertyAll(LightModeColors.lightOnPrimary),
      overlayColor: MaterialStatePropertyAll(
        LightModeColors.lightOnPrimary.withValues(alpha: 0.08),
      ),
      shape: MaterialStatePropertyAll(
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),
      padding: const MaterialStatePropertyAll(EdgeInsets.symmetric(horizontal: 20, vertical: 14)),
    ),
  ),
  outlinedButtonTheme: OutlinedButtonThemeData(
    style: ButtonStyle(
      foregroundColor: const MaterialStatePropertyAll(LightModeColors.lightPrimary),
      overlayColor: MaterialStatePropertyAll(
        LightModeColors.lightPrimary.withValues(alpha: 0.08),
      ),
      side: const MaterialStatePropertyAll(BorderSide(color: LightModeColors.lightPrimary, width: 1.2)),
      shape: MaterialStatePropertyAll(
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),
      padding: const MaterialStatePropertyAll(EdgeInsets.symmetric(horizontal: 20, vertical: 14)),
    ),
  ),
  textButtonTheme: TextButtonThemeData(
    style: ButtonStyle(
      foregroundColor: const MaterialStatePropertyAll(LightModeColors.lightSecondary),
      overlayColor: MaterialStatePropertyAll(
        LightModeColors.lightSecondary.withValues(alpha: 0.12),
      ),
      shape: MaterialStatePropertyAll(
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      padding: const MaterialStatePropertyAll(EdgeInsets.symmetric(horizontal: 16, vertical: 12)),
    ),
  ),
  textTheme: TextTheme(
    displayLarge: GoogleFonts.inter(
      fontSize: FontSizes.displayLarge,
      fontWeight: FontWeight.normal,
    ),
    displayMedium: GoogleFonts.inter(
      fontSize: FontSizes.displayMedium,
      fontWeight: FontWeight.normal,
    ),
    displaySmall: GoogleFonts.inter(
      fontSize: FontSizes.displaySmall,
      fontWeight: FontWeight.w600,
    ),
    headlineLarge: GoogleFonts.inter(
      fontSize: FontSizes.headlineLarge,
      fontWeight: FontWeight.normal,
    ),
    headlineMedium: GoogleFonts.inter(
      fontSize: FontSizes.headlineMedium,
      fontWeight: FontWeight.w500,
    ),
    headlineSmall: GoogleFonts.inter(
      fontSize: FontSizes.headlineSmall,
      fontWeight: FontWeight.bold,
    ),
    titleLarge: GoogleFonts.inter(
      fontSize: FontSizes.titleLarge,
      fontWeight: FontWeight.w500,
    ),
    titleMedium: GoogleFonts.inter(
      fontSize: FontSizes.titleMedium,
      fontWeight: FontWeight.w500,
    ),
    titleSmall: GoogleFonts.inter(
      fontSize: FontSizes.titleSmall,
      fontWeight: FontWeight.w500,
    ),
    labelLarge: GoogleFonts.inter(
      fontSize: FontSizes.labelLarge,
      fontWeight: FontWeight.w500,
    ),
    labelMedium: GoogleFonts.inter(
      fontSize: FontSizes.labelMedium,
      fontWeight: FontWeight.w500,
    ),
    labelSmall: GoogleFonts.inter(
      fontSize: FontSizes.labelSmall,
      fontWeight: FontWeight.w500,
    ),
    bodyLarge: GoogleFonts.inter(
      fontSize: FontSizes.bodyLarge,
      fontWeight: FontWeight.normal,
    ),
    bodyMedium: GoogleFonts.inter(
      fontSize: FontSizes.bodyMedium,
      fontWeight: FontWeight.normal,
    ),
    bodySmall: GoogleFonts.inter(
      fontSize: FontSizes.bodySmall,
      fontWeight: FontWeight.normal,
    ),
  ),
);

ThemeData get darkTheme => ThemeData(
  useMaterial3: true,
  colorScheme: ColorScheme.dark(
    primary: DarkModeColors.darkPrimary,
    onPrimary: DarkModeColors.darkOnPrimary,
    primaryContainer: DarkModeColors.darkPrimaryContainer,
    onPrimaryContainer: DarkModeColors.darkOnPrimaryContainer,
    secondary: DarkModeColors.darkSecondary,
    onSecondary: DarkModeColors.darkOnSecondary,
    tertiary: DarkModeColors.darkTertiary,
    onTertiary: DarkModeColors.darkOnTertiary,
    error: DarkModeColors.darkError,
    onError: DarkModeColors.darkOnError,
    errorContainer: DarkModeColors.darkErrorContainer,
    onErrorContainer: DarkModeColors.darkOnErrorContainer,
    inversePrimary: DarkModeColors.darkInversePrimary,
    shadow: DarkModeColors.darkShadow,
    surface: DarkModeColors.darkSurface,
    onSurface: DarkModeColors.darkOnSurface,
  ),
  brightness: Brightness.dark,
  appBarTheme: AppBarTheme(
    backgroundColor: DarkModeColors.darkAppBarBackground,
    foregroundColor: DarkModeColors.darkOnPrimaryContainer,
    elevation: 0,
  ),
  iconTheme: const IconThemeData(color: DarkModeColors.darkOnSurface),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      backgroundColor: MaterialStatePropertyAll(DarkModeColors.darkPrimary),
      foregroundColor: const MaterialStatePropertyAll(DarkModeColors.darkOnPrimary),
      overlayColor: MaterialStatePropertyAll(
        DarkModeColors.darkOnPrimary.withValues(alpha: 0.12),
      ),
      shape: MaterialStatePropertyAll(
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),
      padding: const MaterialStatePropertyAll(EdgeInsets.symmetric(horizontal: 20, vertical: 14)),
    ),
  ),
  outlinedButtonTheme: OutlinedButtonThemeData(
    style: ButtonStyle(
      foregroundColor: const MaterialStatePropertyAll(DarkModeColors.darkPrimary),
      overlayColor: MaterialStatePropertyAll(
        DarkModeColors.darkPrimary.withValues(alpha: 0.10),
      ),
      side: const MaterialStatePropertyAll(BorderSide(color: DarkModeColors.darkPrimary, width: 1.2)),
      shape: MaterialStatePropertyAll(
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),
      padding: const MaterialStatePropertyAll(EdgeInsets.symmetric(horizontal: 20, vertical: 14)),
    ),
  ),
  textButtonTheme: TextButtonThemeData(
    style: ButtonStyle(
      foregroundColor: const MaterialStatePropertyAll(DarkModeColors.darkSecondary),
      overlayColor: MaterialStatePropertyAll(
        DarkModeColors.darkSecondary.withValues(alpha: 0.16),
      ),
      shape: MaterialStatePropertyAll(
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      padding: const MaterialStatePropertyAll(EdgeInsets.symmetric(horizontal: 16, vertical: 12)),
    ),
  ),
  textTheme: TextTheme(
    displayLarge: GoogleFonts.inter(
      fontSize: FontSizes.displayLarge,
      fontWeight: FontWeight.normal,
    ),
    displayMedium: GoogleFonts.inter(
      fontSize: FontSizes.displayMedium,
      fontWeight: FontWeight.normal,
    ),
    displaySmall: GoogleFonts.inter(
      fontSize: FontSizes.displaySmall,
      fontWeight: FontWeight.w600,
    ),
    headlineLarge: GoogleFonts.inter(
      fontSize: FontSizes.headlineLarge,
      fontWeight: FontWeight.normal,
    ),
    headlineMedium: GoogleFonts.inter(
      fontSize: FontSizes.headlineMedium,
      fontWeight: FontWeight.w500,
    ),
    headlineSmall: GoogleFonts.inter(
      fontSize: FontSizes.headlineSmall,
      fontWeight: FontWeight.bold,
    ),
    titleLarge: GoogleFonts.inter(
      fontSize: FontSizes.titleLarge,
      fontWeight: FontWeight.w500,
    ),
    titleMedium: GoogleFonts.inter(
      fontSize: FontSizes.titleMedium,
      fontWeight: FontWeight.w500,
    ),
    titleSmall: GoogleFonts.inter(
      fontSize: FontSizes.titleSmall,
      fontWeight: FontWeight.w500,
    ),
    labelLarge: GoogleFonts.inter(
      fontSize: FontSizes.labelLarge,
      fontWeight: FontWeight.w500,
    ),
    labelMedium: GoogleFonts.inter(
      fontSize: FontSizes.labelMedium,
      fontWeight: FontWeight.w500,
    ),
    labelSmall: GoogleFonts.inter(
      fontSize: FontSizes.labelSmall,
      fontWeight: FontWeight.w500,
    ),
    bodyLarge: GoogleFonts.inter(
      fontSize: FontSizes.bodyLarge,
      fontWeight: FontWeight.normal,
    ),
    bodyMedium: GoogleFonts.inter(
      fontSize: FontSizes.bodyMedium,
      fontWeight: FontWeight.normal,
    ),
    bodySmall: GoogleFonts.inter(
      fontSize: FontSizes.bodySmall,
      fontWeight: FontWeight.normal,
    ),
  ),
);
