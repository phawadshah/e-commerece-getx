import 'package:flutter/cupertino.dart';

class TextWidget extends StatelessWidget {
  const TextWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        Align(
          alignment: Alignment.center,
          child: Text("Version V 0.1",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Color(0xff848484),
                fontSize: 12,
                fontWeight: FontWeight.w400,
              )),
        ),
        Align(
          alignment: Alignment.center,
          child: Text("All Rights Reseverd 2024 Shop.ae ",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Color(0xff848484),
                fontSize: 12,
                fontWeight: FontWeight.w400,
              )),
        ),
      ],
    );
  }
}
