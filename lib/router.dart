import 'package:akafit/view/welcome/welcome_background.dart';
import 'package:go_router/go_router.dart';

final GoRouter appRouter = GoRouter(
  routes: [
    GoRoute(path: "/",
      name: 'welcomePage',
      builder: (context, state) => WelcomeBackground(),
    ),
    // GoRoute(path: '')
  ]
);