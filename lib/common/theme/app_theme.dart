import 'package:easybudget_app/common/theme/app_colors.dart';
import 'package:flutter/material.dart';

ThemeData lightMode() {
  return ThemeData(
    brightness: Brightness.light,
    colorScheme: ColorScheme.light(
      primary: AppColors.lightThemeMain,
      onPrimary: AppColors.lightThemeLightFont,
      primaryContainer: AppColors.lightThemeLightMain,
      onPrimaryContainer: AppColors.lightThemeFont,
      secondary: AppColors.lightThemeDisIcon,
      surface: AppColors.lightThemeInvist,
      onSurface: AppColors.lightFont,
    ),
  );
}

ThemeData darkMode() {
  return ThemeData(
    brightness: Brightness.dark,
    colorScheme: ColorScheme.dark(
      primary: AppColors.darkThemeMain,
      onPrimary: AppColors.darkThemeLightFont,
      primaryContainer: AppColors.darkThemeLightMain,
      onPrimaryContainer: AppColors.darkThemeFont,
      secondary: AppColors.darkThemeDisIcon,
      surface: AppColors.darkThemeInvist,
      onSurface: AppColors.darkFont,
    ),
  );
}
