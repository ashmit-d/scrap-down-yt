import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_scrapper/pages/display_pages/youtube_display.dart';
import 'package:news_scrapper/pages/display_pages/yt_audio_display.dart';
import 'package:news_scrapper/util/animated_backgroud.dart';
import 'package:news_scrapper/util/yo_tile.dart';

class VideoPage extends StatefulWidget {
  const VideoPage({super.key});

  @override
  State<VideoPage> createState() => _VideoPageState();
}

class _VideoPageState extends State<VideoPage> {
  @override
  Widget build(BuildContext context) {
    return AnimatedBackground(
      colors: const [
        Color.fromARGB(255, 0, 0, 0),
        Color.fromARGB(255, 53, 58, 53),
        Color.fromARGB(255, 124, 115, 115),
      ],
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          iconTheme: const IconThemeData(color: Colors.white),
          title: Text(
            "Choose Website.!",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w600,
              color: const Color.fromARGB(255, 255, 255, 255),
              letterSpacing: 1,
              wordSpacing: 2,
            ),
          ),
          centerTitle: true,
          elevation: 0,
          backgroundColor: Colors.transparent,
        ),
        body: Column(
          children: [
            YoTile(
              title: "YTS",
              description: "Torrent movies.!",
              color: Colors.blue,
              delay: const Duration(milliseconds: 0),
              onTap: () {},
            ),
            YoTile(
              title: "Youtube audio",
              description: "Search and download youtube (Audio Only)",
              color: Colors.green,
              delay: const Duration(milliseconds: 200),
              onTap: () {
                Get.to(() => DisplayPage());
              },
            ),
            YoTile(
              title: "YouTube",
              description: "Search and download youtube videos ",
              color: Colors.red,
              delay: const Duration(milliseconds: 400),
              onTap: () {
                Get.to(() => HomeScreen());
              },
            ),
          ],
        ),
      ),
    );
  }
}
