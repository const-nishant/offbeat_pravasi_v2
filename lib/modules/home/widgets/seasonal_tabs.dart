import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:provider/provider.dart';

import '../home_exports.dart';

class SeasonalTabs extends StatefulWidget {
  final String state;
  const SeasonalTabs({super.key, required this.state});

  @override
  State<SeasonalTabs> createState() => _SeasonalTabsState();
}

class _SeasonalTabsState extends State<SeasonalTabs> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      //the query here
      widget.state == ''
          ?
          // ignore: use_build_context_synchronously
          context.read<HomeServices>().listenToTreks(field: '', value: '')
          :
          // ignore: use_build_context_synchronously
          context
              .read<HomeServices>()
              .listenToTreks(field: 'trekStateLocation', value: widget.state);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeServices>(
      builder: (context, trekProvider, child) {
        if (trekProvider.isLoading) {
          return Center(child: CircularProgressIndicator());
        }

        final treks = trekProvider.treks;

        if (treks.isEmpty) {
          return Center(child: Text("No treks available"));
        }

        return ListView.builder(
          itemCount: treks.length,
          scrollDirection: Axis.horizontal,
          padding: EdgeInsets.all(16),
          itemBuilder: (context, index) {
            final trek = treks[index];
            return Container(
              margin: EdgeInsets.only(right: 12, top: 16),
              child: Card(
                color: trek.trekImages.isNotEmpty
                    ? Colors.transparent
                    : Theme.of(context).colorScheme.onPrimary,
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(22),
                ),
                child: Container(
                  width: 236,
                  padding: EdgeInsets.all(2),
                  decoration: BoxDecoration(
                    color: trek.trekImages.isNotEmpty
                        ? Colors.transparent
                        : Theme.of(context).colorScheme.onPrimary,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Stack(
                    children: [
                      // Trek Image
                      Positioned.fill(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          child: CachedNetworkImage(
                            imageUrl: trek.trekImages.first,
                            fit: BoxFit.cover,
                            placeholder: (context, url) => Center(
                              child: CircularProgressIndicator(),
                            ),
                            errorWidget: (context, url, error) => Icon(
                              Icons.error,
                              color: Colors.red,
                            ),
                          ),
                        ),
                      ),
                      // State Tag (Top-Left)
                      Positioned(
                        top: 12,
                        left: 12,
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 12, vertical: 12),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                LucideIcons.bookmark,
                                size: 16,
                                color: Theme.of(context).colorScheme.primary,
                              ),
                              SizedBox(width: 4),
                              Text(
                                trek.trekStateLocation,
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Theme.of(context).colorScheme.primary,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      // Trek Name and Location (Bottom-Left)
                      Positioned(
                        bottom: 12,
                        left: 12,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              trek.trekName,
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context)
                                    .colorScheme
                                    .inversePrimary,
                              ),
                            ),
                            SizedBox(height: 4),
                            Row(
                              children: [
                                Icon(Icons.location_on_outlined,
                                    size: 16,
                                    color: Theme.of(context)
                                        .colorScheme
                                        .inversePrimary),
                                SizedBox(width: 4),
                                Text(
                                  trek.trekLocation,
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Theme.of(context)
                                        .colorScheme
                                        .inversePrimary,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      // Navigation Button (Bottom-Right)
                      Positioned(
                        bottom: 12,
                        right: 12,
                        child: Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                          ),
                          child: IconButton(
                            onPressed: () {
                              context.push("/trekdetails", extra: {
                                'trekId': trek.trekId,
                              });
                            },
                            icon: Icon(
                              LucideIcons.moveRight,
                              size: 24,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
