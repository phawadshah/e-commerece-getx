import 'package:flutter/material.dart';

import 'package:shop/app/utils/helper.dart';

class ProfileRow extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback? onTap;
  const ProfileRow({
    super.key,
    required this.title,
    required this.icon,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        children: [
          Icon(
            icon,
            color: Colors.grey.shade700,
          ),
          addHorizontalSpace(10),
          Text(
            title,
            style: const TextStyle(
              fontSize: 18,
            ),
          ),
          const Spacer(),
          const Icon(Icons.chevron_right)
        ],
      ),
    );
  }
}
