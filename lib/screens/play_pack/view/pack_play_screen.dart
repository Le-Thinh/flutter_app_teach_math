import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_app_teach2/services/pack/pack_service.dart';
import 'package:video_player/video_player.dart';

import 'play_video_fullscreen.dart';

class PlayPackScreen extends StatefulWidget {
  String packId;
  PlayPackScreen({required this.packId, super.key});

  @override
  State<PlayPackScreen> createState() => _PlayPackScreenState();
}

class _PlayPackScreenState extends State<PlayPackScreen> {
  String lessName = "";
  String videoUrl = "";
  String description = "";
  bool _isPlaying = false;
  bool _showControls = true;
  Timer? _hideTimer;

  PackService packService = PackService();
  VideoPlayerController? _controller;
  @override
  void initState() {
    packService.getLessonNameById(widget.packId).then((value) {
      setState(() {
        lessName = packService.getLessonName;
      });
    });

    packService.getDescriptionById(widget.packId).then((value) {
      setState(() {
        description = packService.description;
      });
    });

    packService.getVideoUrlById(widget.packId).then((value) {
      setState(() {
        videoUrl = packService.videoUrl;
        Uri videoUri =
            Uri.parse(videoUrl); // Chuyển đổi videoUrl từ String sang Uri
        _controller = VideoPlayerController.network(videoUri.toString())
          ..initialize().then((_) {
            setState(() {});
          });
        _controller?.addListener(() {
          setState(() {
            _isPlaying = _controller!.value.isPlaying;
          });
        });
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    _controller?.dispose();
    _hideTimer?.cancel();
    super.dispose();
  }

  //Play video
  void _togglePlayPause() {
    setState(() {
      if (_controller!.value.isPlaying) {
        _controller!.pause();
      } else {
        _controller!.play();
      }
    });
  }

  //Ẩn icon sau 5 giây
  void _startHideTimer() {
    _hideTimer?.cancel();
    _hideTimer = Timer(const Duration(seconds: 5), () {
      setState(() {
        _showControls = false;
      });
    });
  }

  void _showControlsOnMouseHover() {
    setState(() {
      _showControls = true;
    });
    _startHideTimer();
  }

  void _goFullScreen() {
    if (_controller != null) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => FullScreenVideoPlayer(controller: _controller!),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue.shade50,
        title: Text("Lesson: " + lessName),
      ),
      body: Column(
        children: [
          // Video player
          if (_controller != null && _controller!.value.isInitialized)
            MouseRegion(
              onHover: (_) => _showControlsOnMouseHover(),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  AspectRatio(
                    aspectRatio: _controller!.value.aspectRatio,
                    child: VideoPlayer(_controller!),
                  ),
                  if (_showControls)
                    GestureDetector(
                      onTap: _togglePlayPause,
                      child: Container(
                        color: Colors.transparent,
                        child: Icon(
                          _isPlaying ? Icons.pause : Icons.play_arrow,
                          size: 80.0,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  if (_showControls)
                    Positioned(
                      bottom: 10,
                      right: 10,
                      child: IconButton(
                        color: Colors.grey,
                        icon: const Icon(Icons.fullscreen,
                            color: Colors.white, size: 30.0),
                        onPressed: _goFullScreen,
                      ),
                    ),
                  if (_showControls)
                    Positioned(
                        bottom: 10,
                        left: 10,
                        right: 50,
                        child: VideoProgressIndicator(
                          _controller!,
                          allowScrubbing: true,
                        ))
                ],
              ),
            )
          else
            const CircularProgressIndicator(),

          Expanded(
            child: Container(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                description,
                style: const TextStyle(fontSize: 16.0),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
