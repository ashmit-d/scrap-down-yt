import 'package:flutter/material.dart';
import 'package:news_scrapper/pages/home_page.dart';
import 'package:get/get.dart';
import 'package:news_scrapper/pages/offline_pages/offline_audio_pg.dart';
import 'package:news_scrapper/pages/offline_pages/offline_news_pg.dart';
import 'package:news_scrapper/pages/offline_pages/offline_video_pg.dart';
import 'package:news_scrapper/util/about_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
      theme: ThemeData(primarySwatch: Colors.grey),
      getPages: [
        GetPage(name: '/home', page: () => HomePage()),
        GetPage(
          name: '/offline-news',
          page: () => OfflineNewsPage(),
          transition: Transition.leftToRight,
        ),
        GetPage(
          name: '/offline-audio',
          page: () => OfflineAudioPage(),
          transition: Transition.leftToRight,
        ),
        GetPage(
          name: '/offline-video',
          page: () => OfflineVideoPage(),
          transition: Transition.leftToRight,
        ),
        GetPage(
          name: '/about-the-dev',
          page: () => AboutDeveloperPage(),
          transition: Transition.leftToRight,
        ),
      ],
    );
  }
}
