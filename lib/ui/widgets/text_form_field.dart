import 'package:firebase_demo/core/constants/color_consant.dart';
import 'package:flutter/material.dart';

class TextFormFieldWidget extends StatelessWidget {
  const TextFormFieldWidget(
      {super.key,
      required this.labelText,
      required this.controller,
      required this.obscureText,
      required this.validator});
  final String labelText;
  final TextEditingController controller;
  final bool obscureText;
  final String? Function(dynamic)? validator;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: TextFormField(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        controller: controller,
        obscuringCharacter: "*",
        obscureText: obscureText,
        validator: validator,
        decoration: InputDecoration(
          focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: ColorConstants.black, width: 2)),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(
                color: ColorConstants.black,
              )),
          labelText: labelText,
        ),
      ),
    );
  }
}
