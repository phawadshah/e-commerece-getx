// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';

import '../../utils/constants/enums.dart';

class KButton extends StatelessWidget {
  const KButton({
    super.key,
    this.onTap,
    required this.title,
    this.state = ControllerState.IDLE,
  });

  final Function()? onTap;
  final String title;

  final ControllerState state;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: (60),
      child: ElevatedButton(
        onPressed: onTap,
        style: ButtonStyle(
          splashFactory: NoSplash.splashFactory,
          textStyle: const WidgetStatePropertyAll(TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          )),
          elevation: WidgetStateProperty.all(0),
          padding: WidgetStateProperty.all(const EdgeInsets.all(10)),
          overlayColor: WidgetStateProperty.all(Colors.transparent),
          side: WidgetStateProperty.all(BorderSide.none),
          foregroundColor: WidgetStateProperty.all(Colors.white),
          backgroundColor: WidgetStateProperty.resolveWith<Color?>((_) {
            return state == ControllerState.LOADING
                ? getButtonStateColor(state)
                : Colors.blue;
          }),
          shape: WidgetStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
        child: state == ControllerState.LOADING
            ? _buildLoader()
            : Text(
                title,
              ),
      ),
    );
  }

  SizedBox _buildLoader() {
    return const SizedBox(
      width: 24,
      height: 24,
      child: CircularProgressIndicator(
        strokeWidth: 4,
        color: Colors.white,
      ),
    );
  }
}

Color? getButtonStateColor(
  ControllerState? state,
) {
  switch (state) {
    case ControllerState.IDLE:
      return Colors.blue;
    case ControllerState.LOADING:
      return Colors.blue.shade400;
    default:
      return Colors.blue;
  }
}

class KOutlineButton extends StatelessWidget {
  final Function()? onTap;
  final String title;

  const KOutlineButton({
    super.key,
    this.onTap,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onTap,
      style: ButtonStyle(
        splashFactory: NoSplash.splashFactory,
        textStyle: const WidgetStatePropertyAll(TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
        )),
        elevation: WidgetStateProperty.all(0),
        padding: WidgetStateProperty.all(const EdgeInsets.all(10)),
        overlayColor: WidgetStateProperty.all(Colors.transparent),
        side: WidgetStateProperty.all(const BorderSide(
          color: Colors.blue,
        )),
        foregroundColor: WidgetStateProperty.all(Colors.blue),
        backgroundColor: WidgetStateProperty.all(Colors.white),
        shape: WidgetStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
      child: Text(title),
    );
  }
}
