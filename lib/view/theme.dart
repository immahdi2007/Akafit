import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class sizedBox {
  static const double small = 8.0;
  static const double medium = 16.0;
  static const double large = 24.0;
}

class AppColors {
  static const Color primary = Color(0xFF3700B3);
  static const Color secondary = Color(0xFF6200EE);
  static const Color background = Color(0xFFFFFFFF);
  static const Color surface = Color(0xFFF5F5F5);
  static const Color textPrimary = Color(0xFF000000);
  static const Color errorColor = Color.fromARGB(255, 202, 28, 71);
  static const Color hoverPurple = Color(0xFFE9DFFF);
  static const Color grayBg = Color(0x79424242);
  static const Color hintColor = Color(0xFF777777);
}

class AppRadius {
  static BorderRadius radius_5 = BorderRadius.circular(5.0);
  static BorderRadius radius_8 = BorderRadius.circular(8.0);
}

class AppTextStyle {
  static const TextStyle errorStyle = TextStyle(
    fontWeight: FontWeight.w100,
    color: AppColors.errorColor,
  );
}

class TextFieldDimes {
  static final double height = 45.h.clamp(30, 55);
}

class ButtonDimes {
  static final double height = 55.h.clamp(35, 70);
}

class AppDuration {
  static const Duration widgets = Duration(milliseconds: 300);
  static const Duration textFeild = Duration(milliseconds: 400);
  static const Duration errorText = Duration(milliseconds: 200);
}

class AppDelay {
  static const Duration widgets = Duration(milliseconds: 700);
  static const Duration textFeild = Duration(milliseconds: 200);
  static const Duration errorText = Duration(milliseconds: 0);
}
