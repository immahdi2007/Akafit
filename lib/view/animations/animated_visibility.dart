import 'package:akafit/view/theme.dart';
import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';

class AnimatedVisibility extends StatelessWidget {
  const AnimatedVisibility({
    super.key,
    required this.duration,
    required this.child,
  });

  final Duration duration;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: duration,
      switchInCurve: Curves.easeIn,
      switchOutCurve: Curves.easeOut,
      child: child,
    );
  }
}
