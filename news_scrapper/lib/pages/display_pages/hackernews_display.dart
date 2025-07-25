import 'package:flutter/material.dart';
import 'package:news_scrapper/util/hacker_nes.dart'; // Import your WebScraper class
import 'package:url_launcher/url_launcher.dart';

class NewsDisplayPage extends StatefulWidget {
  const NewsDisplayPage({super.key});

  @override
  _NewsDisplayPageState createState() => _NewsDisplayPageState();
}

class _NewsDisplayPageState extends State<NewsDisplayPage> {
  final WebScraper _scraper = WebScraper();
  List<Map<String, String>> newsList = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchNews();
  }

  Future<void> _fetchNews() async {
    List<Map<String, String>> news = await _scraper.scrapeNews();
    setState(() {
      newsList = news;
      isLoading = false;
    });
  }

  void _openLink(String url) async {
    Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      print("Could not launch $url");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green,
      appBar: AppBar(
        title: const Text("Latest News"),
        backgroundColor: Colors.green,
      ),
      body:
          isLoading
              ? const Center(child: CircularProgressIndicator())
              : newsList.isEmpty
              ? const Center(child: Text("No news available."))
              : ListView.builder(
                itemCount: newsList.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(newsList[index]["title"] ?? "No Title"),
                    subtitle: Text(newsList[index]["link"] ?? "No Link"),
                    onTap: () {
                      String? url = newsList[index]["link"];
                      if (url != null && url.isNotEmpty) {
                        _openLink(url);
                      }
                    },
                  );
                },
              ),
    );
  }
}
