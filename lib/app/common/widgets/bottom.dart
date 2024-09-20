import 'package:flutter/material.dart';

class KBottomWidget extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry padding;

  const KBottomWidget({
    super.key,
    required this.child,
  }) : padding = const EdgeInsets.symmetric(horizontal: 16.0, vertical: 5);

  const KBottomWidget.noNavBar({
    super.key,
    required this.child,
  }) : padding = const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          child,
        ],
      ),
    );
  }
}
