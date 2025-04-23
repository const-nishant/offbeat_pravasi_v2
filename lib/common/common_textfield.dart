// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class CommonTextfield extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;
  final void Function()? onTap;
  final bool readOnly;
  final bool obscureText;
  final int? maxLength;
  final Widget? suffixIcon;
  final void Function(String)? onChanged;
  final Widget? prefixIcon;
  final FocusNode? focusNode;
  const CommonTextfield({
    super.key,
    required this.hintText,
    required this.controller,
    this.keyboardType,
    this.validator,
    this.onTap,
    required this.readOnly,
    required this.obscureText,
    this.maxLength,
    this.suffixIcon,
    this.onChanged,
    this.prefixIcon,
    this.focusNode,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      focusNode: focusNode,
      maxLength: maxLength,
      obscureText: obscureText,
      onTap: onTap,
      controller: controller,
      keyboardType: keyboardType,
      validator: validator,
      style: TextStyle(
        color: Theme.of(context).colorScheme.primary,
        fontSize: 16,
        fontWeight: FontWeight.w400,
      ),
      onChanged: onChanged,
      readOnly: readOnly,
      decoration: InputDecoration(
        prefixIcon: prefixIcon,
        prefixIconColor: Theme.of(context).colorScheme.primary,
        suffixIcon: suffixIcon,
        suffixIconColor: Colors.black,
        counterText: "",
        enabledBorder: OutlineInputBorder(
          borderRadius: const BorderRadius.all(Radius.circular(16)),
          borderSide: BorderSide(
              color: Theme.of(context).colorScheme.primary, width: 1.5),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: const BorderRadius.all(Radius.circular(12)),
          borderSide: BorderSide(color: Theme.of(context).colorScheme.primary),
        ),
        hintText: hintText,
        hintStyle: TextStyle(
          color: Theme.of(context).colorScheme.tertiary,
          fontSize: 16,
          fontWeight: FontWeight.w400,
        ),
        fillColor: Colors.transparent,
        filled: true,
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(12)),
        ),
        contentPadding: const EdgeInsets.symmetric(
          vertical: 16.0,
          horizontal: 10.0,
        ),
      ),
    );
  }
}
