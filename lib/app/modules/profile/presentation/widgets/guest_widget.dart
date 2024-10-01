import 'package:flutter/material.dart';
import 'package:shop/app/common/widgets/button.dart';
import 'package:shop/app/utils/helper.dart';

class GuestWidget extends StatelessWidget {
  final VoidCallback? ontap;
  const GuestWidget({
    super.key,
    this.ontap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
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
              child: Icon(
                Icons.person,
                size: 80,
                color: Colors.blue.shade400,
              ),
            ),
          ),
        ),
        addVerticleSpace(15),
        SizedBox(
          width: 120,
          child: KOutlineButton(
            title: "Login",
            onTap: ontap,
          ),
        ),
      ],
    );
  }
}
