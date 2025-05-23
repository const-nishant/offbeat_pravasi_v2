import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:offbeat_pravasi_v2/common/common_exports.dart';
import 'package:provider/provider.dart';

import '../data/dataexports.dart';

class Addreview extends StatefulWidget {
  final String trekId;
  final String userId;
  final String username;
  final String profileImage;
  const Addreview({
    super.key,
    required this.trekId,
    required this.userId,
    required this.username,
    required this.profileImage,
  });

  @override
  State<Addreview> createState() => _AddreviewState();
}

class _AddreviewState extends State<Addreview> {
  Future<void> addReview() async {
    if (_formKey.currentState!.validate()) {
      final review = ReviewModel(
        profileImage: widget.profileImage,
        username: widget.username,
        rating: _rating,
        review: _reviewController.text,
        userId: widget.userId,
        trekId: widget.trekId,
        timestamp: Timestamp.now(),
      );
      await Provider.of<ReviewServices>(context, listen: false)
          .addReview(widget.trekId, review, context);
      _reviewController.clear();

      setState(() {
        _rating = 0.0;
      });
    }
    // ignore: use_build_context_synchronously
    Navigator.pop(context);
  }

  double _rating = 0.0;
  final TextEditingController _reviewController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'How was your experience?',
            style: TextStyle(
              color: Theme.of(context).colorScheme.primary,
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 10),
          RatingBar(
            initialRating: _rating,
            minRating: 1,
            allowHalfRating: true,
            itemCount: 5,
            ratingWidget: RatingWidget(
              full: const Icon(Icons.star, color: Colors.amber, size: 24),
              half: const Icon(Icons.star_half, color: Colors.amber, size: 24),
              empty:
                  const Icon(Icons.star_border, color: Colors.grey, size: 24),
            ),
            onRatingUpdate: (rating) {
              setState(() {
                _rating = rating;
              });
            },
          ),
          const SizedBox(height: 10),
          Text(
            'Your feedback is very important for us',
            style: TextStyle(
                fontSize: 14,
                color: Theme.of(context).colorScheme.tertiary,
                fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 14),
          Form(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            key: _formKey,
            child: CommonTextfield(
              hintText: "Write your review here",
              controller: _reviewController,
              readOnly: false,
              obscureText: false,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your review';
                }
                return null;
              },
              prefixIcon: Icon(
                LucideIcons.pencilLine,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
          ),
          SizedBox(height: 18),
          LargeButton(onPressed: () => addReview(), text: "Submit"),
        ],
      ),
    );
  }
}
