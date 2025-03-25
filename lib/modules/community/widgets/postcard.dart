import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:offbeat_pravasi_v2/helpers/helper_exports.dart';
import 'package:provider/provider.dart';
import '../community_exports.dart';

class Postcard extends StatefulWidget {
  final String postId;
  final String uid;
  final String description;
  final String imageUrl;
  final Timestamp time;
  final String location;
  final String username;
  final String userImageUrl;
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
    return Card(
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
                    backgroundImage: NetworkImage(widget.userImageUrl),
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
              child: Image.network(
                widget.imageUrl,
                height: MediaQuery.of(context).size.height * 0.32,
                width: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Container(
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
                  },
                ),
                const SizedBox(width: 4),
                Text("${widget.comments}"),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
