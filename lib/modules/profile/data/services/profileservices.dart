import 'dart:io';

import 'package:appwrite/appwrite.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:offbeat_pravasi_v2/config/configs.dart';
import 'package:offbeat_pravasi_v2/modules/profile/data/models/post.dart';
import '../../../../main.dart';
import '../../../auth/auth_exports.dart';

class ProfileService extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final storage = Storage(client);
  BuildContext? _dialogContext;

  UserData? _userData;
  bool _isLoading = true;
  List<Post> _posts = [];

  bool get isLoading => _isLoading;
  UserData? get userData => _userData;
  List<Post> get userPosts => _posts;

  ProfileService() {
    fetchUserData();
    fetchPosts();
    _listenToUserUpdates();
  }

  void _listenToUserUpdates() {
    if (_auth.currentUser == null) return;

    _firestore
        .collection('users')
        .doc(_auth.currentUser!.uid)
        .snapshots()
        .listen((snapshot) {
      if (snapshot.exists) {
        _userData =
            snapshot.data() != null ? UserData.fromDocument(snapshot) : null;
        notifyListeners(); // 🔄 Trigger UI update
      }
    });
  }

//send organizer requests
  Future<void> sendOrganizerRequest({
    required String email,
    required String message,
    required BuildContext context,
  }) async {
    _showLoader(context);
    try {
      final requestData = {
        'senderEmail': email,
        'message': message,
        'status': 'pending', // Can be 'pending', 'approved', or 'rejected'
        'timestamp': FieldValue.serverTimestamp(),
        'userId': _auth.currentUser!.uid,
      };

      await _firestore
          .collection('organizer_requests')
          .doc(_auth.currentUser!.uid)
          .set(requestData);

      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Request sent successfully!'),
        ),
      );
    } catch (e) {
      if (context.mounted) {
        _showError(context, e.toString());
      }
    } finally {
      if (_dialogContext != null && _dialogContext!.mounted) {
        Navigator.pop(_dialogContext!); // Close the loader
        _dialogContext = null; // Reset after closing
      }
    }
  }

  Future<void> fetchUserData() async {
    try {
      final user = _auth.currentUser;
      if (user == null) return;

      DocumentSnapshot doc = await _firestore
          .collection('users')
          .doc(_auth.currentUser!.uid)
          .get();

      if (doc.exists) {
        _userData = UserData.fromDocument(doc);
      }

      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      notifyListeners();
      debugPrint("Error fetching user data: $e");
    }
  }

  Future<void> addpost(
    BuildContext context,
    String userId,
    String caption,
    File image,
  ) async {
    _showLoader(context);
    try {
      String fileId = DateTime.now().millisecondsSinceEpoch.toString();
      await storage.createFile(
        bucketId: Configs.appWriteUserPostsStorageBucketId,
        fileId: fileId,
        file: InputFile.fromPath(path: image.path),
      );

      String downloadUrl =
          'https://cloud.appwrite.io/v1/storage/buckets/${Configs.appWriteUserPostsStorageBucketId}/files/$fileId/view?project=${Configs.appWriteProjectId}&mode=admin';

      final userdoc = await _firestore.collection('users').doc(userId).get();

      if (userdoc.exists) {
        _userData = UserData.fromDocument(userdoc);
      }

      Post post = Post(
        caption: caption,
        imageUrl: downloadUrl,
        uploadTimestamp: Timestamp.now(),
        userId: userId,
        postId: fileId,
        comments: 0,
        likes: [],
        username: _userData?.name ?? 'default_username',
        userImageUrl: _userData?.profileImage ?? '',
        location: _userData?.location ?? '',
      );

      await _firestore.collection('posts').doc(fileId).set(
            post.toMap(),
          );

      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Post added successfully!'),
        ),
      );

      notifyListeners();
    } catch (e) {
      if (context.mounted) {
        _showError(context, e.toString());
      }
    } finally {
      if (_dialogContext != null && _dialogContext!.mounted) {
        Navigator.pop(_dialogContext!); // Close the loader
        _dialogContext = null; // Reset after closing
      }
    }
  }

//show user posts
  Future<void> fetchPosts() async {
    try {
      _isLoading = true;
      notifyListeners();

      QuerySnapshot snapshot = await _firestore
          .collection('posts')
          .where('userId', isEqualTo: _auth.currentUser!.uid)
          .orderBy('uploadTimestamp', descending: true)
          .get();

      _posts = snapshot.docs.map((doc) => Post.fromDocument(doc)).toList();
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      notifyListeners();
      debugPrint('Error fetching posts: $e');
    }
  }

//update user data
  Future<void> updateUserData({
    File? profileImage,
    File? bannerImage,
    required String location,
    required String name,
    required String username,
    required String phone,
    required BuildContext context,
  }) async {
    _showLoader(context);
    try {
      if (profileImage != null && bannerImage != null) {
        //update userprofile image
        await storage.deleteFile(
          bucketId: Configs.appWriteUserProfileStorageBucketId,
          fileId: _auth.currentUser!.uid,
        );

        await storage.createFile(
          bucketId: Configs.appWriteUserProfileStorageBucketId,
          fileId: _auth.currentUser!.uid,
          file: InputFile.fromPath(path: profileImage.path),
        );
        String profileImageUrl =
            'https://cloud.appwrite.io/v1/storage/buckets/${Configs.appWriteUserProfileStorageBucketId}/files/${_auth.currentUser!.uid}/view?project=${Configs.appWriteProjectId}&mode=admin';

        //update user banner image
        if (userData!.bannerImage != '') {
          await storage.deleteFile(
            bucketId: Configs.appWriteUserBannerStorageBucketId,
            fileId: _auth.currentUser!.uid,
          );
        }

        await storage.createFile(
          bucketId: Configs.appWriteUserBannerStorageBucketId,
          fileId: _auth.currentUser!.uid,
          file: InputFile.fromPath(path: bannerImage.path),
        );
        String bannerImageUrl =
            'https://cloud.appwrite.io/v1/storage/buckets/${Configs.appWriteUserBannerStorageBucketId}/files/${_auth.currentUser!.uid}/view?project=${Configs.appWriteProjectId}&mode=admin';

        UserData updateduserdata = UserData(
          name: name,
          username: username,
          location: location,
          phone: phone,
          profileImage: profileImageUrl,
          authProvider: userData!.authProvider,
          email: userData!.email,
          dob: userData!.dob,
          gender: userData!.gender,
          isSignup: userData!.isSignup,
          bannerImage: bannerImageUrl,
          uid: userData!.uid,
        );

        await _firestore
            .collection('users')
            .doc(_auth.currentUser!.uid)
            .update(updateduserdata.toMap());
      }
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          behavior: SnackBarBehavior.floating,
          content: Text('Profile updated successfully!'),
        ),
      );
    } catch (e) {
      if (context.mounted) {
        _showError(context, e.toString());
      }
    } finally {
      if (_dialogContext != null && _dialogContext!.mounted) {
        Navigator.pop(_dialogContext!); // Close the loader
        _dialogContext = null; // Reset after closing
      }
    }
  }

  // Loader
  void _showLoader(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (dialogContext) {
        _dialogContext = dialogContext; // Store context of dialog
        return const Center(child: CircularProgressIndicator());
      },
    );
  }

  // Error function
  void _showError(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }
}
