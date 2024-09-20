import 'package:flutter/material.dart';
import 'package:shop/app/common/widgets/bottom.dart';
import 'package:shop/app/common/widgets/button.dart';
import 'package:shop/app/utils/constants/enums.dart';
import 'package:shop/app/utils/helper.dart';

class BottomWidget extends StatelessWidget {
  const BottomWidget({
    super.key,
    required this.total,
    this.onCheckOutTap,
    this.state = ControllerState.IDLE,
  });

  final double total;
  final Function()? onCheckOutTap;
  final ControllerState state;

  @override
  Widget build(BuildContext context) {
    return KBottomWidget(
      child: Row(
        children: [
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Total',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                addVerticleSpace(4),
                FittedBox(
                  child: RichText(
                    text: TextSpan(
                      children: [
                        const TextSpan(
                          text: 'AED ',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.normal,
                            color: Colors.black,
                          ),
                        ),
                        TextSpan(
                          text: '${total.toStringAsFixed(2)} ',
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          addHorizontalSpace(20),
          Expanded(
            flex: 3,
            child: SizedBox(
              height: 50,
              child: KButton(
                title: 'Checkout',
                state: state,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
