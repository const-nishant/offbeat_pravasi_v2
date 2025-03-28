import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../../../profile/data/exports.dart';

class Communityservices extends ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  bool _isLoading = true;
  List<Post> _posts = [];

  bool get isLoading => _isLoading;
  List<Post> get posts => _posts;

  Communityservices() {
    fetchPosts();
  }

  // Fetch posts
  Future<void> fetchPosts() async {
    try {
      _isLoading = true;
      notifyListeners();

      QuerySnapshot snapshot = await _firestore
          .collection('posts')
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

  // Toggle likes
  Future<void> toggleLike(String postId, String userId) async {
    try {
      DocumentReference postRef = _firestore.collection('posts').doc(postId);
      DocumentSnapshot postSnapshot = await postRef.get();

      if (postSnapshot.exists) {
        List<dynamic> likes = postSnapshot['likes'] ?? [];

        await postRef.update({
          'likes': likes.contains(userId)
              ? FieldValue.arrayRemove([userId])
              : FieldValue.arrayUnion([userId]),
        });

        // Update local state
        int index = _posts.indexWhere((post) => post.postId == postId);
        if (index != -1) {
          if (likes.contains(userId)) {
            _posts[index].likes.remove(userId);
          } else {
            _posts[index].likes.add(userId);
          }
          notifyListeners();
        }
      }
    } catch (e) {
      debugPrint("Error toggling like: $e");
    }
  }


}
