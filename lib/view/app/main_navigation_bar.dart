import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AppNavigatorBar extends StatefulWidget {
  const AppNavigatorBar({super.key, required this.child});
  final Widget child;

  @override
  State<AppNavigatorBar> createState() => AppNavigatorBarState();
}

class AppNavigatorBarState extends State<AppNavigatorBar> {
  int _currentIndex = 0;
  final List<String> routes = ['/explore', '/account_setting'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widget.child,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
          context.go(routes[index]);
        },
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'اکسپلور'),
          BottomNavigationBarItem(icon: Icon(Icons.verified_user), label: 'پروفایل')
        ]
      ),
    );
  }
}
