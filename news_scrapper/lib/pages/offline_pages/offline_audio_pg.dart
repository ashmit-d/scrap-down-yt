import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:io';
import 'package:path/path.dart' as p;
import 'package:audioplayers/audioplayers.dart';

class OfflineAudioPage extends StatefulWidget {
  const OfflineAudioPage({super.key});

  @override
  _OfflineAudioPageState createState() => _OfflineAudioPageState();
}

class _OfflineAudioPageState extends State<OfflineAudioPage> {
  List<FileSystemEntity> audioFiles = [];
  final AudioPlayer _audioPlayer = AudioPlayer();
  bool isShuffle = false;
  bool isPlaying = false;
  String? currentAudioPath;
  int currentIndex = 0;
  Duration currentPosition = Duration.zero;
  Duration totalDuration = Duration.zero;

  @override
  void initState() {
    super.initState();
    _requestPermission();
    _audioPlayer.onDurationChanged.listen((duration) {
      setState(() {
        totalDuration = duration;
      });
    });

    _audioPlayer.onPositionChanged.listen((position) {
      setState(() {
        currentPosition = position;
      });
    });

    _audioPlayer.onPlayerComplete.listen((event) {
      _nextTrack();
    });
  }

  // Requesting permission before accessing files
  Future<void> _requestPermission() async {
    if (await Permission.storage.request().isGranted ||
        await Permission.manageExternalStorage.request().isGranted) {
      print("Storage permission granted");
      _fetchAudioFiles();
    } else if (await Permission.storage.isDenied ||
        await Permission.manageExternalStorage.isDenied) {
      print("Storage permission denied");
    } else if (await Permission.storage.isPermanentlyDenied ||
        await Permission.manageExternalStorage.isPermanentlyDenied) {
      print("Permission permanently denied. Please enable it from settings.");
      openAppSettings();
    }
  }

  Future<void> _fetchAudioFiles() async {
    final Directory dir = Directory('/storage/emulated/0/Download/downloads');
    if (await dir.exists()) {
      final List<FileSystemEntity> files =
          dir.listSync().where((file) {
            final String ext = p.extension(file.path).toLowerCase();
            return ext == '.mp3' || ext == '.wav' || ext == '.m4a';
          }).toList();

      setState(() {
        audioFiles = files;
      });
    }
  }

  Future<void> _playAudio(String path) async {
    if (isPlaying && currentAudioPath == path) {
      await _audioPlayer.pause();
      setState(() {
        isPlaying = false;
      });
    } else {
      await _audioPlayer.setSource(DeviceFileSource(path));
      await _audioPlayer.resume();
      setState(() {
        isPlaying = true;
        currentAudioPath = path;
      });
    }
  }

  Future<void> _nextTrack() async {
    if (audioFiles.isEmpty) return;

    if (isShuffle) {
      int nextIndex;
      do {
        nextIndex =
            (audioFiles.length *
                    (DateTime.now().millisecondsSinceEpoch % 1000) /
                    1000)
                .floor();
      } while (nextIndex == currentIndex && audioFiles.length > 1);
      currentIndex = nextIndex;
    } else {
      if (currentIndex < audioFiles.length - 1) {
        currentIndex++;
      } else {
        return;
      }
    }

    _playAudio(audioFiles[currentIndex].path);
  }

  Future<void> _previousTrack() async {
    if (currentIndex > 0) {
      currentIndex--;
      _playAudio(audioFiles[currentIndex].path);
    }
  }

  void _seekAudio(double value) {
    final position = Duration(seconds: value.toInt());
    _audioPlayer.seek(position);
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return "$minutes:$seconds";
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Offline Audios'),
        backgroundColor: Colors.yellow,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child:
                  audioFiles.isEmpty
                      ? const Center(child: Text("No audio files found."))
                      : ListView.builder(
                        itemCount: audioFiles.length,
                        itemBuilder: (context, index) {
                          final file = audioFiles[index];
                          final isSelected =
                              file.path == currentAudioPath && isPlaying;

                          return ListTile(
                            leading: Icon(
                              isSelected
                                  ? Icons.pause_circle
                                  : Icons.play_circle,
                              color: Colors.black,
                            ),
                            title: Text(p.basename(file.path)),
                            onTap: () {
                              setState(() {
                                currentIndex = index;
                              });
                              _playAudio(file.path);
                            },
                          );
                        },
                      ),
            ),
            if (currentAudioPath != null)
              Column(
                children: [
                  Slider(
                    value: currentPosition.inSeconds.toDouble(),
                    max: totalDuration.inSeconds.toDouble(),
                    onChanged: (value) => _seekAudio(value),
                  ),
                  Text(
                    '${_formatDuration(currentPosition)} / ${_formatDuration(totalDuration)}',
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      IconButton(
                        icon: Icon(
                          Icons.shuffle,
                          color: isShuffle ? Colors.deepPurple : Colors.black,
                        ),
                        iconSize: 36,
                        onPressed: () {
                          setState(() {
                            isShuffle = !isShuffle;
                          });
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.skip_previous),
                        iconSize: 48,
                        onPressed: _previousTrack,
                      ),
                      IconButton(
                        icon: Icon(isPlaying ? Icons.pause : Icons.play_arrow),
                        iconSize: 64,
                        onPressed: () => _playAudio(currentAudioPath!),
                      ),
                      IconButton(
                        icon: Icon(Icons.skip_next),
                        iconSize: 48,
                        onPressed: _nextTrack,
                      ),
                    ],
                  ),
                ],
              ),
          ],
        ),
      ),
      backgroundColor: Colors.yellow,
    );
  }
}
