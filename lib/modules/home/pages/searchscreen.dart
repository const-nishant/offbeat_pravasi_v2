import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:offbeat_pravasi_v2/common/common_exports.dart';
import 'package:offbeat_pravasi_v2/modules/home/home_exports.dart';
import 'package:provider/provider.dart';

class Searchscreen extends StatefulWidget {
  const Searchscreen({super.key});

  @override
  State<Searchscreen> createState() => _SearchscreenState();
}

class _SearchscreenState extends State<Searchscreen> {
  TextEditingController searchController = TextEditingController();
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      //the query here
      // ignore: use_build_context_synchronously
      context.read<HomeServices>().listenToTreks(field: '', value: '');
    });
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
                      readOnly: false,
                      obscureText: false,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      context.pop();
                    },
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
              SizedBox(
                height: 20,
              ),
              //states
              Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.black,
                    width: 1,
                  ),
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.all(
                    Radius.circular(12),
                  ),
                ),
                height: MediaQuery.of(context).size.height * 0 + 200,
                padding: EdgeInsets.all(16),
                child: ListView.builder(
                  itemCount: 8,
                  itemBuilder: (BuildContext context, int index) {
                    return InkWell(
                      onTap: () {
                        //logic here
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 14.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Maharashtra',
                              style: TextStyle(
                                color: Theme.of(context).colorScheme.primary,
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Icon(
                              Icons.chevron_right_rounded,
                              size: 24,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),

              SizedBox(
                height: 14,
              ),
              Text(
                'Popular Searches',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.primary,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(
                height: 16,
              ),
              //popular searches
              Consumer<HomeServices>(builder: (context, trekProvider, child) {
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
                        trekElevation: treks[index].trekAltitude.toString(),
                        trekId: treks[index].trekId,
                        trekLocation: treks[index].trekLocation,
                        trekName: treks[index].trekName,
                        trekRating: treks[index].trekRating.toString(),
                        trekImageUrl: treks[index].trekImages.first,
                      ),
                    ),
                  ),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
