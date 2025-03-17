import 'package:go_router/go_router.dart';
import '../modules/module_exports.dart';
import 'package:flutter/material.dart';

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
      path: '/change-password',
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
              recommendationData: extra["recommendations"]!,
            ),
          );
        }),
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
