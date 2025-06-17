import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppTheme {
  // Premium color palette
  static const Color primaryBlack = Color(0xFF0A0A0A);
  static const Color premiumGold = Color(0xFFD4AF37);
  static const Color softWhite = Color(0xFFFAFAFA);
  static const Color lightGray = Color(0xFFF5F5F5);
  static const Color mediumGray = Color(0xFFE0E0E0);
  static const Color darkGray = Color(0xFF757575);
  static const Color accentRed = Color(0xFFE53935);
  
  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    primaryColor: primaryBlack,
    scaffoldBackgroundColor: softWhite,
    
    colorScheme: const ColorScheme.light(
      primary: primaryBlack,
      secondary: premiumGold,
      surface: softWhite,
      background: softWhite,
      error: accentRed,
      onPrimary: softWhite,
      onSecondary: primaryBlack,
      onSurface: primaryBlack,
      onBackground: primaryBlack,
      onError: softWhite,
    ),
    
    appBarTheme: const AppBarTheme(
      elevation: 0,
      backgroundColor: softWhite,
      foregroundColor: primaryBlack,
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
      ),
      titleTextStyle: TextStyle(
        color: primaryBlack,
        fontSize: 18,
        fontWeight: FontWeight.w600,
        letterSpacing: -0.5,
      ),
    ),
    
    textTheme: const TextTheme(
      displayLarge: TextStyle(
        fontSize: 32,
        fontWeight: FontWeight.w700,
        letterSpacing: -1.5,
        color: primaryBlack,
      ),
      displayMedium: TextStyle(
        fontSize: 28,
        fontWeight: FontWeight.w600,
        letterSpacing: -1.0,
        color: primaryBlack,
      ),
      displaySmall: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.w600,
        letterSpacing: -0.5,
        color: primaryBlack,
      ),
      headlineLarge: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        letterSpacing: -0.5,
        color: primaryBlack,
      ),
      headlineMedium: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w500,
        letterSpacing: -0.5,
        color: primaryBlack,
      ),
      headlineSmall: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        letterSpacing: -0.3,
        color: primaryBlack,
      ),
      bodyLarge: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        letterSpacing: 0,
        color: primaryBlack,
      ),
      bodyMedium: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        letterSpacing: 0,
        color: primaryBlack,
      ),
      bodySmall: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        letterSpacing: 0,
        color: darkGray,
      ),
      labelLarge: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.5,
        color: primaryBlack,
      ),
    ),
    
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: primaryBlack,
        foregroundColor: softWhite,
        elevation: 0,
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        textStyle: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.5,
        ),
      ),
    ),
    
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: primaryBlack,
        side: const BorderSide(color: mediumGray, width: 1),
        elevation: 0,
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        textStyle: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.5,
        ),
      ),
    ),
    
    iconTheme: const IconThemeData(
      color: primaryBlack,
      size: 24,
    ),
    
    dividerTheme: const DividerThemeData(
      color: mediumGray,
      thickness: 1,
      space: 0,
    ),
  );
  
  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    primaryColor: softWhite,
    scaffoldBackgroundColor: primaryBlack,
    
    colorScheme: const ColorScheme.dark(
      primary: softWhite,
      secondary: premiumGold,
      surface: Color(0xFF1A1A1A),
      background: primaryBlack,
      error: accentRed,
      onPrimary: primaryBlack,
      onSecondary: primaryBlack,
      onSurface: softWhite,
      onBackground: softWhite,
      onError: softWhite,
    ),
    
    appBarTheme: const AppBarTheme(
      elevation: 0,
      backgroundColor: primaryBlack,
      foregroundColor: softWhite,
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
      ),
      titleTextStyle: TextStyle(
        color: softWhite,
        fontSize: 18,
        fontWeight: FontWeight.w600,
        letterSpacing: -0.5,
      ),
    ),
  );
} 