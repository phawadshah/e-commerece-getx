import 'package:flutter/material.dart';
import 'package:shop/app/common/widgets/icon.dart';
import 'package:shop/app/utils/helper.dart';

class NavBarItem extends StatelessWidget {
  const NavBarItem({
    super.key,
    required this.icon,
    this.activeIcon,
    this.active = false,
    required this.label,
    this.onTap,
  });

  final Widget icon;
  final Widget? activeIcon;
  final bool active;
  final String label;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: FittedBox(
        child: SizedBox(
          width: (70),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              KIcon(
                icon: icon,
                activeIcon: activeIcon,
                active: active,
              ),
              addVerticleSpace(2),
              Text(
                label,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: active ? FontWeight.w600 : FontWeight.w400,
                  color: active ? Colors.blue : Colors.black38,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
