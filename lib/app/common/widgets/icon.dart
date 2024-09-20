import 'package:flutter/material.dart';

class KIcon extends StatelessWidget {
  final Widget icon;
  final Widget? activeIcon;
  final bool active;

  const KIcon({
    super.key,
    required this.icon,
    this.activeIcon,
    required this.active,
  });

  @override
  Widget build(BuildContext context) {
    return active ? activeIcon ?? icon : icon;
  }
}
