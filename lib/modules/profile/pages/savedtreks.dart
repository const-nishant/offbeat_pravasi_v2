import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:offbeat_pravasi_v2/modules/profile/widgets/savedtrekcard.dart';
import 'package:provider/provider.dart';

import '../../home/data/dataexports.dart';
import '../data/exports.dart';

class Savedtreks extends StatefulWidget {
  const Savedtreks({super.key});

  @override
  State<Savedtreks> createState() => _SavedtreksState();
}

class _SavedtreksState extends State<Savedtreks> {
  @override
  void initState() {
    super.initState();
    Provider.of<Bookmarkservices>(context, listen: false).fetchBookmarks();
  }

  @override
  Widget build(BuildContext context) {
    final trekService = Provider.of<Trekservices>(context, listen: false);

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Row(
                children: [
                  IconButton(
                    style: ButtonStyle(
                      side: WidgetStateProperty.all(
                        BorderSide(
                          color: Theme.of(context).colorScheme.onInverseSurface,
                          width: 2,
                        ),
                      ),
                      iconColor: WidgetStateProperty.all(
                        Theme.of(context).colorScheme.inversePrimary,
                      ),
                    ),
                    icon: const Icon(
                      LucideIcons.chevronLeft,
                      size: 20,
                      color: Colors.black,
                    ),
                    onPressed: () {
                      context.pop();
                    },
                  ),
                  const SizedBox(width: 50),
                  const Text(
                    'Saved Treks',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // List of saved treks
              Expanded(
                child: Consumer<Bookmarkservices>(
                  builder: (context, bookmarkservices, _) {
                    final bookmarks = bookmarkservices.bookmarks;

                    if (bookmarks.isEmpty) {
                      return const Center(child: Text("No saved treks"));
                    }

                    return FutureBuilder<List<Map<String, dynamic>?>>(
                      future: Future.wait(
                        bookmarks.map((id) => trekService.getTrekById(id)),
                      ),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                              child: CircularProgressIndicator());
                        }

                        final treks = snapshot.data!
                            .whereType<Map<String, dynamic>>()
                            .toList();

                        return ListView.builder(
                          itemCount: treks.length,
                          itemBuilder: (context, index) {
                            final trek = treks[index];
                            return SavedtrekCard(
                              title: trek['trekName'],
                              location: trek['trekStateLocation'],
                              elevation: trek['trekAltitude'].toString(),
                              rating: trek['trekRating'].toString(),
                              trekId: trek['trekId'],
                              trekImage: trek['trekImages'][0],
                            );
                          },
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
