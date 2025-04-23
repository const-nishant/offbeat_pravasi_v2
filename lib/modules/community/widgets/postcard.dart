import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:offbeat_pravasi_v2/helpers/helper_exports.dart';
import 'package:provider/provider.dart';
import '../community_exports.dart';

class Postcard extends StatefulWidget {
  final String description;
  final String location;
  final String postId;
  final String uid;
  final String imageUrl;
  final String username;
  final String userImageUrl;
  final Timestamp time;
  final List<String> likes;
  final int comments;

  const Postcard({
    super.key,
    required this.postId,
    required this.description,
    required this.imageUrl,
    required this.time,
    required this.location,
    required this.username,
    required this.userImageUrl,
    required this.likes,
    required this.comments,
    required this.uid,
  });

  @override
  State<Postcard> createState() => _PostcardState();
}

class _PostcardState extends State<Postcard> {
  final helperServices = Helperservices();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  late bool isLiked;
  late int likeCount;

  @override
  void initState() {
    super.initState();
    likeCount = widget.likes.length;
    isLiked = widget.likes.contains(widget.uid);
  }

  Future<void> toggleLike() async {
    final communityServices =
        Provider.of<Communityservices>(context, listen: false);

    try {
      await communityServices.toggleLike(widget.postId, widget.uid);
      setState(() {
        isLiked = !isLiked;
        likeCount += isLiked ? 1 : -1;
      });
    } catch (e) {
      debugPrint("Error toggling like: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Card(
        elevation: 3,
        margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: const EdgeInsets.all(14.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // User Info
              Row(
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundColor: Theme.of(context).colorScheme.secondary,
                    child: CircleAvatar(
                      radius: 28,
                      backgroundImage:
                          CachedNetworkImageProvider(widget.userImageUrl),
                      onBackgroundImageError: (_, __) =>
                          const Icon(Icons.person, size: 28),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      InkWell(
                        onTap: () {
                          // Handle user profile navigation
                          if (widget.uid != _auth.currentUser!.uid) {
                            context.push('/other-user-profile',
                                extra: widget.uid);
                          }
                        },
                        child: Text(
                          widget.username,
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                        ),
                      ),
                      Text(
                        widget.location,
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: Theme.of(context).colorScheme.tertiary,
                        ),
                      ),
                      Text(
                        helperServices.formatTimestamp(widget.time),
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: Theme.of(context).colorScheme.tertiary,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 10),

              // Post Content
              RichText(
                text: TextSpan(
                  children: Textspanhelper.buildDescriptionTextSpans(
                      widget.description, context),
                ),
              ),
              const SizedBox(height: 10),

              // Image
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: CachedNetworkImage(
                  imageUrl: widget.imageUrl,
                  height: MediaQuery.of(context).size.height * 0.32,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  placeholder: (context, url) => Container(
                    height: MediaQuery.of(context).size.height * 0.32,
                    width: double.infinity,
                    color: Colors.grey[300],
                    child: const Center(
                      child: CircularProgressIndicator(),
                    ),
                  ),
                  errorWidget: (context, url, error) => Container(
                    height: MediaQuery.of(context).size.height * 0.32,
                    width: double.infinity,
                    color: Colors.grey[300],
                    child: const Icon(Icons.broken_image, size: 50),
                  ),
                ),
              ),

              const SizedBox(height: 8),

              // Likes & Comments
              Row(
                children: [
                  IconButton(
                    icon: Icon(
                      isLiked ? Icons.favorite : Icons.favorite_border,
                      color: isLiked ? Colors.red : Colors.black,
                    ),
                    onPressed: toggleLike,
                  ),
                  const SizedBox(width: 4),
                  Text("$likeCount"),
                  const SizedBox(width: 16),
                  IconButton(
                    icon: const Icon(
                      LucideIcons.messageSquare,
                      color: Colors.black,
                      size: 24,
                    ),
                    onPressed: () {
                      // Add comment logic here
                      showModalBottomSheet(
                        context: context,
                        showDragHandle: true,
                        isScrollControlled: true, // Allows full-screen modal
                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.vertical(top: Radius.circular(16)),
                        ),
                        builder: (context) => Container(
                          height: MediaQuery.of(context).size.height * 0.56,
                          width: MediaQuery.of(context).size.width,
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(22.0),
                              topRight: Radius.circular(22.0),
                            ),
                            color: Colors.white,
                          ),
                          child: Commentscreen(
                            postId: widget.postId,
                          ),
                        ),
                      );
                    },
                  ),
                  const SizedBox(width: 4),
                  Text("${widget.comments}"),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
