// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'app_config.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    colorScheme: const ColorScheme(
      brightness: Brightness.light,
      primary: AppConfig.lightPrimaryColor,
      onPrimary: Colors.white,
      secondary: AppConfig.secondaryColor,
      onSecondary: Colors.black,
      tertiary: Color(0xFFFAFAFA),
      onTertiary: Color(0xFFFAFAFA),
      error: Colors.red,
      onError: Colors.white,
      surface: Colors.white,
      onSurface: AppConfig.textPrimary,
      surfaceVariant: Color(0xFFE4E4E4),
      onSurfaceVariant: AppConfig.textSecondary,
      outline: Color(0xFFE0E0E0),
      outlineVariant: Color(0xFFF0F0F0),
      inverseSurface: Color(0xFF2E2E2E),
      onInverseSurface: Colors.white,
      inversePrimary: Color(0xFF8AB4F8),
      shadow: Colors.black12,
      scrim: Colors.black54,
    ),
    useMaterial3: true,
    scaffoldBackgroundColor: Color(0xFFEBEBEB),
    appBarTheme: AppBarTheme(
      backgroundColor: AppConfig.lightBlue,
      foregroundColor: AppConfig.textPrimary,
      elevation: 0,
      iconTheme: const IconThemeData(color: AppConfig.lightPrimaryColor),
      titleTextStyle: AppConfig.poppinsSemiBold,
      systemOverlayStyle: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.light,
      ),
    ),
    textTheme: TextTheme(
      bodyLarge: AppConfig.poppinsRegular,
      bodyMedium: AppConfig.poppinsMedium,
      titleMedium: AppConfig.poppinsSemiBold,
      titleLarge: AppConfig.poppinsBold,
    ),
    buttonTheme: const ButtonThemeData(
      buttonColor: AppConfig.lightPrimaryColor,
      textTheme: ButtonTextTheme.primary,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppConfig.lightPrimaryColor,
        foregroundColor: Colors.white,
        elevation: 2,
        shadowColor: Colors.black26,
      ),
    ),
    cardTheme: CardThemeData(
      color: Colors.white,
      elevation: 2,
      shadowColor: Colors.black12,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
    ),
  );

  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    colorScheme: const ColorScheme(
      brightness: Brightness.dark,
      primary: AppConfig.darkPrimaryColor,
      onPrimary: Colors.black,
      secondary: AppConfig.secondaryColor,
      onSecondary: Colors.white,
      tertiary: Color(0xFF333333),
      onTertiary: Color(0xFF272727),
      error: Colors.red,
      onError: Colors.black,
      surface: Color(0xFF212220),
      onSurface: AppConfig.textSecondary,
      surfaceVariant: Color(0xFF1C1C1C),
      onSurfaceVariant: Color(0xFFB8BCC8),
      outline: Color(0xFF3A3E46),
      outlineVariant: Color(0xFF2F3339),
      inverseSurface: Color(0xFFE8E8E8),
      onInverseSurface: Color(0xFF2E2E2E),
      inversePrimary: Color(0xFF1976D2),
      shadow: Colors.black54,
      scrim: Colors.black87,
    ),
    useMaterial3: true,
    scaffoldBackgroundColor: const Color(0xFF171717),
    appBarTheme: AppBarTheme(
      backgroundColor: const Color(0xFF181A20),
      foregroundColor: AppConfig.textSecondary,
      elevation: 0,
      iconTheme: const IconThemeData(color: AppConfig.darkPrimaryColor),
      titleTextStyle:
          AppConfig.poppinsSemiBold.copyWith(color: AppConfig.textSecondary),
      systemOverlayStyle: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.dark,
      ),
    ),
    textTheme: TextTheme(
      bodyLarge:
          AppConfig.poppinsRegular.copyWith(color: AppConfig.textSecondary),
      bodyMedium:
          AppConfig.poppinsMedium.copyWith(color: AppConfig.textSecondary),
      titleMedium:
          AppConfig.poppinsSemiBold.copyWith(color: AppConfig.textSecondary),
      titleLarge:
          AppConfig.poppinsBold.copyWith(color: AppConfig.textSecondary),
    ),
    buttonTheme: const ButtonThemeData(
      buttonColor: AppConfig.darkPrimaryColor,
      textTheme: ButtonTextTheme.primary,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppConfig.darkPrimaryColor,
        foregroundColor: Colors.white,
        elevation: 2,
        shadowColor: Colors.black54,
      ),
    ),
    cardTheme: CardThemeData(
      color: const Color(0xFF212220),
      elevation: 2,
      shadowColor: Colors.black54,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
    ),
  );

  // Helper method to get system overlay style for current theme
  static SystemUiOverlayStyle getSystemOverlayStyle(bool isDark) {
    return SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: isDark ? Brightness.light : Brightness.dark,
      statusBarBrightness: isDark ? Brightness.dark : Brightness.light,
      systemNavigationBarColor:
          isDark ? const Color(0xFF181A20) : const Color(0xFFF8F9FA),
      systemNavigationBarIconBrightness:
          isDark ? Brightness.light : Brightness.dark,
      systemNavigationBarDividerColor: Colors.transparent,
    );
  }
}
