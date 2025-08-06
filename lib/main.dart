  import 'package:akafit/router.dart';
  import 'package:akafit/splash_screen.dart';
  import 'package:akafit/view/theme.dart';
  import 'package:akafit/view/welcome/welcome_background.dart';
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
                style: ElevatedButton.styleFrom(
                  foregroundColor: AppColors.background,
                  backgroundColor: AppColors.secondary,
                  textStyle: TextStyle(
                    fontFamily: 'modam',
                    fontSize: 24.sp.clamp(20, 36),
                  ),
                  minimumSize: Size(250.w.clamp(150, 500), 50.h.clamp(40, 70)),
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
              ),
              colorScheme: ColorScheme.fromSeed(
                seedColor: AppColors.primary,
                primary:  AppColors.primary,
                secondaryFixed: AppColors.secondary,
                background: AppColors.background,
              ),
              scaffoldBackgroundColor: AppColors.background,
            ),
            routerConfig: appRouter,
            debugShowCheckedModeBanner: false,


            builder: (context, child) {
              if(_showSplash){
                return SplashScreen(onInitializationComplete: 
                  () {
                    setState(() {
                      _showSplash = false;
                    });
                  }
                );
              }
              return child!;
            },
          );
        },
      );
    }
  }
