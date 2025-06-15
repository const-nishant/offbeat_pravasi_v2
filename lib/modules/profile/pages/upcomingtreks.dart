import 'package:flutter/material.dart';
import 'package:offbeat_pravasi_v2/modules/profile/widgets/upcomingtrekscard.dart';
import 'package:provider/provider.dart';

import '../../../helpers/helper_exports.dart';
import '../data/exports.dart';

class UpcomingTreks extends StatefulWidget {
  const UpcomingTreks({super.key});

  @override
  State<UpcomingTreks> createState() => _UpcomingTreksState();
}

class _UpcomingTreksState extends State<UpcomingTreks> {
  @override
  void initState() {
    final profileservices = Provider.of<ProfileService>(context, listen: false);
    profileservices.fetchUserTrekIds();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final profileservices = Provider.of<ProfileService>(context, listen: false);
    return FutureBuilder(
      future: profileservices.fetchTreksByIds(profileservices.userTrekIds),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return const Center(child: Text('Error loading treks'));
        }

        final treks = snapshot.data ?? [];

        return ListView.builder(
          itemCount: treks.length,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          itemBuilder: (context, index) {
            final trek = treks[index];
            final helperservice =
                Provider.of<Helperservices>(context, listen: false);
            return Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: UpcomingTreksCard(
                imageUrl: trek.trekImages.first,
                title: trek.trekName,
                location: trek.trekStateLocation,
                dateTime: helperservice.formatDate(trek.trekDate),
                rating: trek.trekRating.toString(),
                altitude: trek.trekAltitude.toString(),
                onTap: () {
                  // Navigate to trek details
                },
              ),
            );
          },
        );
      },
    );
  }
}
