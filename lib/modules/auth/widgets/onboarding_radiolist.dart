// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class OnboardingRadiolist extends StatefulWidget {
  final String option;
  final String optionValue;
  final String groupValue;
  final ValueChanged<String?> onChanged;

  const OnboardingRadiolist({
    super.key,
    required this.option,
    required this.optionValue,
    required this.groupValue,
    required this.onChanged,
  });

  @override
  State<OnboardingRadiolist> createState() => _OnboardingRadioslistState();
}

class _OnboardingRadioslistState extends State<OnboardingRadiolist> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 334,
      height: 54,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Theme.of(context).colorScheme.primary,
        ),
      ),
      child: RadioListTile<String>(
        title: Text(widget.option),
        value: widget.optionValue,
        activeColor: Theme.of(context).colorScheme.secondary,
        groupValue: widget.groupValue,
        onChanged: widget.onChanged,
      ),
    );
  }
}
