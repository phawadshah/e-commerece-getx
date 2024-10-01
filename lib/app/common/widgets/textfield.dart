import 'package:flutter/material.dart';
import 'package:shop/app/utils/helper.dart';

class KTextField extends StatelessWidget {
  final String label;
  final String? errorMessage;
  final FocusNode? focusNode;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final AutovalidateMode? autovalidateMode;

  const KTextField({
    super.key,
    required this.label,
    this.errorMessage,
    this.controller,
    this.focusNode,
    this.validator,
    this.autovalidateMode,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFormField(
          controller: controller,
          focusNode: focusNode,
          validator: validator,
          autovalidateMode: autovalidateMode,
          cursorColor: Colors.blue,
          cursorErrorColor: Colors.red,
          cursorHeight: 20,
          decoration: _buildDecoration(errorMessage),
        ),
        if (errorMessage != null) ...[
          addVerticleSpace(5),
          Padding(
            padding: const EdgeInsetsDirectional.only(start: 4.0),
            child: Text(
              errorMessage!,
              style: const TextStyle(
                color: Colors.red,
                fontSize: 12,
              ),
            ),
          )
        ],
      ],
    );
  }

  InputDecoration _buildDecoration(String? error) {
    return InputDecoration(
      labelText: label,
      labelStyle: const TextStyle(color: Colors.black),
      border: OutlineInputBorder(
        borderSide: BorderSide(
          color: error != null ? Colors.red : Colors.black26,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: error != null ? Colors.red : Colors.blue,
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: error != null ? Colors.red : Colors.black26,
        ),
      ),
    );
  }
}

class KPasswordField extends StatefulWidget {
  final String label;
  final String? errorMessage;
  final FocusNode? focusNode;
  final TextEditingController? controller;
  final String? Function(String?)? validator;

  const KPasswordField({
    super.key,
    required this.label,
    this.errorMessage,
    this.controller,
    this.focusNode,
    this.validator,
  });

  @override
  State<KPasswordField> createState() => _KPasswordFieldState();
}

class _KPasswordFieldState extends State<KPasswordField> {
  bool obscureText = true;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFormField(
          controller: widget.controller,
          focusNode: widget.focusNode,
          validator: widget.validator,
          obscureText: obscureText,
          cursorColor: Colors.blue,
          cursorErrorColor: Colors.red,
          cursorHeight: 20,
          decoration: _buildDecoration(widget.errorMessage),
        ),
        if (widget.errorMessage != null) ...[
          addVerticleSpace(5),
          Padding(
            padding: const EdgeInsetsDirectional.only(start: 4.0),
            child: Text(
              widget.errorMessage!,
              style: const TextStyle(
                color: Colors.red,
                fontSize: 12,
              ),
            ),
          )
        ],
      ],
    );
  }

  InputDecoration _buildDecoration(String? error) {
    return InputDecoration(
      labelText: widget.label,
      labelStyle: const TextStyle(color: Colors.black),
      suffixIcon: IconButton(
        onPressed: () {
          obscureText = !obscureText;
          setState(() {});
        },
        icon: Icon(
          obscureText ? Icons.visibility_off : Icons.visibility,
          size: 20,
          color: Colors.grey,
        ),
      ),
      border: OutlineInputBorder(
        borderSide: BorderSide(
          color: error != null ? Colors.red : Colors.black26,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: error != null ? Colors.red : Colors.blue,
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: error != null ? Colors.red : Colors.black26,
        ),
      ),
    );
  }
}
