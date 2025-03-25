import 'package:flutter/material.dart';

class UploadPhotoField extends StatelessWidget {
  final void Function() onPressed;
  const UploadPhotoField({
    super.key,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.0),
        color: Theme.of(context).colorScheme.onInverseSurface,
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              readOnly: true,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: 'Upload photo',
                hintStyle: TextStyle(
                  color: Theme.of(context).colorScheme.primary,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          IconButton(
            icon: Icon(
              Icons.camera_alt_outlined,
              size: 28,
              color: Theme.of(context).colorScheme.primary,
            ),
            onPressed: onPressed,
          ),
        ],
      ),
    );
  }
}
