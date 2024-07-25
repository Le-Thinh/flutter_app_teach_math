import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_app_teach2/models/finished/finish.dart';
import 'package:flutter_app_teach2/repositories/finish_repository.dart';
import 'package:flutter_app_teach2/screens/game/game_screen.dart';
import 'package:flutter_app_teach2/services/pack/pack_service.dart';
import 'package:flutter_app_teach2/widget/pack_list_vertical.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:video_player/video_player.dart';

import 'play_video_fullscreen.dart';

class PlayPackScreen extends StatefulWidget {
  final String packId;
  final String userId;
  const PlayPackScreen({required this.packId, required this.userId, super.key});

  @override
  State<PlayPackScreen> createState() => _PlayPackScreenState();
}

class _PlayPackScreenState extends State<PlayPackScreen>
    with WidgetsBindingObserver {
  String lessName = "";
  String videoUrl = "";
  String description = "";
  bool _isPlaying = false;
  bool _showControls = true;
  Timer? _hideTimer;
  Stream<QuerySnapshot>? packStream;
  String title = "";
  Timer? _progressTimer;
  bool _canClickFAB = false;
  Duration _videoDuration = Duration.zero;
  Duration _currentPosition = Duration.zero;
  Duration _viewedTime = Duration.zero;
  bool _isPlayingPreviously = false;

  PackService packService = PackService();
  FinishRepository finishRepository = FinishRepository();
  VideoPlayerController? _controller;

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);

    if (state == AppLifecycleState.paused) {
      _controller?.pause();
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
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

    packService.getPackData().then((stream) {
      setState(() {
        packStream = stream;
      });
    });

    packService.getTitleById(widget.packId).then((value) {
      setState(() {
        title = packService.getTitle;
      });
    });

    packService.getVideoUrlById(widget.packId).then((value) {
      setState(() {
        videoUrl = packService.videoUrl;
        Uri videoUri = Uri.parse(videoUrl);
        _controller = VideoPlayerController.network(videoUri.toString())
          ..initialize().then((_) {
            setState(() {
              _videoDuration = _controller!.value.duration;
              print("Video Duration ${_videoDuration.inSeconds}");
            });
            _startProgressTimer();
          });

        _controller?.addListener(() {
          setState(() {
            _isPlaying = _controller!.value.isPlaying;
            _currentPosition = _controller!.value.position;

            if (_isPlaying) {
              _viewedTime += const Duration(seconds: 100);
            }
            _updateFABState();
          });
        });
      });
    });
  }

  @override
  void dispose() {
    if (_controller != null && _controller!.value.isPlaying) {
      _controller!.pause();
    }
    WidgetsBinding.instance.removeObserver(this);
    _controller?.removeListener(() {});
    _controller?.dispose();
    _hideTimer?.cancel();
    _progressTimer?.cancel();
    super.dispose();
  }

  void _startProgressTimer() {
    _progressTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_controller != null && _controller!.value.isInitialized) {
        if (mounted) {
          setState(() {
            _currentPosition = _controller!.value.position;
            _updateFABState();
          });
        }
      }
    });
  }

  void _updateFABState() {
    if (_videoDuration.inSeconds > 0 &&
        _viewedTime.inSeconds >= (_videoDuration.inSeconds * 2 / 3)) {
      if (mounted) {
        setState(() {
          _canClickFAB = true;
        });
      }
    } else {
      if (mounted) {
        setState(() {
          _canClickFAB = false;
        });
      }
    }
  }

  // Play video
  void _togglePlayPause() {
    setState(() {
      if (_controller!.value.isPlaying) {
        _controller!.pause();
        _isPlayingPreviously = true;
      } else {
        _controller!.play();
        _isPlayingPreviously = true;
      }
    });
  }

  // Hide controls after 5 seconds
  void _startHideTimer() {
    _hideTimer?.cancel();
    _hideTimer = Timer(const Duration(seconds: 5), () {
      setState(() {
        _showControls = false;
      });
    });
  }

  void _cancelVideo() {
    setState(() {
      _controller!.pause();
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
        title: Text("Lesson: ${lessName}"),
      ),
      body: ListView(
        children: [
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
                        )),
                ],
              ),
            )
          else
            const CircularProgressIndicator(),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              description,
              style: const TextStyle(fontSize: 16.0),
            ),
          ),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.only(top: 8.0, bottom: 8, left: 16),
            child: Text(
              "Other Lesson",
              style: GoogleFonts.acme(
                  textStyle: const TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.w400,
              )),
            ),
          ),
          packListVertical(packStream, title, widget.packId),
          const SizedBox(height: 16),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _canClickFAB
            ? () {
                Finish finish = Finish.empty;
                finish.finishAt = DateTime.now();
                finish.packId = widget.packId;
                finish.userId = widget.userId;

                finishRepository.setDataFinish(finish);

                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const GameScreen()));

                _cancelVideo();
              }
            : null,
        child: const Icon(
          Icons.arrow_right_alt_outlined,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
