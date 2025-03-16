import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:offbeat_pravasi_v2/helpers/helper_exports.dart';

class Postcard extends StatefulWidget {
  final int index;
  final String title;
  final String uid;
  final String description;
  final String imageUrl;
  final String time;
  final String location;
  final String username;
  final String userImageUrl;
  final int likes;
  final int comments;

  const Postcard({
    super.key,
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.time,
    required this.location,
    required this.username,
    required this.userImageUrl,
    required this.likes,
    required this.comments,
    required this.uid,
    required this.index,
  });

  @override
  State<Postcard> createState() => _PostcardState();
}

class _PostcardState extends State<Postcard> {
  bool isLiked = false;
  int likeCount = 0;

  @override
  void initState() {
    super.initState();
    likeCount = widget.likes;
  }

  void toggleLike() {
    setState(() {
      isLiked = !isLiked;
      likeCount += isLiked ? 1 : -1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      margin: EdgeInsets.symmetric(vertical: 4, horizontal: 16),
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
                  ),
                ),
                SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
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
                      widget.time,
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
            SizedBox(height: 10),

            // Post Content
            RichText(
              text: TextSpan(
                children: Textspanhelper.buildDescriptionTextSpans(
                    widget.description, context),
              ),
            ),
            SizedBox(height: 10),

            // Image
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                widget.imageUrl,
                height: MediaQuery.of(context).size.height * 0.32,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: 8),

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
                SizedBox(width: 4),
                Text("$likeCount"),
                SizedBox(width: 16),
                IconButton(
                  icon: Icon(
                    LucideIcons.messageSquare,
                    color: Colors.black,
                    size: 24,
                  ),
                  onPressed: () {
                    // Add comment logic here
                  },
                ),
                SizedBox(width: 4),
                Text("${widget.comments}"),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
