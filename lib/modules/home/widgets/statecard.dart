import 'package:flutter/material.dart';

class Statecard extends StatelessWidget {
  final String state;
  final bool isSelected;
  final VoidCallback? onPressed;

  const Statecard(
      {super.key,
      required this.state,
      required this.isSelected,
      this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 6.0),
      child: TextButton(
        onPressed: onPressed,
        style: TextButton.styleFrom(
          padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          backgroundColor: Theme.of(context).colorScheme.secondary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
            side: BorderSide(
              color: isSelected ? Colors.black : Colors.transparent,
              width: 2.0,
            ),
          ),
        ),
        child: FittedBox(
          fit: BoxFit.scaleDown,
          child: Text(
            state,
            style: TextStyle(
              color: Theme.of(context).colorScheme.inversePrimary,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}
