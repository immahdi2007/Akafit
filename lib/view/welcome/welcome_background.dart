import 'dart:ui';

import 'package:akafit/view/login_phone.dart';
import 'package:akafit/view/theme.dart';
import 'package:akafit/view/welcome/welcome_page.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:animate_do/animate_do.dart';

class WelcomeBackground extends StatefulWidget {
  final Widget child;
  const WelcomeBackground({super.key, required this.child});

  @override
  State<WelcomeBackground> createState() => _WelcomeBackgroundState();
}

class _WelcomeBackgroundState extends State<WelcomeBackground> {
  //inistalling video player
  late VideoPlayerController _controller;

  @override
  void initState() {
    // TODO: implement initState
    _controller = VideoPlayerController.network("assets/videos/welcome-gif.mp4")  
      ..initialize().then((_) {
        setState(() {});
        _controller.setLooping(true);
        _controller.setVolume(0);
        _controller.play();
      });

    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: _controller.value.isInitialized ?
         Stack(
          children: [
            Positioned.fill(
              child: FittedBox(
                fit: BoxFit.cover,
                child: SizedBox(
                  width: _controller.value.size.width,
                  height: _controller.value.size.height,
                  child: VideoPlayer(_controller),
                ),
              ),
            ),
            Positioned.fill(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 50, sigmaY: 50),
                child: Container(color: const Color.fromARGB(61, 0, 0, 0)),
              ),
            ),
            Column(
              children: [
                Spacer(flex: 5),
                Expanded(
                  flex: 8,
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                        colors: [Colors.black, Colors.transparent],
                        stops: [0.5, 0.9],
                      ),
                    ),
                  ),
                ),
              ],
            ),

            FadeInUp(
              delay: Duration(milliseconds: 700),
              duration: Duration(milliseconds: 300),
              child: WelcomePage(),
            ),

            if (widget.child is! SizedBox) widget.child,
          ],
        ) : Center(child: CircularProgressIndicator()),
      ),
    );
  }
}
