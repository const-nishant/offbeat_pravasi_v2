import 'dart:io';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class Createpostscreen extends StatefulWidget {
  final File imageFile;
  const Createpostscreen({super.key, required this.imageFile});

  @override
  State<Createpostscreen> createState() => _CreatepostscreenState();
}

class _CreatepostscreenState extends State<Createpostscreen> {
  final TextEditingController _captionController = TextEditingController();

  void _post() {
    // Handle the post logic here
    // ignore: avoid_print
    print("Posted with caption: ${_captionController.text}");
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Create Post',
          style: TextStyle(
            color: Colors.black,
            fontSize: 22,
            fontWeight: FontWeight.w600,
          ),
        ),
        leading: IconButton(
          style: ButtonStyle(
            side: WidgetStateProperty.all(
              BorderSide(
                color: Theme.of(context).colorScheme.onInverseSurface,
                width: 2,
              ),
            ),
            iconColor: WidgetStateProperty.all(
              Theme.of(context).colorScheme.inversePrimary,
            ),
          ),
          icon: Icon(
            LucideIcons.chevronLeft,
            size: 20,
            color: Colors.black,
          ),
          onPressed: () {
            context.pop();
          },
        ),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: ElevatedButton(
              onPressed: () {
                _post();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).colorScheme.onInverseSurface,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 0,
              ),
              child: const Text(
                "Post",
                style: TextStyle(color: Colors.black),
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.file(widget.imageFile,
                  width: double.infinity, height: 450, fit: BoxFit.cover),
            ),
            SizedBox(height: 20),
            TextField(
              controller: _captionController,
              maxLines: 3,
              decoration: InputDecoration(
                hintText: "Write a caption...",
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
