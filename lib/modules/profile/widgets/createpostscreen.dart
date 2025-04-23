import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:provider/provider.dart';

import '../../../helpers/helper_exports.dart';
import '../profile_exports.dart';

class Createpostscreen extends StatefulWidget {
  final File imageFile;
  const Createpostscreen({super.key, required this.imageFile});

  @override
  State<Createpostscreen> createState() => _CreatepostscreenState();
}

class _CreatepostscreenState extends State<Createpostscreen> {
  final TextEditingController _captionController = TextEditingController();

  @override
  void dispose() {
    _captionController.dispose();
    widget.imageFile.delete();
    super.dispose();
  }

  void _post() async {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final helpersevices = Provider.of<Helperservices>(context, listen: false);
    if (_captionController.text.isNotEmpty) {
      await context.read<ProfileService>().addpost(
            // ignore: use_build_context_synchronously
            context,
            auth.currentUser!.uid,
            _captionController.text,
            await helpersevices.compressImage(widget.imageFile) ??
                widget.imageFile,
          );
      _captionController.clear();
      // ignore: use_build_context_synchronously
      context.pop();
    }
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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.file(widget.imageFile,
                    width: double.infinity, height: 450, fit: BoxFit.cover),
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: _captionController,
                maxLines: 3,
                decoration: InputDecoration(
                  hintText: "Write a caption...",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12)),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a caption';
                  }
                  return null;
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
