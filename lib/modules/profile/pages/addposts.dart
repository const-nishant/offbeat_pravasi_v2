import 'dart:io';

import 'package:appwrite/appwrite.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:offbeat_pravasi_v2/modules/profile/widgets/createpostscreen.dart';

import '../../../main.dart';

class AddPost extends StatefulWidget {
  const AddPost({super.key});

  @override
  State<AddPost> createState() => _AddPostState();
}

class _AddPostState extends State<AddPost> {
  CameraController? _cameraController;
  List<CameraDescription>? cameras;
  final picker = ImagePicker();
  int _selectedCameraIndex = 0;

  @override
  void initState() {
    super.initState();
    _initCamera();
  }

  Future<void> _initCamera() async {
    cameras = await availableCameras();
    if (cameras!.isNotEmpty) {
      _startCamera(_selectedCameraIndex);
    }
  }

  void _startCamera(int cameraIndex) async {
    _cameraController =
        CameraController(cameras![cameraIndex], ResolutionPreset.high);
    await _cameraController!.initialize();
    if (mounted) setState(() {});
  }

  void _switchCamera() {
    if (cameras == null || cameras!.isEmpty) return;
    _selectedCameraIndex =
        (_selectedCameraIndex + 1) % cameras!.length; // toggle camera
    _cameraController?.dispose();
    _startCamera(_selectedCameraIndex);
  }

  final storage = Storage(client);

  Future<void> _capturePost() async {
    if (_cameraController != null && _cameraController!.value.isInitialized) {
      final image = await _cameraController!.takePicture();
      debugPrint('Captured Post: ${image.path}');

      // Navigate to CreatePostScreen with the captured image
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Createpostscreen(imageFile: File(image.path)),
        ),
      );
    }
  }

  Future<void> _pickFromGallery() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      print('Gallery Post: ${pickedFile.path}');
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) =>
              Createpostscreen(imageFile: File(pickedFile.path)),
        ),
      );
    } else {
      print('No image selected.');
    }
  }

  @override
  void dispose() {
    _cameraController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _cameraController == null || !_cameraController!.value.isInitialized
          ? const Center(child: CircularProgressIndicator())
          : Stack(
              children: [
                // Fullscreen Camera Preview
                Positioned.fill(child: CameraPreview(_cameraController!)),

                // Close Button - Top Left
                Positioned(
                  top: 50,
                  left: 20,
                  child: GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: const Icon(LucideIcons.x,
                        color: Colors.white, size: 30),
                  ),
                ),

                // Switch Camera Button - Top Right
                Positioned(
                  top: 50,
                  right: 20,
                  child: GestureDetector(
                    onTap: _switchCamera,
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.black,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        LucideIcons.refreshCw,
                        color: Colors.white,
                        size: 28,
                      ),
                    ),
                  ),
                ),

                // Capture Button
                Positioned(
                  bottom: 110,
                  left: MediaQuery.of(context).size.width / 2 - 35,
                  child: GestureDetector(
                    onTap: _capturePost,
                    child: Container(
                      height: 70,
                      width: 70,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Theme.of(context).colorScheme.secondary,
                          width: 4,
                        ),
                        color: Colors.white,
                      ),
                      child: const Icon(LucideIcons.camera,
                          color: Colors.black, size: 32),
                    ),
                  ),
                ),

                // Gallery Picker - Bottom Left
                Positioned(
                  bottom: 50,
                  left: 20,
                  child: GestureDetector(
                    onTap: _pickFromGallery,
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.onInverseSurface,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Icon(LucideIcons.image,
                          size: 30, color: Colors.black),
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}
