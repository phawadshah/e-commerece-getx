import 'package:flutter/material.dart';
import 'package:shop/app/utils/extensions/size_extension.dart';

extension StyleExtension on BuildContext {
  static const String defaultEnglishFontFamily = 'Poppins';
  static const String defaulArabicFontFamily = 'Tajawal';

  String get currentFontFamily {
    return Localizations.localeOf(this).languageCode == 'ar'
        ? defaulArabicFontFamily
        : defaultEnglishFontFamily;
  }

  TextStyle get displayLarge => Theme.of(this).textTheme.displayLarge!.copyWith(
        fontSize: Theme.of(this).textTheme.displayLarge!.fontSize!.sp,
        fontFamily: currentFontFamily,
      );

  TextStyle get displayMedium =>
      Theme.of(this).textTheme.displayMedium!.copyWith(
            fontSize: Theme.of(this).textTheme.displayLarge!.fontSize!.sp,
            fontFamily: currentFontFamily,
          );

  TextStyle get displaySmall => Theme.of(this).textTheme.displaySmall!.copyWith(
        fontSize: Theme.of(this).textTheme.displayLarge!.fontSize!.sp,
        fontFamily: currentFontFamily,
      );

  TextStyle get headlineLarge =>
      Theme.of(this).textTheme.headlineLarge!.copyWith(
            fontSize: Theme.of(this).textTheme.headlineLarge!.fontSize!.sp,
            fontFamily: currentFontFamily,
          );

  TextStyle get headlineMedium =>
      Theme.of(this).textTheme.headlineMedium!.copyWith(
            fontSize: Theme.of(this).textTheme.headlineMedium!.fontSize!.sp,
            fontFamily: currentFontFamily,
          );

  TextStyle get headlineSmall =>
      Theme.of(this).textTheme.headlineSmall!.copyWith(
            fontSize: Theme.of(this).textTheme.headlineSmall!.fontSize!.sp,
            fontFamily: currentFontFamily,
          );

  TextStyle get titleLarge => Theme.of(this).textTheme.titleLarge!.copyWith(
        fontSize: Theme.of(this).textTheme.titleLarge!.fontSize!.sp,
        fontFamily: currentFontFamily,
      );

  TextStyle get titleMedium => Theme.of(this).textTheme.titleMedium!.copyWith(
        fontSize: Theme.of(this).textTheme.titleMedium!.fontSize!.sp,
        fontFamily: currentFontFamily,
      );

  TextStyle get titleSmall => Theme.of(this).textTheme.titleSmall!.copyWith(
        fontSize: Theme.of(this).textTheme.titleSmall!.fontSize!.sp,
        fontFamily: currentFontFamily,
      );

  TextStyle get bodyLarge => Theme.of(this).textTheme.bodyLarge!.copyWith(
        fontSize: Theme.of(this).textTheme.bodyLarge!.fontSize!.sp,
        fontFamily: currentFontFamily,
      );

  TextStyle get bodyMedium => Theme.of(this).textTheme.bodyMedium!.copyWith(
        fontSize: Theme.of(this).textTheme.bodyMedium!.fontSize!.sp,
        fontFamily: currentFontFamily,
      );

  TextStyle get bodySmall => Theme.of(this).textTheme.bodySmall!.copyWith(
        fontSize: Theme.of(this).textTheme.bodySmall!.fontSize!.sp,
        fontFamily: currentFontFamily,
      );

  TextStyle get labelLarge => Theme.of(this).textTheme.labelLarge!.copyWith(
        fontSize: Theme.of(this).textTheme.labelLarge!.fontSize!.sp,
        fontFamily: currentFontFamily,
      );

  TextStyle get labelMedium => Theme.of(this).textTheme.labelMedium!.copyWith(
        fontSize: Theme.of(this).textTheme.labelMedium!.fontSize!.sp,
        fontFamily: currentFontFamily,
      );

  TextStyle get labelSmall => Theme.of(this).textTheme.labelSmall!.copyWith(
        fontSize: Theme.of(this).textTheme.labelSmall!.fontSize!.sp,
        fontFamily: currentFontFamily,
      );
}
