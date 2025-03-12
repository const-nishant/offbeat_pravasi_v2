import 'package:go_router/go_router.dart';
import '../modules/module_exports.dart';

final GoRouter router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const Authwrapper(),
    ),
    GoRoute(
      path: '/forgot_password',
      builder: (context, state) => const ForgotPassword(),
    ),
    GoRoute(
      path: '/home',
      builder: (context, state) => const SignupPage(),
    ),
    GoRoute(
      path: '/about',
      builder: (context, state) => const AboutPage(),
    ),
    GoRoute(
      path: '/search',
      builder: (context, state) => const Searchscreen(),
    ),
  ],
);
