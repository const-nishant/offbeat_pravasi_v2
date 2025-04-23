import 'package:flutter/material.dart';
import 'package:offbeat_pravasi_v2/modules/profile/widgets/pasttrekscard.dart';

class PastTreks extends StatelessWidget {
  const PastTreks({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 5,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      itemBuilder: (context, index) => Padding(
        padding: const EdgeInsets.only(bottom: 16),
        child: const PastTreksCard(),
      ),
    );
  }
}
