import 'package:flutter/material.dart';

class CommonExitbutton extends StatefulWidget {
  final VoidCallback? onPressed;
  const CommonExitbutton({
    super.key,
    required this.onPressed,
  });

  @override
  State<CommonExitbutton> createState() => _CommonExitbuttonState();
}

class _CommonExitbuttonState extends State<CommonExitbutton> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(6.0),
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            color: Theme.of(context).colorScheme.onInverseSurface,
            width: 2,
          ),
        ),
        child: IconButton(
          onPressed: widget.onPressed,
          iconSize: 22,
          icon: Icon(
            Icons.chevron_left,
            color: Theme.of(context).colorScheme.primary,
          ),
          style: ButtonStyle(
            backgroundColor: WidgetStateProperty.all(Colors.transparent),
            shape: WidgetStateProperty.all(
              CircleBorder(),
            ),
          ),
        ),
      ),
    );
  }
}
