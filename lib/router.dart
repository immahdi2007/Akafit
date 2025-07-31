import 'package:akafit/view/login_phone.dart';
import 'package:akafit/view/welcome/welcome_background.dart';
import 'package:akafit/view/welcome/welcome_page.dart';
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
          builder: (context, state) => WelcomePage(),
        ),
        GoRoute(
          path: '/login',
          name: 'login',
          pageBuilder: (context, state) {
            return CustomTransitionPage(
              opaque: false,
              child: LoginPhone(), 
              barrierDismissible: false,
              transitionDuration: Duration(milliseconds: 300),
              transitionsBuilder: (context, animation, secondaryAnimation, child) {
                return FadeTransition(opacity: animation, child: child,);
              },
            );
          },
        )
      ]
    ),
    
    
    
  ]
);