import 'dart:ui';

import 'package:akafit/view/auth/login_phone.dart';
import 'package:akafit/view/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 24.w ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text("آکافیت", style: Theme.of(context).textTheme.bodyLarge),
              SizedBox(height: sizedBox.large.h),
              Text(
                "اکافیت، همراه هوشمند شما در مسیر سلامت، قدرت و تناسب اندام برای زندگی بهتر", 
                style: Theme.of(context).textTheme.bodySmall,
                textAlign: TextAlign.center,
              ),
              SizedBox(height: sizedBox.large.h),
              Column(
                children: [
                  ElevatedButton(
                    onPressed: () {
                      context.go('/login');
                    },
                    child: Text("ورود با شماره"),
                  ),
                  SizedBox(height: sizedBox.medium.h),
                  Text(
                    "در ورود به سیستم با مشکل روبه‌رو شده‌ام",
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
