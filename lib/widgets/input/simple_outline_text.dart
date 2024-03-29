import 'package:flutter/material.dart';
import 'package:whatado/constants.dart';

class SimpleOutlinedTextField extends StatelessWidget {
  final TextEditingController controller;
  final String? hintText;
  final Widget? suffixIcon;
  SimpleOutlinedTextField({required this.controller, this.hintText, this.suffixIcon});
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
          suffixIcon: suffixIcon,
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppRadii.button),
              borderSide: BorderSide(width: 2.0, color: AppColors.unfocused)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppRadii.button),
              borderSide: BorderSide(width: 2.0, color: AppColors.primary)),
          disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppRadii.button),
              borderSide: BorderSide(width: 2.0)),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppRadii.button),
              borderSide: BorderSide(width: 2.0)),
          hintText: hintText),
      maxLines: null,
    );
  }
}
