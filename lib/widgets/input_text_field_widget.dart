import 'package:flutter/material.dart';

class InputTextFieldWidget extends StatelessWidget {
  TextEditingController? controller;
  String? hintText;
  Icon? icon;
  TextInputType? textInputType;

  InputTextFieldWidget({
    super.key,
    this.hintText,
    this.controller,
    this.icon,
    this.textInputType,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: (value) {
        controller!.text  =  value;
      },

      controller: controller,
      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        hintText: hintText,
        prefixIcon: icon,
      ),
    );
  }
}
