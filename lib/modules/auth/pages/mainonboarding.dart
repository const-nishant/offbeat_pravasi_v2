import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:go_router/go_router.dart';
import 'package:offbeat_pravasi_v2/constants/images.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Mainonboarding extends StatefulWidget {
  const Mainonboarding({super.key});

  @override
  State<Mainonboarding> createState() => _MainonboardingState();
}

class _MainonboardingState extends State<Mainonboarding> {
  int _currentIndex = 0;
  bool isLoading = true;

  final List<Map<String, String>> slides = [
    {
      "image": Images.bg1,
      "title": "Discover and Connect",
      "subtitle":
          "Explore global landscape, find companions and connect with fellow hikers in our vibrant community.",
    },
    {
      "image": Images.bg2,
      "title": "Plan Your Perfect Trek",
      "subtitle":
          "Plan, book, and gear up for your dream trek, all in one place!\nDiscover breathtaking trails, curated just for you",
    },
    {
      "image": Images.bg3,
      "title": "Stay Connected, Stay Safe",
      "subtitle":
          "Connect with fellow trekkers and get real-time updates to ensure a safe journey.",
    },
  ];

  /// Ensure onboarding status is set before navigating
  Future<void> completeOnboarding() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool("isFirstTime", false);
    if (mounted) {
      setState(() => _currentIndex = slides.length - 1);
      Future.delayed(const Duration(milliseconds: 500), () {
        if (mounted) context.go('/');
      });
    }
    // ignore: use_build_context_synchronously
    Phoenix.rebirth(context);
  }

  /// Fetch onboarding status to prevent unnecessary state updates
  Future<void> checkFirstTime() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool firstTime = prefs.getBool("isFirstTime") ?? true;
    if (!firstTime) {
      // ignore: use_build_context_synchronously
      Future.delayed(Duration.zero, () => context.go('/'));
    } else {
      setState(() => isLoading = false);
    }
  }

  @override
  void initState() {
    super.initState();
    checkFirstTime();
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            /// Background Image Carousel
            CarouselSlider(
              options: CarouselOptions(
                height: double.infinity,
                viewportFraction: 1.0,
                enableInfiniteScroll: false,
                onPageChanged: (index, reason) {
                  setState(() => _currentIndex = index);
                },
              ),
              items: slides.map((slide) {
                return Stack(
                  fit: StackFit.expand,
                  children: [
                    Image.asset(slide["image"]!, fit: BoxFit.cover),
                    BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 0.5, sigmaY: 0.5),
                      child: Container(color: Colors.black38),
                    ),
                  ],
                );
              }).toList(),
            ),

            /// Skip Button (Top Right)
            Positioned(
              right: 16,
              top: 10,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  width: 70,
                  height: 34,
                  child: FloatingActionButton(
                    elevation: 1.0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    onPressed: completeOnboarding,
                    backgroundColor:
                        Theme.of(context).colorScheme.onInverseSurface,
                    child: Text(
                      "Skip",
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ),
            ),

            /// Titles, Subtitles, and Navigation Buttons
            Positioned(
              left: 20,
              bottom: 40,
              right: 20,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    slides[_currentIndex]["title"]!,
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w600,
                      color: Theme.of(context).colorScheme.inversePrimary,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    slides[_currentIndex]["subtitle"]!,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Theme.of(context).colorScheme.inversePrimary,
                    ),
                  ),
                  SizedBox(height: 20),

                  /// Indicator Dots and Next Button
                  Row(
                    children: [
                      for (int i = 0; i < slides.length; i++)
                        Container(
                          margin: EdgeInsets.only(right: 5),
                          width: _currentIndex == i ? 25 : 8,
                          height: 8,
                          decoration: BoxDecoration(
                            color: _currentIndex == i
                                ? Colors.orange
                                : Colors.grey,
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                      Spacer(),

                      /// Next Button (Only on Last Slide)
                      _currentIndex == slides.length - 1
                          ? Padding(
                              padding: const EdgeInsets.all(6.0),
                              child: IconButton(
                                onPressed: completeOnboarding,
                                iconSize: 32,
                                icon: Icon(
                                  Icons.chevron_right,
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                                style: ButtonStyle(
                                  backgroundColor:
                                      WidgetStateProperty.all(Colors.white),
                                  shape:
                                      WidgetStateProperty.all(CircleBorder()),
                                ),
                              ),
                            )
                          : SizedBox.shrink(),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
