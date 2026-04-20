import 'package:flutter/material.dart';

// App-wide configuration constants
class AppConfig {
  // Colors
  static const Color lightPrimaryColor =
      Color(0xFF6678FF); // Lime green for buttons, progress bars
  // orange for secondary buttons

  static const Color darkPrimaryColor =
      Color(0xFF6678FF); // Lime green for buttons, progress bars
  // orange for secondary buttons
  // static const Color secondaryColor =
  //     Color(0xFFFFA500); // Orange for secondary buttons
  static const Color secondaryColor =
      Color(0xFF6678FF); // Blue for highlights or links
  static const Color textPrimary = Color(0xFF3A3F4D); // Primary text color
  static const Color textSecondary = Color(0xFF8D989D); // Secondary text color
  // add full light blue for bg
  static const Color lightBlue =
      Color.fromARGB(255, 247, 252, 255); // Light blue for backgrounds

  // Typography
  static TextStyle get poppinsRegular => const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: textPrimary,
      );

  static TextStyle get poppinsMedium => const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: textPrimary,
      );

  static TextStyle get poppinsSemiBold => const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: textPrimary,
      );

  static TextStyle get poppinsBold => const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w700,
        color: textPrimary,
      );

  // Spacing
  static const double defaultPadding = 16.0;
  static const double smallPadding = 8.0;
  static const double cardRadius = 12.0;
  static const double shadowBlurRadius = 4.0;
  static const Offset shadowOffset = Offset(2, 2);
}
