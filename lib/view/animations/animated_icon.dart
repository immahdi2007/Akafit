import 'package:akafit/view/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class AnimatedIconSwitcher extends StatelessWidget {
  const AnimatedIconSwitcher({
    super.key,
    required this.condition,
    required this.icon1Path,
    required this.icon2Path,
    required this.duration,
  });
  final bool condition;
  final String icon1Path;
  final String icon2Path;
  final Duration duration;

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: duration,
      transitionBuilder: (child, animation) {
        return FadeTransition(opacity: animation, child: child);
      },
      child: !condition 
      ? SvgPicture.asset(
        icon1Path,
        key: ValueKey(icon1Path),
        color: AppColors.hintColor,
        width: IconDimes.width,
      )
      : SvgPicture.asset(
        icon2Path,
        color: AppColors.secondary,
        key: ValueKey(icon2Path),
        width: IconDimes.width,
      ),
    );
  }
}
