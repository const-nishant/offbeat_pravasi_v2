import 'package:flutter/material.dart';

class CommonLargebutton extends StatefulWidget {
  final String text;
  final VoidCallback? onPressed;
  const CommonLargebutton({
    super.key,
    required this.text,
    this.onPressed,
  });

  @override
  State<CommonLargebutton> createState() => _CommonLargebuttonState();
}

class _CommonLargebuttonState extends State<CommonLargebutton> {
  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: ElevatedButton(
        onPressed: widget.onPressed,
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0),
          ),
          elevation: 0,
          minimumSize:
              const Size(0, 50), // No fixed width, only height constraint
          backgroundColor: Theme.of(context)
                  .elevatedButtonTheme
                  .style
                  ?.backgroundColor
                  ?.resolve({}) ??
              const Color(0xFF8D4612), // Default fallback color
          foregroundColor: Theme.of(context)
                  .elevatedButtonTheme
                  .style
                  ?.foregroundColor
                  ?.resolve({}) ??
              Colors.white,
        ),
        child: Text(
          widget.text,
          style: TextStyle(
            color: Theme.of(context).colorScheme.inversePrimary,
            fontSize: 12,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
