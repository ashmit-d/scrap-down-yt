import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:io';
import 'package:path/path.dart' as p;
import 'package:video_player/video_player.dart';
import 'package:chewie/chewie.dart';

class OfflineVideoPage extends StatefulWidget {
  const OfflineVideoPage({Key? key}) : super(key: key);

  @override
  _OfflineVideoPageState createState() => _OfflineVideoPageState();
}

class _OfflineVideoPageState extends State<OfflineVideoPage> {
  List<FileSystemEntity> videoFiles = [];
  VideoPlayerController? _controller;
  ChewieController? _chewieController;
  bool isPlaying = false;
  int currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _requestPermission();
  }

  Future<void> _requestPermission() async {
    if (await Permission.storage.request().isGranted ||
        await Permission.manageExternalStorage.request().isGranted) {
      _fetchVideoFiles();
    } else {
      openAppSettings();
    }
  }

  Future<void> _fetchVideoFiles() async {
    final Directory dir = Directory('/storage/emulated/0/Download/downloads');
    if (await dir.exists()) {
      final List<FileSystemEntity> files =
          dir.listSync().where((file) {
            final ext = p.extension(file.path).toLowerCase();
            return ['.mp4', '.mkv', '.avi'].contains(ext);
          }).toList();

      setState(() {
        videoFiles = files;
      });

      if (files.isNotEmpty) {
        _initializeAndPlay(0);
      }
    }
  }

  Future<void> _initializeAndPlay(int index) async {
    _controller?.dispose();
    _chewieController?.dispose();

    _controller =
        VideoPlayerController.file(File(videoFiles[index].path))
          ..addListener(() {
            if (mounted) setState(() {});
          })
          ..initialize().then((_) {
            setState(() {});
            _controller!.play();
          });

    _chewieController = ChewieController(
      videoPlayerController: _controller!,
      autoPlay: true,
      looping: false,
      allowFullScreen: true,
    );

    setState(() {
      currentIndex = index;
      isPlaying = true;
    });
  }

  void _playPause() {
    setState(() {
      if (_controller!.value.isPlaying) {
        _controller!.pause();
        isPlaying = false;
      } else {
        _controller!.play();
        isPlaying = true;
      }
    });
  }

  void _nextVideo() {
    if (currentIndex < videoFiles.length - 1) {
      _initializeAndPlay(currentIndex + 1);
    }
  }

  void _previousVideo() {
    if (currentIndex > 0) {
      _initializeAndPlay(currentIndex - 1);
    }
  }

  @override
  void dispose() {
    _controller?.dispose();
    _chewieController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Offline Videos'),
        backgroundColor: Colors.yellow,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: videoFiles.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(p.basename(videoFiles[index].path)),
                  onTap: () => _initializeAndPlay(index),
                );
              },
            ),
          ),
          if (_chewieController != null && _controller!.value.isInitialized)
            AspectRatio(
              aspectRatio: _controller!.value.aspectRatio,
              child: Chewie(controller: _chewieController!),
            ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(
                icon: Icon(Icons.skip_previous),
                onPressed: _previousVideo,
              ),
              IconButton(
                icon: Icon(isPlaying ? Icons.pause : Icons.play_arrow),
                onPressed: _playPause,
              ),
              IconButton(icon: Icon(Icons.skip_next), onPressed: _nextVideo),
            ],
          ),
        ],
      ),
      backgroundColor: Colors.yellow,
    );
  }
}
