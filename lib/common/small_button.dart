import 'package:flutter/material.dart';

class SmallButton extends StatefulWidget {
  final String title;
  final bool isback;
  final VoidCallback? onPressed;
  const SmallButton({
    super.key,
    required this.isback,
    required this.title,
    this.onPressed,
  });

  @override
  State<SmallButton> createState() => _SmallButtonState();
}

class _SmallButtonState extends State<SmallButton> {
  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
        onPressed: widget.onPressed,
        style: OutlinedButton.styleFrom(
          fixedSize: const Size(154, 40),
          backgroundColor: widget.isback
              ? Colors.transparent
              : Theme.of(context).colorScheme.secondary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          side: BorderSide(
            color: Theme.of(context).colorScheme.secondary,
          ),
        ),
        child: Text(
          widget.title,
          style: TextStyle(
              color: widget.isback ? Colors.white : Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.w600),
        ));
  }
}
