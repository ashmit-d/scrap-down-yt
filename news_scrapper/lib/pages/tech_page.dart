import 'package:flutter/material.dart';
import 'package:news_scrapper/pages/display_pages/allnews_display.dart';
import 'package:news_scrapper/pages/display_pages/hackernews_display.dart';
import 'package:news_scrapper/util/animated_backgroud.dart';
import 'package:news_scrapper/util/yo_tile.dart';

class TechPage extends StatefulWidget {
  const TechPage({super.key});

  @override
  State<TechPage> createState() => _TechPageState();
}

class _TechPageState extends State<TechPage> {
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
            "Choose Website for latest tech.!",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w600,
              color: const Color.fromARGB(255, 255, 255, 255),
              letterSpacing: 0,
              wordSpacing: 1,
            ),
          ),
          centerTitle: true,
          elevation: 0,
          backgroundColor: Colors.transparent,
        ),
        body: Column(
          children: [
            YoTile(
              title: "Ars Technica",
              description: "latest tech news",
              color: Colors.blue,
              delay: const Duration(
                milliseconds: 0,
              ), // You can change this dynamically
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder:
                        (context) => AffairDisplay(
                          url: "https://arstechnica.com/gadgets/",
                          backgroundColor: Colors.yellow,
                        ),
                  ),
                );
              },
            ),
            YoTile(
              title: "Hacker news",
              description: "Latest tech news",
              color: Colors.green,
              delay: const Duration(milliseconds: 200),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const NewsDisplayPage(),
                  ),
                );
              },
            ),

            YoTile(
              title: "Tech spot",
              description: "latest tech news",
              color: Colors.blueGrey,
              delay: const Duration(
                milliseconds: 400,
              ), // You can change this dynamically
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder:
                        (context) => AffairDisplay(
                          url: "https://www.techspot.com/",
                          backgroundColor: Colors.white,
                        ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
