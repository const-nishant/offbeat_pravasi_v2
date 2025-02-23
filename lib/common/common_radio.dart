import 'package:flutter/material.dart';

class CommonRadio extends StatelessWidget {
  final String value;
  final String groupValue;
  final ValueChanged<String?> onChanged;
  const CommonRadio(
      {super.key,
      required this.value,
      required this.groupValue,
      required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Radio<String>(
      value: value,
      groupValue: groupValue,
      onChanged: onChanged,
      activeColor: Theme.of(context).colorScheme.secondary,
    );
  }
}
