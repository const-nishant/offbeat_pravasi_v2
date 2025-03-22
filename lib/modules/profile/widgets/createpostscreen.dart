import 'dart:io';

import 'package:flutter/material.dart';

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
    print("Posted with caption: ${_captionController.text}");
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(color: Colors.black),
        title: Text("Create Post", style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
        elevation: 1,
        actions: [
          TextButton(
            onPressed: _post,
            child: Text(
              "Post",
              style: TextStyle(
                color: Theme.of(context).colorScheme.secondary,
                fontSize: 16,
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.file(widget.imageFile,
                  width: double.infinity, height: 250, fit: BoxFit.cover),
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
