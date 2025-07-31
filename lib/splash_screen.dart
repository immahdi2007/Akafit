import 'dart:async';

import 'package:akafit/view/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key, required this.onInitializationComplete});
  final VoidCallback onInitializationComplete;


  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    Timer(Duration(seconds: 3), () {
      widget.onInitializationComplete();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("آکافیت", style: TextStyle(color: Theme.of(context).colorScheme.primary, fontSize: 24.sp.clamp(20, 36)),),
            SizedBox(height: sizedBox.medium.h,),
            CircularProgressIndicator()
          ],
        ),
      ),
    );
  }
}