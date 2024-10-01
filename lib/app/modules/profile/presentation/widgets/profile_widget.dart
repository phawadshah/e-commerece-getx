import 'package:flutter/material.dart';

import 'package:shop/app/common/widgets/image.dart';
import 'package:shop/app/utils/helper.dart';

class ProfileWidget extends StatelessWidget {
  final String name;
  final String email;
  const ProfileWidget({
    super.key,
    this.name = "Unknown",
    this.email = "Unknown",
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const ProfileImage(
          src: 'https://i.pravatar.cc/300',
        ),
        addVerticleSpace(5),
        Text(
          name,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          email,
          style: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    );
  }
}

class ProfileImage extends StatelessWidget {
  final String src;
  const ProfileImage({
    super.key,
    required this.src,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.blue.shade200,
        ),
        shape: BoxShape.circle,
      ),
      child: CircleAvatar(
        radius: 55,
        backgroundColor: Colors.white,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(50),
          child: KImage(src: src),
        ),
      ),
    );
  }
}
