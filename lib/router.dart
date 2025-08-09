import 'package:akafit/view/app/*your_partner/your_partner.dart';
import 'package:akafit/view/app/account_page/account_page.dart';
import 'package:akafit/view/app/explore_page/explore_page.dart';
import 'package:akafit/view/app/main_navigation_bar.dart';
import 'package:akafit/view/auth/login_phone.dart';
import 'package:akafit/view/theme.dart';
import 'package:akafit/view/auth/welcome/welcome_background.dart';
import 'package:akafit/view/auth/welcome/welcome_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

final GoRouter appRouter = GoRouter(
  routes: [
    ShellRoute(
      builder: (context, state, child) {
        return WelcomeBackground(child: child);
      },
      routes: [
        GoRoute(
          path: '/',
          name: 'welcomepage',
          builder: (context, state) => WelcomeBackground(child: SizedBox()),
        ),
        GoRoute(
          path: '/login',
          name: 'login',
          pageBuilder: (context, state) {
            return CustomTransitionPage(
              opaque: false,
              child: LoginPhone(),
              barrierDismissible: false,
              transitionDuration: AppDuration.page,
              transitionsBuilder:
                  (context, animation, secondaryAnimation, child) {
                    return FadeTransition(opacity: animation, child: child);
                  },
            );
          },
        ),
      ],
    ),

    ShellRoute(
      builder: (context, state, child) {
        return AppNavigatorBar(child: child);
      },
      routes: [
        GoRoute(
          path: '/explore',
          name: 'explorePage',
          pageBuilder: (context, state) => NoTransitionPage(child: ExplorePage()),
        ),
        GoRoute(
          path: '/account_setting',
          name: 'accountSettingPage',
          pageBuilder: (context, state) => NoTransitionPage(child: AccountPage()),
        ),
        GoRoute(
          path: '/your_partner',
          name: 'your_partner',
          pageBuilder: (context, state) => NoTransitionPage(child: YourPartner()),
        ),
      ],
    ),
  ],
);
