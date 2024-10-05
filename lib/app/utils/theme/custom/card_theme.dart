import 'package:flutter/material.dart';

import '../../constants/colors.dart';

class KCardTheme {
  KCardTheme._();

  static CardTheme light = const CardTheme(
    elevation: 1,
    color: KColors.white,
    surfaceTintColor: Colors.transparent,
  );
  static CardTheme dark = const CardTheme();
}
