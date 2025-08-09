import 'package:akafit/view/widgets/app_text_field.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ExplorePage extends StatelessWidget {
  const ExplorePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          SizedBox(
            width: 300,
            child: TextField(
              readOnly: true,
              decoration: InputDecoration(
                hintText: "search"
              ),
              onTap: () {
                context.go('/explore/search');
              },
            ),
          ),
        ],
      ),
    );
  }
}
