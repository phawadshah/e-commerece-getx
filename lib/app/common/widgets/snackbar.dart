// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop/app/utils/helper.dart';

class KSnackbar {
  static SnackbarController successSnackbar({
    required String title,
    Widget? prefixIcon,
    Widget? suffixIcon,
    void Function()? onSuffixTap,
  }) {
    Get.closeAllSnackbars();
    return Get.showSnackbar(
      GetSnackBar(
        backgroundColor: Colors.blue.shade400,
        snackPosition: SnackPosition.BOTTOM,
        snackStyle: SnackStyle.FLOATING,
        borderRadius: 4,
        duration: const Duration(seconds: 3),
        margin: const EdgeInsets.symmetric(horizontal: 16),
        messageText: SnackbarWidget(
          title: title,
          prefixIcon: Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Colors.green, width: 2),
            ),
            child: const Icon(
              Icons.check,
              color: Colors.green,
              size: 18,
            ),
          ),
          suffixIcon: suffixIcon,
          onSuffixTap: onSuffixTap,
        ),
      ),
    );
  }
}

class SnackbarWidget extends StatelessWidget {
  const SnackbarWidget({
    super.key,
    this.prefixIcon,
    this.suffixIcon,
    required this.title,
    this.onSuffixTap,
  });

  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final String title;
  final void Function()? onSuffixTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            if (prefixIcon != null) ...[
              prefixIcon!,
              addVerticleSpace(10),
            ],
            Expanded(
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
              ),
            ),
            // const Spacer(),
            if (suffixIcon != null)
              GestureDetector(
                onTap: onSuffixTap,
                child: suffixIcon,
              ),
          ],
        ),
      ],
    );
  }
}
