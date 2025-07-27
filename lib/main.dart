import 'package:akafit/view/welcome_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      locale: Locale("fa"),
      supportedLocales: [
        Locale("fa"),
        Locale("en")
      ],
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate
      ],
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Color(0xFF3700B3)),
        scaffoldBackgroundColor: Colors.white,
      ),
      home: Scaffold(
        body: SafeArea(child: WelcomePage()),
      ),
    );
  }
}
