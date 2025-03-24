import 'dart:io';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../modules/module_exports.dart';

final GoRouter router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      pageBuilder: (context, state) =>
          NoTransitionPage(child: const Authwrapper()),
    ),
    GoRoute(
      path: '/forgot_password',
      pageBuilder: (context, state) =>
          NoTransitionPage(child: const ForgotPassword()),
    ),
    GoRoute(
      path: '/home',
      pageBuilder: (context, state) =>
          NoTransitionPage(child: const SignupPage()),
    ),
    GoRoute(
      path: '/about',
      pageBuilder: (context, state) =>
          NoTransitionPage(child: const AboutPage()),
    ),
    GoRoute(
      path: '/search',
      pageBuilder: (context, state) =>
          NoTransitionPage(child: const Searchscreen()),
    ),
    GoRoute(
        path: '/trekdetails',
        pageBuilder: (context, state) {
          final extra = state.extra as Map<String, String>;
          return NoTransitionPage(
            child: Trekdetails(
              trekId: extra["trekId"]!,
            ),
          );
        }),
    GoRoute(
      path: '/change_password',
      pageBuilder: (context, state) => NoTransitionPage(
        child: const Changepassword(),
      ),
    ),
    GoRoute(
      path: '/viewitinery',
      pageBuilder: (context, state) {
        final extra = state.extra as Map<String, String>;
        return NoTransitionPage(
          child: ViewItinerary(
            trekName: extra["trekname"]!,
            itineraryData: extra["itinerary"]!,
            recommendedEssentials: extra["essentials"],
            recommendedGear: extra["gear"],
          ),
        );
      },
    ),
    GoRoute(
      path: '/trekpreview',
      pageBuilder: (context, state) {
        final extra = state.extra as Map<String, dynamic>;
        return NoTransitionPage(
          child: TrekPreview(
            trekName: extra["trekName"] as String,
            trekLocation: extra["trekLocation"] as String,
            trekDate: DateTime.parse(extra["trekDate"] as String),
            trekOverview: extra["trekOverview"] as String,
            trekImages: extra["trekImages"] as List<File>,
            trekDuration: extra["trekDuration"] as String,
            trekDistance: double.parse(extra["trekDistance"] as String),
            trekElevation: double.parse(extra["trekElevation"] as String),
            trekDifficulty: extra["trekDifficulty"] as String,
            trekItinerary: extra["trekItinerary"] as String,
            recommendedGear: extra["recommendedGear"] as String,
            recommendedEssentials: extra["recommendedEssentials"] as String,
          ),
        );
      },
    ),
    GoRoute(
      path: '/reviewscreen',
      pageBuilder: (context, state) => NoTransitionPage(
        child: const Reviewscreen(),
      ),
    ),
    GoRoute(
      path: '/notificationscreen',
      pageBuilder: (context, state) => NoTransitionPage(
        child: const Notificationscreen(),
      ),
    ),
    GoRoute(
      path: '/addtreks',
      pageBuilder: (context, state) => NoTransitionPage(
        child: const Addtreks(),
      ),
    ),
    GoRoute(
      path: '/editprofilescreen',
      pageBuilder: (context, state) => NoTransitionPage(
        child: EditprofileScreen(),
      ),
    ),
    GoRoute(
      path: '/achivementscreen',
      pageBuilder: (context, state) => NoTransitionPage(
        child: AchievementsScreen(),
      ),
    ),
    GoRoute(
      path: '/pointscreen',
      pageBuilder: (context, state) => NoTransitionPage(
        child: PointsScreen(),
      ),
    ),
    GoRoute(
      path: '/addposts',
      pageBuilder: (context, state) => NoTransitionPage(
        child: const AddPost(),
      ),
    ),
    GoRoute(
      path: '/addstorys',
      pageBuilder: (context, state) => NoTransitionPage(
        child: const AddStory(),
      ),
    ),
    GoRoute(
      path: '/becometrekorganizer',
      pageBuilder: (context, state) => NoTransitionPage(
        child: const BecomeTrekOrganizerScreen(),
      ),
    ),
    GoRoute(
      path: '/savedtreks',
      pageBuilder: (context, state) => NoTransitionPage(
        child: const Savedtreks(),
      ),
    ),
    GoRoute(
      path: '/mytreks',
      pageBuilder: (context, state) => NoTransitionPage(
        child: const MyTreks(),
      ),
    ),
  ],
);

class NoTransitionPage extends CustomTransitionPage {
  // ignore: use_super_parameters
  NoTransitionPage({required Widget child})
      : super(
          child: child,
          transitionDuration: Duration.zero,
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return child;
          },
        );
}
