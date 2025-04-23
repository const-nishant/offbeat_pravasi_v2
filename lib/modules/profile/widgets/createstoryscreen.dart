import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:provider/provider.dart';

import '../../../helpers/helperservices.dart';
import '../../community/data/exports.dart';

class Createstoryscreen extends StatefulWidget {
  final File imageFile;
  const Createstoryscreen({super.key, required this.imageFile});

  @override
  State<Createstoryscreen> createState() => _CreatestoryscreenState();
}

class _CreatestoryscreenState extends State<Createstoryscreen> {
  @override
  void dispose() {
    widget.imageFile.delete();
    super.dispose();
  }

  final _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    final storyservice = Provider.of<Storyservices>(context, listen: false);
    Future<void> postStory() async {
      if (widget.imageFile.existsSync()) {
        final helperservice =
            Provider.of<Helperservices>(context, listen: false);
        final compressedImage =
            await helperservice.compressImage(widget.imageFile);

        if (compressedImage != null) {
          await storyservice.addStory(
              uid: _auth.currentUser!.uid,
              image: compressedImage,
              // ignore: use_build_context_synchronously
              context: context);
        }
        widget.imageFile.delete();
        // ignore: use_build_context_synchronously
        context.pop();
      }
    }

    return Consumer<Storyservices>(
      builder: (context, storyservice, child) {
        return storyservice.isLoading
            ? const Scaffold(
                body: Center(
                  child: CircularProgressIndicator(),
                ),
              )
            : Scaffold(
                appBar: AppBar(
                  elevation: 0,
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
                  actions: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: ElevatedButton(
                        onPressed: postStory,
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              Theme.of(context).colorScheme.onInverseSurface,
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
                  child: Stack(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: Image.file(widget.imageFile,
                            width: double.infinity,
                            height: 700,
                            fit: BoxFit.cover),
                      ),
                    ],
                  ),
                ),
              );
      },
    );
  }
}
