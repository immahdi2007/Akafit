import 'package:akafit/view/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:akafit/view/animations/animated_icon.dart';

class AppNavigatorBar extends StatefulWidget {
  const AppNavigatorBar({super.key, required this.child});
  final Widget child;

  @override
  State<AppNavigatorBar> createState() => AppNavigatorBarState();
}

class AppNavigatorBarState extends State<AppNavigatorBar> {
  int _currentIndex = 0;
  final List<String> routes = ['/explore', '/your_partner', '/account_setting'];

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    final location = GoRouterState.of(context).uri.toString();
    final index = routes.indexOf(location);
    if (index != -1 && index != _currentIndex) {
      _currentIndex = index;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: widget.child),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: AppColors.background,
        currentIndex: _currentIndex,
        onTap: (index) {
          print(index);
          setState(() {
            _currentIndex = index;
          });
          context.go(routes[index]);
        },
        items: [
          BottomNavigationBarItem(
            icon: AnimatedIconSwitcher(
              condition: _currentIndex == 0,
              duration: AppDuration.icon,
              icon1Path: 'assets/icons/search.svg',
              icon2Path: 'assets/icons/search_more.svg',
            ),
            label: 'اکسپلور',
          ),
          BottomNavigationBarItem(
            icon: AnimatedIconSwitcher(
              condition: _currentIndex == 1,
              icon1Path: 'assets/icons/dumbbell.svg',
              icon2Path: 'assets/icons/dumbbell_filled.svg',
              duration: AppDuration.icon,
            ),
            label: 'مربی شما',
          ),
          BottomNavigationBarItem(
            icon: AnimatedIconSwitcher(
              condition: _currentIndex == 2,
              icon1Path: 'assets/icons/user.svg',
              icon2Path: 'assets/icons/user_filled.svg',
              duration: AppDuration.icon,
            ),
            label: 'پروفایل',
          ),
        ],
      ),
    );
  }
}
