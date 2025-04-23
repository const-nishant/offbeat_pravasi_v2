// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:provider/provider.dart';

import 'package:offbeat_pravasi_v2/common/common_exports.dart';
import 'package:offbeat_pravasi_v2/modules/home/home_exports.dart';

class SearchScreen extends StatefulWidget {
  final double? trekLength;
  final double? elevation;
  final double? rating;
  final String? difficulty;
  const SearchScreen({
    super.key,
    this.trekLength,
    this.elevation,
    this.rating,
    this.difficulty,
  });

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  bool isSearching = false;
  final TextEditingController searchController = TextEditingController();
  bool _snackbarShown = false; // Added to track snackbar state

  @override
  void initState() {
    super.initState();
    searchController.addListener(_fetchTreks);
    _fetchTreks();
  }

  @override
  void dispose() {
    searchController.removeListener(_fetchTreks);
    searchController.dispose();
    // Reset snackbar state when disposing
    _snackbarShown = false; // Reset snackbar state
    super.dispose();
  }

  void _fetchTreks() {
    final homeServices = context.read<HomeServices>();
    Map<String, dynamic> filters = {};

    if (searchController.text.isNotEmpty) {
      filters['trekName'] = searchController.text.trim();
      homeServices.fetchFilteredTreks(filters: filters);
    } else {
      if (widget.trekLength != null) {
        filters['trekDistance'] = widget.trekLength;
      }
      if (widget.elevation != null) filters['trekAltitude'] = widget.elevation;
      if (widget.rating != null) filters['trekRating'] = widget.rating;
      if (widget.difficulty != null) {
        filters['trekDifficulty'] = widget.difficulty;
      }
      // If search field is empty, fetch all treks
      if (filters.isEmpty) {
        homeServices.listenToTreks();
        return;
      }
    }
    homeServices.fetchFilteredTreks(filters: filters);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: CommonTextfield(
                      hintText: 'Search...',
                      prefixIcon: Icon(LucideIcons.search),
                      controller: searchController,
                      onTap: () {
                        setState(() {
                          isSearching = !isSearching;
                        });
                        _fetchTreks();
                      },
                      readOnly: false,
                      obscureText: false,
                    ),
                  ),
                  TextButton(
                    onPressed: () => context.pop(),
                    child: Text(
                      'Cancel',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.tertiary,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Text(
                'Search Results',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.primary,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 16),
              searchController.text.isNotEmpty
                  ? Consumer<HomeServices>(
                      builder: (context, trekProvider, child) {
                        if (trekProvider.isLoading) {
                          return Center(child: CircularProgressIndicator());
                        }
                        final treks = trekProvider.treks;
                        if (treks.isEmpty) {
                          // Show Snackbar when no filtered treks are found
                          WidgetsBinding.instance.addPostFrameCallback((_) {
                            if (!_snackbarShown) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                    content: Text("No filtered treks found")),
                              );
                              _snackbarShown =
                                  true; // Prevents multiple snackbars
                            }
                          });
                          return Center(child: Text("No treks available"));
                        } else {
                          // Reset snackbar flag when treks are available
                          if (_snackbarShown) _snackbarShown = false;
                        }
                        return SizedBox(
                          height: 200,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: treks.length,
                            itemBuilder: (context, index) => Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Popularsearches(
                                trekElevation:
                                    treks[index].trekAltitude.toString(),
                                trekId: treks[index].trekId,
                                trekLocation: treks[index].trekLocation,
                                trekName: treks[index].trekName,
                                trekRating: treks[index].trekRating.toString(),
                                trekImageUrl: treks[index].trekImages.first,
                              ),
                            ),
                          ),
                        );
                      },
                    )
                  : SizedBox.shrink(),
              searchController.text.isEmpty
                  ? Consumer<HomeServices>(
                      builder: (context, trekProvider, child) {
                        if (trekProvider.isLoading) {
                          return Center(child: CircularProgressIndicator());
                        }
                        final treks = trekProvider.treks;
                        if (treks.isEmpty) {
                          return Center(child: Text("No treks available"));
                        }
                        return SizedBox(
                          height: 200,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: treks.length,
                            itemBuilder: (context, index) => Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Popularsearches(
                                trekElevation:
                                    treks[index].trekAltitude.toString(),
                                trekId: treks[index].trekId,
                                trekLocation: treks[index].trekLocation,
                                trekName: treks[index].trekName,
                                trekRating: treks[index].trekRating.toString(),
                                trekImageUrl: treks[index].trekImages.first,
                              ),
                            ),
                          ),
                        );
                      },
                    )
                  : SizedBox.shrink(),
            ],
          ),
        ),
      ),
    );
  }
}
