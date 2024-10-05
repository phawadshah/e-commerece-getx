import 'package:flutter/material.dart';

import '../../constants/colors.dart';

class KAppbarTheme {
  KAppbarTheme._();

  static AppBarTheme light = AppBarTheme(
    elevation: 0,
    centerTitle: true,
    color: KColors.white,
    backgroundColor: KColors.white,
    surfaceTintColor: KColors.transparent,
    iconTheme: const IconThemeData(color: KColors.darkGray),
  );
  static AppBarTheme dark = const AppBarTheme(
    elevation: 0,
    centerTitle: true,
  );
}
