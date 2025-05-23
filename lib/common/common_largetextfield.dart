import 'package:flutter/material.dart';

class CommonLargeTextfield extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;
  final void Function()? onTap;
  final bool readOnly;
  final bool obscureText;
  final int? maxLength;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final FocusNode? focusNode;

  const CommonLargeTextfield({
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
    this.focusNode,
    this.prefixIcon,
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
      maxLines: null, // Allows dynamic height without fixed space
      minLines: 5, // Initial height, but it will expand
      expands: false, // Prevents unnecessary stretching
      style: TextStyle(
        color: Theme.of(context).colorScheme.primary,
        fontSize: 18,
        fontWeight: FontWeight.w400,
      ),
      readOnly: readOnly,
      decoration: InputDecoration(
        prefixIcon: prefixIcon,
        prefixIconColor: Theme.of(context).colorScheme.primary,
        suffixIcon: suffixIcon,
        suffixIconColor: Colors.black,
        counterText: "",
        enabledBorder: OutlineInputBorder(
          borderRadius: const BorderRadius.all(Radius.circular(20)),
          borderSide: BorderSide(
              color: Theme.of(context).colorScheme.primary, width: 1.5),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: const BorderRadius.all(Radius.circular(20)),
          borderSide: BorderSide(color: Theme.of(context).colorScheme.primary),
        ),
        hintText: hintText,
        hintStyle: TextStyle(
          color: Theme.of(context).colorScheme.tertiary,
          fontSize: 18,
          fontWeight: FontWeight.w400,
        ),
        fillColor: Colors.transparent,
        filled: true,
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
        contentPadding: const EdgeInsets.only(
          top: 16.0, // Moves hint text up
          left: 20.0,
          right: 20.0,
        ),
        alignLabelWithHint: true,
        isDense: true,
      ),
    );
  }
}
