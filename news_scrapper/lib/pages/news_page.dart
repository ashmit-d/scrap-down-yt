import 'package:flutter/material.dart';
import 'package:news_scrapper/pages/display_pages/allnews_display.dart';
import 'package:news_scrapper/util/animated_backgroud.dart';
import 'package:news_scrapper/util/hacker_nes.dart';
import 'package:news_scrapper/util/yo_tile.dart';

class NewsPage extends StatefulWidget {
  const NewsPage({super.key});

  @override
  State<NewsPage> createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  List<Map<String, String>> newsList = [];
  //function to navigate to the scraper screen with a selected category:

  Future<void> fetchNews() async {
    WebScraper scraper = WebScraper();
    List<Map<String, String>> data = await scraper.scrapeNews();

    setState(() {
      newsList = data;
    });
  }

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
            'Choose website for news.!',
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
              title: "Sports news",
              description: "latest sports news",
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
                          url: "https://www.espn.in/",
                          backgroundColor: Colors.yellow,
                        ),
                  ),
                );
              },
            ),

            YoTile(
              title: "Movie News",
              description: "Get the latest news on Movies",
              color: Colors.yellow,
              delay: const Duration(milliseconds: 200),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder:
                        (context) => AffairDisplay(
                          url: "https://www.variety.com/v/film/news/",
                          backgroundColor: Colors.yellow,
                        ),
                  ),
                );
              },
            ),
            YoTile(
              title: "BBC News",
              description: "Get the latest world news from BBC.",
              color: Colors.blueGrey,
              delay: const Duration(milliseconds: 400),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder:
                        (context) => AffairDisplay(
                          url: "https://www.bbc.com/news",
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
