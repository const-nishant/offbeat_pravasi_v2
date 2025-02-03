import 'package:go_router/go_router.dart';
import '../modules/auth/auth_exports.dart';

final GoRouter router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const Authwrapper(),
    ),
    // GoRoute(
    //   path: '/login',
    //   builder: (context, state) => const LoginPage(),
    // ),
    // GoRoute(
    //   path: '/signup',
    //   builder: (context, state) => const SignupPage(),
    // ),
  ],
);
