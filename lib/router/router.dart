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
      pageBuilder: (context, state) => NoTransitionPage(
        child: Trekdetails(),
      ),
    ),
    GoRoute(
      path: '/notificationscreen',
      pageBuilder: (context, state) =>
          NoTransitionPage(child: const Notificationscreen()),
    ),
    GoRoute(
      path: '/reviewscreen',
      pageBuilder: (context, state) =>
          NoTransitionPage(child: const Reviewscreen()),
    ),
    GoRoute(
      path: '/editprofilescreen',
      pageBuilder: (context, state) =>
          NoTransitionPage(child: EditprofileScreen()),
    ),
    GoRoute(
      path: '/achivementscreen',
      pageBuilder: (context, state) =>
          NoTransitionPage(child: AchievementsScreen()),
    ),
    GoRoute(
      path: '/pointscreen',
      pageBuilder: (context, state) => NoTransitionPage(child: PointsScreen()),
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
      path: '/change_password',
      pageBuilder: (context, state) => NoTransitionPage(
        child: const Changepassword(),
      ),
    ),
    GoRoute(
      path: '/becometrekorganizer',
      pageBuilder: (context, state) =>
          NoTransitionPage(child: const BecomeTrekOrganizerScreen()),
    ),
    GoRoute(
      path: '/savedtreks',
      pageBuilder: (context, state) =>
          NoTransitionPage(child: const Savedtreks()),
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
