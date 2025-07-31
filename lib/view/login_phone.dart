import 'dart:ui';

import 'package:flutter/material.dart';

class LoginPhone extends StatelessWidget {
  const LoginPhone({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(190, 0, 0, 0),
      body: Stack(
        children: [ 
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
            child: Container(color: Colors.transparent,),
          ),
          
          Center(
          child: Column(
          children: [
            Column(
              children:[ 
                Text("شماره تلفن خود را وارد کنید"),
                TextFormField(
                    
                ),
              ]
            ),
            ElevatedButton(onPressed: () {}, child: Text('ارسال کد'))
          ],
        ),),
        ]
      ),
    );
  }
}