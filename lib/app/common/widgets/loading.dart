import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class KLoadingWidget extends StatelessWidget {
  const KLoadingWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SpinKitPulse(
        itemBuilder: (BuildContext context, int index) {
          return const DecoratedBox(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.blue,
            ),
          );
        },
      ),
    );
  }
}
