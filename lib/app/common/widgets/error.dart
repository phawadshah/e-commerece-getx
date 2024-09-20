import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop/app/common/widgets/button.dart';

import 'package:shop/app/utils/helper.dart';

class KErrorWidget extends StatelessWidget {
  const KErrorWidget({
    super.key,
    required this.error,
    this.onRetry,
    this.buttonTitle,
  });

  final String error;
  final String? buttonTitle;
  final Function()? onRetry;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: Get.height - kToolbarHeight - kBottomNavigationBarHeight,
      child: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                error,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 16,
                ),
              ),
              if (onRetry != null) ...[
                addVerticleSpace(10),
                Container(
                  height: 43,
                  constraints: BoxConstraints(
                    minWidth: Get.width * 0.3,
                  ),
                  child: KOutlineButton(
                    title: buttonTitle ?? "Retry",
                    onTap: onRetry,
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
