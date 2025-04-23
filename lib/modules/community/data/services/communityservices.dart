import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:offbeat_pravasi_v2/modules/community/community_exports.dart';
import '../../../profile/data/exports.dart';

class Communityservices extends ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  bool _isLoading = true;
  List<Post> _posts = [];
  List<Comment> _comments = [];

  bool get isLoading => _isLoading;
  List<Post> get posts => _posts;
  List<Comment> get comments => _comments;

  Communityservices() {
    fetchPosts();
  }

  // Fetch comments for a specific post
  Future<void> fetchComments(String postId) async {
    _isLoading = true;
    try {
      _firestore
          .collection('posts')
          .doc(postId)
          .collection('comments')
          .orderBy('time', descending: true)
          .snapshots()
          .listen((snapshot) {
        _comments =
            snapshot.docs.map((doc) => Comment.fromDocument(doc)).toList();
      });
      _isLoading = false;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        notifyListeners();
      });
    } catch (e) {
      debugPrint('Error fetching comments: $e');
    }
  }

  //add comment
  Future<void> addComment({
    required String postId,
    required String comment,
    String? uid,
    String? username,
    String? userImage,
    required BuildContext context,
  }) async {
    Comment newComment = Comment(
      uid: uid ?? '',
      username: username ?? '',
      comment: comment,
      userImage: userImage ?? '',
      time: Timestamp.now(),
    );

    try {
      await _firestore
          .collection('posts')
          .doc(postId)
          .collection('comments')
          .add(newComment.toMap());

      await _firestore.collection('posts').doc(postId).update({
        'comments': FieldValue.increment(1),
      });

      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Comment added successfully!'),
          duration: Duration(seconds: 2),
        ),
      );
    } catch (e) {
      debugPrint('Error adding comment: $e');
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Failed to add comment. Please try again.'),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  // Fetch posts
  Future<void> fetchPosts() async {
    try {
      _isLoading = true;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        notifyListeners();
      });

      _firestore
          .collection('posts')
          .orderBy('uploadTimestamp', descending: true)
          .snapshots()
          .listen((snapshot) {
        _posts = snapshot.docs.map((doc) => Post.fromDocument(doc)).toList();
        _isLoading = false;
        notifyListeners();
      });
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
