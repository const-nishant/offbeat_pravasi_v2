import 'package:flutter/material.dart';
import 'package:dropdown_textfield/dropdown_textfield.dart';

class CustomDropdown extends StatelessWidget {
  final String labelText;
  final SingleValueDropDownController controller;
  final List<DropDownValueModel> dropDownList;
  final String? Function(DropDownValueModel?)? validator;

  const CustomDropdown({
    super.key,
    required this.labelText,
    required this.controller,
    required this.dropDownList,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          labelText,
          style: TextStyle(
            color: Theme.of(context).colorScheme.primary,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 6.0),
        DropdownButtonFormField<DropDownValueModel>(
          value: controller.dropDownValue,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          ),
          items: dropDownList.map((DropDownValueModel item) {
            return DropdownMenuItem<DropDownValueModel>(
              value: item,
              child: Text(item.name),
            );
          }).toList(),
          onChanged: (val) {
            controller.dropDownValue = val;
          },
          validator: validator,
        ),
      ],
    );
  }
}
