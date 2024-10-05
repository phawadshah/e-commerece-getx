import 'package:flutter/material.dart';
import 'package:shop/app/utils/constants/colors.dart';

import '../../../common/styles/text_styles.dart';

class KTextTheme {
  KTextTheme._();

  static TextTheme light = TextTheme(
    displayLarge: KTextStyles.displayLarge.copyWith(color: KColors.black),
    displayMedium: KTextStyles.displayMedium.copyWith(color: KColors.black),
    displaySmall: KTextStyles.displaySmall.copyWith(color: KColors.black),
    headlineLarge: KTextStyles.headlineLarge.copyWith(color: KColors.black),
    headlineMedium: KTextStyles.headlineMedium.copyWith(color: KColors.black),
    headlineSmall: KTextStyles.headlineSmall.copyWith(color: KColors.black),
    titleLarge: KTextStyles.titleLarge.copyWith(color: KColors.black),
    titleMedium: KTextStyles.titleMedium.copyWith(color: KColors.black),
    titleSmall: KTextStyles.titleSmall.copyWith(color: KColors.black),
    bodyLarge: KTextStyles.bodyLarge.copyWith(color: KColors.black),
    bodyMedium: KTextStyles.bodyMedium.copyWith(color: KColors.black),
    bodySmall: KTextStyles.bodySmall.copyWith(color: KColors.black),
    labelLarge: KTextStyles.labelLarge.copyWith(color: KColors.black),
    labelMedium: KTextStyles.labelMedium.copyWith(color: KColors.black),
    labelSmall: KTextStyles.labelSmall.copyWith(color: KColors.black),
  );

  static TextTheme dark = TextTheme(
    displayLarge: KTextStyles.displayLarge.copyWith(color: KColors.white),
    displayMedium: KTextStyles.displayMedium.copyWith(color: KColors.white),
    displaySmall: KTextStyles.displaySmall.copyWith(color: KColors.white),
    headlineLarge: KTextStyles.headlineLarge.copyWith(color: KColors.white),
    headlineMedium: KTextStyles.headlineMedium.copyWith(color: KColors.white),
    headlineSmall: KTextStyles.headlineSmall.copyWith(color: KColors.white),
    titleLarge: KTextStyles.titleLarge.copyWith(color: KColors.white),
    titleMedium: KTextStyles.titleMedium.copyWith(color: KColors.white),
    titleSmall: KTextStyles.titleSmall.copyWith(color: KColors.white),
    bodyLarge: KTextStyles.bodyLarge.copyWith(color: KColors.white),
    bodyMedium: KTextStyles.bodyMedium.copyWith(color: KColors.white),
    bodySmall: KTextStyles.bodySmall.copyWith(color: KColors.white),
    labelLarge: KTextStyles.labelLarge.copyWith(color: KColors.white),
    labelMedium: KTextStyles.labelMedium.copyWith(color: KColors.white),
    labelSmall: KTextStyles.labelSmall.copyWith(color: KColors.white),
  );
}
