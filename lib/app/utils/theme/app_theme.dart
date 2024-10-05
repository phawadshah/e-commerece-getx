import 'package:flutter/material.dart';
import 'package:shop/app/utils/theme/custom/text_theme.dart';

import '../constants/colors.dart';
import 'custom/appbar_theme.dart';
import 'custom/card_theme.dart';

class KAppTheme {
  KAppTheme._();

  static ThemeData light = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    primaryColor: KColors.primary,
    scaffoldBackgroundColor: KColors.white,
    appBarTheme: KAppbarTheme.light,
    cardTheme: KCardTheme.light,
    bottomSheetTheme:
        const BottomSheetThemeData(backgroundColor: KColors.white),
    textTheme: KTextTheme.light,
  );

  static ThemeData dark = ThemeData.dark(useMaterial3: true).copyWith(
    primaryColor: KColors.white,
    scaffoldBackgroundColor: KColors.white,
    appBarTheme: KAppbarTheme.dark,
    cardTheme: KCardTheme.dark,
    bottomSheetTheme:
        const BottomSheetThemeData(backgroundColor: KColors.white),
    textTheme: KTextTheme.dark,
  );
}
