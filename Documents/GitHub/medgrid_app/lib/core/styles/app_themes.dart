import 'package:flutter/material.dart';

import 'app_colors.dart';
import 'app_text_styles.dart';

/// Styles class holding app theming information
class AppThemes {
  /// Dark theme data of the app
  static ThemeData get darkTheme {
    return ThemeData(
      brightness: Brightness.dark,
      fontFamily: AppTextStyles.fontFamily,
      primaryColor: AppColors.getMaterialColorFromColor(AppColors.primary),
      colorScheme: const ColorScheme.dark(
        primary: AppColors.primary,
        secondary: AppColors.secondary,
        background: AppColors.black,
      ),
      backgroundColor: AppColors.black,
      scaffoldBackgroundColor: AppColors.black,
      textTheme: TextThemes.darkTextTheme,
      primaryTextTheme: TextThemes.primaryTextTheme,
      appBarTheme: const AppBarTheme(
        elevation: 0,
        backgroundColor: AppColors.black,
        titleTextStyle: AppTextStyles.h2,
      ),
    );
  }

  /// Light theme data of the app
  static ThemeData get lightTheme {
    return ThemeData(
      brightness: Brightness.light,
      primaryColor: AppColors.getMaterialColorFromColor(AppColors.primary),
      textTheme: TextThemes.textTheme,
      primaryTextTheme: TextThemes.primaryTextTheme,
      colorScheme: const ColorScheme.light(
        primary: AppColors.primary,
        secondary: AppColors.secondary,
      ),
      scaffoldBackgroundColor: AppColors.white,
      dividerColor: AppColors.black,
      dividerTheme:
          const DividerThemeData(color: AppColors.secondary, thickness: 1),
      appBarTheme: AppBarTheme(
        elevation: 0,
        backgroundColor: AppColors.white,
       
        titleTextStyle: dynamicStyle(
          color: AppColors.black,
          fontSize: 18,
          fontWeight: FontWeight.w700,
        ),
        iconTheme: const IconThemeData(color: AppColors.black),
        
      ),
    );
  }

  static TextStyle dynamicStyle({
    bool inherit = true,
     Color? color = AppColors.black , 
    Color? backgroundColor,
    double? fontSize,
    FontWeight? fontWeight,
    FontStyle? fontStyle,
    double? letterSpacing,
    double? wordSpacing,
    TextBaseline? textBaseline,
    double? height,
    TextLeadingDistribution? leadingDistribution,
    Locale? locale,
    Paint? foreground,
    Paint? background,
    List<Shadow>? shadows,
    TextDecoration? decoration,
    Color? decorationColor,
    TextDecorationStyle? decorationStyle,
    double? decorationThickness,
    String? debugLabel,
    List<String>? fontFamilyFallback,
    String? package,
    TextOverflow? overflow,
  }) =>
      TextStyle(
        color: color,
        background: background,
        leadingDistribution: leadingDistribution,
        backgroundColor: backgroundColor,
        debugLabel: debugLabel,
        decoration: decoration,
        decorationColor: decorationColor,
        decorationStyle: decorationStyle,
        decorationThickness: decorationThickness,
        fontFamilyFallback: fontFamilyFallback,
        fontSize: fontSize,
        fontStyle: fontStyle,
        fontWeight: fontWeight,
        foreground: foreground,
        height: height,
        inherit: inherit,
        letterSpacing: letterSpacing,
        locale: locale,
        overflow: overflow,
        package: package,
        shadows: shadows,
        textBaseline: textBaseline,
        wordSpacing: wordSpacing,
      );
}

/// Styles class holding app text theming information
class TextThemes {
  /// Main text theme
  static TextTheme get textTheme {
    return const TextTheme(
      bodyText1: AppTextStyles.bodyLg,
      bodyText2: AppTextStyles.body,
      subtitle1: AppTextStyles.bodySm,
      subtitle2: AppTextStyles.bodyXs,
      headline1: AppTextStyles.h1,
      headline2: AppTextStyles.h2,
      headline3: AppTextStyles.h3,
      headline4: AppTextStyles.h4,
    );
  }

  /// Dark text theme
  static TextTheme get darkTextTheme {
    return TextTheme(
      bodyText1: AppTextStyles.bodyLg.copyWith(color: AppColors.white),
      bodyText2: AppTextStyles.body.copyWith(color: AppColors.white),
      subtitle1: AppTextStyles.bodySm.copyWith(color: AppColors.white),
      subtitle2: AppTextStyles.bodyXs.copyWith(color: AppColors.white),
      headline1: AppTextStyles.h1.copyWith(color: AppColors.white),
      headline2: AppTextStyles.h2.copyWith(color: AppColors.white),
      headline3: AppTextStyles.h3.copyWith(color: AppColors.white),
      headline4: AppTextStyles.h4.copyWith(color: AppColors.white),
    );
  }

  /// Primary text theme
  /// Uses [AppColors.primary] for all text styles
  static TextTheme get primaryTextTheme {
    return TextTheme(
      bodyText1: AppTextStyles.bodyLg.copyWith(color: AppColors.primary),
      bodyText2: AppTextStyles.body.copyWith(color: AppColors.primary),
      subtitle1: AppTextStyles.bodySm.copyWith(color: AppColors.primary),
      subtitle2: AppTextStyles.bodyXs.copyWith(color: AppColors.primary),
      headline1: AppTextStyles.h1.copyWith(color: AppColors.primary),
      headline2: AppTextStyles.h2.copyWith(color: AppColors.primary),
      headline3: AppTextStyles.h3.copyWith(color: AppColors.primary),
      headline4: AppTextStyles.h4.copyWith(color: AppColors.primary),
    );
  }
}
