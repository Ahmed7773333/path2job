import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'app_color.dart';

class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.light(
        primary: AppColor.primaryColor,
        secondary: AppColor.secondaryColor,
        surface: AppColor.backgroundColor,
        error: AppColor.errorColor,
        onPrimary: AppColor.textColor,
        onSecondary: AppColor.textColor,
        onSurface: AppColor.primaryColor,
        onError: AppColor.textColor,
      ),
      scaffoldBackgroundColor: AppColor.lavender,
      appBarTheme: AppBarTheme(
        backgroundColor: AppColor.primaryColor,
        foregroundColor: AppColor.textColor,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: TextStyle(
          fontSize: 20.sp,
          fontWeight: FontWeight.w600,
          color: AppColor.textColor,
        ),
        iconTheme: IconThemeData(color: AppColor.textColor),
      ),
      textTheme: TextTheme(
        displayLarge: TextStyle(
          fontSize: 32.sp,
          fontWeight: FontWeight.bold,
          color: AppColor.primaryColor,
        ),
        displayMedium: TextStyle(
          fontSize: 24.sp,
          fontWeight: FontWeight.w600,
          color: AppColor.primaryColor,
        ),
        bodyLarge: TextStyle(
          fontSize: 16.sp,
          fontWeight: FontWeight.normal,
          color: AppColor.primaryColor,
        ),
        bodyMedium: TextStyle(
          fontSize: 14.sp,
          fontWeight: FontWeight.normal,
          color: AppColor.primaryColor.withOpacity(0.8),
        ),
        labelLarge: TextStyle(
          fontSize: 16.sp,
          fontWeight: FontWeight.w500,
          color: AppColor.textColor,
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColor.primaryColor,
          foregroundColor: AppColor.textColor,
          padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.h),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.r),
          ),
          textStyle: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColor.primaryColor,
          side: BorderSide(color: AppColor.primaryColor),
          padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.r),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.r),
          ),
          textStyle: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: Colors.white.withOpacity(0.8),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.r),
          borderSide: BorderSide.none,
        ),
        contentPadding: EdgeInsets.symmetric(
          horizontal: 16.w,
          vertical: 14.h,
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
          borderRadius: BorderRadius.circular(12.r),
        ),
      ),
      dividerTheme: DividerThemeData(
        color: AppColor.primaryColor.withOpacity(0.2),
        thickness: 1.h,
        space: 1.w,
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