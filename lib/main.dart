import 'dart:async';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'home_page.dart';
import 'registration.dart';
import 'authentication.dart';

void main() async {
  runApp(TicketUsApp());
}

class TicketUsApp extends StatefulWidget {
  @override
  _TicketUsAppState createState() => _TicketUsAppState();
}

class _TicketUsAppState extends State<TicketUsApp> {
  late final VideoPlayerController _controller =
  VideoPlayerController.asset('assets/intro.mp4');

  @override
  void initState() {
    super.initState();
    _controller.initialize().then((_) {
      _controller.play();
      _controller.setLooping(false); // Set to false to stop the video from looping
      setState(() {}); // Add this to update the UI when the video is initialized
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'TicketUs',
      home: SplashScreen(controller: _controller),
      routes: {
        '/auth': (context) => HomePage(),
      },
    );
  }
}

class SplashScreen extends StatefulWidget {
  final VideoPlayerController controller;

  SplashScreen({required this.controller});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late bool _isVideoPlaying = false;

  @override
  void initState() {
    super.initState();
    widget.controller.addListener(_onVideoPlayStatusUpdate);
  }

  void _onVideoPlayStatusUpdate() {
    if (widget.controller.value.isPlaying) {
      setState(() {
        _isVideoPlaying = true;
      });
    } else if (_isVideoPlaying &&
        widget.controller.value.duration == widget.controller.value.position) {
      // Video has finished playing, navigate to HomePage (or any other screen you want)
      Navigator.pushReplacementNamed(context, '/auth');
    }
  }

  @override
  void dispose() {
    widget.controller.removeListener(_onVideoPlayStatusUpdate);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: AspectRatio(
              aspectRatio: widget.controller.value.aspectRatio,
              child: VideoPlayer(widget.controller),
            ),
          ),
          Positioned.fill(
            child: Container(
              color: Colors.black.withOpacity(0.3),
            ),
          ),
        ],
      ),
    );
  }
}
