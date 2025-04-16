import 'package:flutter/material.dart';
import 'app_color.dart';

class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.light(
        primary: AppColor.primaryColor,
        secondary: AppColor.secondaryColor,
        surface: AppColor.backgroundColor,
        background: AppColor.backgroundColor,
        error: AppColor.errorColor,
        onPrimary: AppColor.textColor,
        onSecondary: AppColor.textColor,
        onSurface: AppColor.primaryColor,
        onBackground: AppColor.primaryColor,
        onError: AppColor.textColor,
      ),
      scaffoldBackgroundColor: AppColor.backgroundColor,
      appBarTheme: AppBarTheme(
        backgroundColor: AppColor.primaryColor,
        foregroundColor: AppColor.textColor,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: AppColor.textColor,
        ),
        iconTheme: IconThemeData(color: AppColor.textColor),
      ),
      textTheme: TextTheme(
        displayLarge: TextStyle(
          fontSize: 32,
          fontWeight: FontWeight.bold,
          color: AppColor.primaryColor,
        ),
        displayMedium: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.w600,
          color: AppColor.primaryColor,
        ),
        bodyLarge: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.normal,
          color: AppColor.primaryColor,
        ),
        bodyMedium: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.normal,
          color: AppColor.primaryColor.withOpacity(0.8),
        ),
        labelLarge: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: AppColor.textColor,
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColor.primaryColor,
          foregroundColor: AppColor.textColor,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          textStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColor.primaryColor,
          side: BorderSide(color: AppColor.primaryColor),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          textStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: Colors.white.withOpacity(0.9),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide.none,
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 14,
        ),
        hintStyle: TextStyle(
          color: AppColor.primaryColor.withOpacity(0.5),
        ),
        labelStyle: TextStyle(
          color: AppColor.primaryColor,
        ),
        errorStyle: TextStyle(
          color: AppColor.errorColor,
        ),
      ),
      cardTheme: CardTheme(
        color: Colors.white,
        elevation: 1,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      dividerTheme: DividerThemeData(
        color: AppColor.primaryColor.withOpacity(0.2),
        thickness: 1,
        space: 1,
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: AppColor.secondaryColor,
        foregroundColor: AppColor.textColor,
      ),
      progressIndicatorTheme: ProgressIndicatorThemeData(
        color: AppColor.secondaryColor,
      ),
      chipTheme: ChipThemeData(
        backgroundColor: AppColor.secondaryColor.withOpacity(0.2),
        labelStyle: TextStyle(color: AppColor.primaryColor),
        side: BorderSide.none,
      ),
    );
  }

  // Add dark theme if needed (same structure with different colors)
  static ThemeData get darkTheme => lightTheme; 
}