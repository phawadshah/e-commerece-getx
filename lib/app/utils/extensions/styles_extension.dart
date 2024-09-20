import 'package:flutter/material.dart';

extension StylesExtension on BuildContext {
  TextStyle get labelSmall =>
      Theme.of(this).textTheme.labelSmall!.copyWith(fontSize: 8);
  TextStyle get labelLarge =>
      Theme.of(this).textTheme.labelLarge!.copyWith(fontSize: 12);
  TextStyle get bodySmall =>
      Theme.of(this).textTheme.bodySmall!.copyWith(fontSize: 10);
  TextStyle get bodyMedium =>
      Theme.of(this).textTheme.bodyMedium!.copyWith(fontSize: 12);
  TextStyle get bodyLarge =>
      Theme.of(this).textTheme.bodyLarge!.copyWith(fontSize: 14);
  TextStyle get label18400 =>
      Theme.of(this).textTheme.bodyMedium!.copyWith(fontSize: 16);
  TextStyle get label26700 =>
      Theme.of(this).textTheme.titleLarge!.copyWith(fontSize: 18);
}
