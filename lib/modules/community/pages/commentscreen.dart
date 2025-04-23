import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:offbeat_pravasi_v2/common/common_exports.dart';
import 'package:offbeat_pravasi_v2/helpers/helperservices.dart';
import 'package:offbeat_pravasi_v2/modules/module_exports.dart';
import 'package:provider/provider.dart';

class Commentscreen extends StatefulWidget {
  final String postId;

  const Commentscreen({
    super.key,
    required this.postId,
  });

  @override
  State<Commentscreen> createState() => _CommentscreenState();
}

class _CommentscreenState extends State<Commentscreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController commentTextController = TextEditingController();

  void postComment() async {
    final communityServices =
        Provider.of<Communityservices>(context, listen: false);
    final profileservices = Provider.of<ProfileService>(context, listen: false);

    await profileservices.fetchotherUserData(_auth.currentUser!.uid);

    await communityServices.addComment(
      postId: widget.postId,
      comment: commentTextController.text.trim(),
      // ignore: use_build_context_synchronously
      context: context,
      uid: _auth.currentUser!.uid,
      username: profileservices.otherUserData!.username,
      userImage: profileservices.otherUserData!.profileImage,
    );
    commentTextController.clear();
  }

  @override
  void initState() {
    Provider.of<Communityservices>(context, listen: false)
        .fetchComments(widget.postId);
    super.initState();
  }

  @override
  void dispose() {
    commentTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Comments',
          style: TextStyle(
            color: Theme.of(context).colorScheme.primary,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      resizeToAvoidBottomInset:
          true, // Ensures the screen resizes when the keyboard opens
      body: Container(
        padding: const EdgeInsets.all(8.0),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(22.0),
            topRight: Radius.circular(22.0),
          ),
        ),
        child: Column(
          children: [
            // Main Content
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    // Comments List
                    Consumer<Communityservices>(builder: (context, ref, child) {
                      final helpersercices =
                          Provider.of<Helperservices>(context, listen: false);

                      if (ref.comments.isEmpty) {
                        return const Center(
                          child: Text('No comments yet'),
                        );
                      }
                      if (ref.isLoading) {
                        return const Center(child: CircularProgressIndicator());
                      }
                      return ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: ref.comments.length,
                        itemBuilder: (context, index) {
                          return CommentCard(
                            uid: ref.comments[index].uid,
                            username: ref.comments[index].username,
                            comment: ref.comments[index].comment,
                            userimage: ref.comments[index].userImage,
                            time: helpersercices
                                .formatTimestamp(ref.comments[index].time),
                          );
                        },
                      );
                    })
                  ],
                ),
              ),
            ),

            // Text Field for Adding Comments
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: CommonTextfield(
                controller: commentTextController,
                readOnly: false,
                obscureText: false,
                hintText: 'Add a comment...',
                suffixIcon: IconButton(
                  icon: const Icon(
                    Icons.send,
                    color: Colors.black,
                  ),
                  onPressed: () {
                    if (commentTextController.text.isNotEmpty) {
                      postComment();
                    }
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
