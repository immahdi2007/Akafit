import 'package:akafit/view/theme.dart';
import 'package:akafit/view/welcome/welcome_page.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:animate_do/animate_do.dart';

class WelcomeBackground extends StatefulWidget {
  const WelcomeBackground({super.key});

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
    if (!_controller.value.isInitialized) {
      return Center(child: CircularProgressIndicator());
    }
    return Scaffold(
      body: SafeArea(
        child: Stack(
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
            // Container(
            //   decoration: BoxDecoration(color: const Color(0x5A000000)),
            // ),
            Column(
              children: [
                // Expanded(
                //   flex: 1,
                //   child: Container(
                //     decoration: BoxDecoration(
                //       gradient: LinearGradient(
                //         begin: Alignment.topCenter,
                //         end: Alignment.bottomCenter,
                //         colors: [
                //           Colors.black,
                //           Colors.transparent
                //         ],
                //         stops: [0.5, 0.9]
                //       )
                //     ),
                //   ),
                // ),
                Spacer(flex: 5),
                Expanded(
                  flex: 8,
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                        colors: [
                          Colors.black,
                          Colors.transparent
                        ],
                        stops: [0.5, 0.9]
                      )
                    ),
                  ),
                ),
              ],
            ),

            FadeInUp(
              delay: Duration(milliseconds: 500),
              duration: Duration(milliseconds: 300),
              child: WelcomePage()
            ),
          ],
        ),
      ),
    );
  }
}
