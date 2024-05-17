import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:video_player/video_player.dart';

class FullScreenVideoPlayer extends StatefulWidget {
  final VideoPlayerController controller;
  const FullScreenVideoPlayer({required this.controller});

  @override
  State<FullScreenVideoPlayer> createState() => _FullScreenVideoPlayerState();
}

class _FullScreenVideoPlayerState extends State<FullScreenVideoPlayer> {
  bool _isPlaying = false;
  bool _showControls = true;
  Timer? _hideTimer;

  @override
  void initState() {
    widget.controller.addListener(_videoPlayerListener);
    _isPlaying = widget.controller.value.isPlaying;
    _startHideTimer();
  }

  void _videoPlayerListener() {
    if (mounted) {
      setState(() {
        _isPlaying = widget.controller.value.isPlaying;
      });
    }
  }

  @override
  void dispose() {
    _hideTimer?.cancel();
    super.dispose();
  }

  void _togglePlayPause() {
    if (mounted) {
      setState(() {
        if (widget.controller.value.isPlaying) {
          widget.controller.pause();
        } else {
          widget.controller.play();
        }
      });
    }
  }

  //Dùng để khi chạm vào thì sẽ hiển thị các nút
  void _toggleShowControl() {
    if (mounted) {
      setState(() {
        _showControls = !_showControls;
      });
      if (_showControls) {
        _startHideTimer();
      }
    }
  }

  void _startHideTimer() {
    _hideTimer?.cancel();
    _hideTimer = Timer(const Duration(seconds: 5), () {
      if (mounted) {
        setState(() {
          _showControls = false;
        });
      }
    });
  }

  void _showControlsOnMouseHover() {
    if (mounted) {
      setState(() {
        _showControls = true;
      });
      _startHideTimer();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: MouseRegion(
          onHover: (_) => _showControlsOnMouseHover(),
          child: Stack(
            alignment: Alignment.center,
            children: [
              AspectRatio(
                aspectRatio: widget.controller.value.aspectRatio,
                child: VideoPlayer(widget.controller),
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
                    icon: const Icon(Icons.fullscreen_exit,
                        color: Colors.white, size: 30.0),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
