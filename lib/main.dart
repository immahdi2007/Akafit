import 'package:akafit/router.dart';
import 'package:akafit/view/auth/splash_screen.dart';
import 'package:akafit/view/theme.dart';
import 'package:akafit/view/auth/welcome/welcome_background.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:url_strategy/url_strategy.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() {
  setPathUrlStrategy();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _showSplash = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    Future.delayed(Duration(seconds: 3), () {
      setState(() {
        _showSplash = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp.router(
          title: 'Akafit',
          locale: Locale("fa"),
          supportedLocales: [Locale("fa"), Locale("en")],
          localizationsDelegates: [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          theme: ThemeData(
            useMaterial3: true,
            fontFamily: 'modam',
            elevatedButtonTheme: ElevatedButtonThemeData(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.resolveWith<Color>((
                  states,
                ) {
                  if (states.contains(MaterialState.disabled)) {
                    return AppColors.grayBg; // 👈 رنگ دکمه غیرفعال
                  }
                  return AppColors.secondary; // 👈 رنگ دکمه فعال
                }),
                foregroundColor: MaterialStateProperty.all(
                  AppColors.background,
                ),
                overlayColor: MaterialStateProperty.resolveWith<Color?>((
                  states,
                ) {
                  if (states.contains(MaterialState.pressed)) {
                    return AppColors
                        .primary; // رنگ خاکستری نیمه شفاف وقتی دکمه فشار داده میشه
                  }
                  return null; // رنگ پیش‌فرض بقیه حالت‌ها
                }),
                textStyle: MaterialStateProperty.all(
                  TextStyle(fontFamily: 'modam', fontSize: 24.sp.clamp(20, 36)),
                ),
                minimumSize: MaterialStateProperty.all(
                  Size(250.w.clamp(150, 500), ButtonDimes.height),
                ),
              ),
            ),
            textTheme: TextTheme(
              bodySmall: TextStyle(
                color: AppColors.background,
                fontSize: 12.sp.clamp(8, 16),
              ),
              bodyMedium: TextStyle(
                color: AppColors.background,
                fontSize: 16.sp.clamp(12, 20),
              ),
              bodyLarge: TextStyle(
                color: AppColors.background,
                fontSize: 24.sp.clamp(20, 28),
              ),
              titleLarge: TextStyle(
                color: AppColors.background,
                fontSize: 24.sp.clamp(20, 28),
                fontWeight: FontWeight.w500,
              ),
            ),
            colorScheme: ColorScheme.fromSeed(
              seedColor: AppColors.primary,
              primary: AppColors.secondary,
              secondary: AppColors.primary,
              background: AppColors.background,
            ),
            scaffoldBackgroundColor: AppColors.background,
            iconTheme: IconThemeData(
              color: AppColors.hintColor
            )
          ),
          routerConfig: appRouter,
          debugShowCheckedModeBanner: false,

          builder: (context, child) {
            if (_showSplash) {
              return SplashScreen(
                onInitializationComplete: () {
                  setState(() {
                    _showSplash = false;
                  });
                },
              );
            }
            return child!;
          },
        );
      },
    );
  }
}
