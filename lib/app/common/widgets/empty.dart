import 'package:flutter/material.dart';

class KEmptyWidget extends StatelessWidget {
  final String? title;

  const KEmptyWidget({
    super.key,
    this.title,
  });

  @override
  Widget build(BuildContext context) {
    return title == null
        ? const SizedBox.shrink()
        : SizedBox(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(
                  title!,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          );
  }
}
