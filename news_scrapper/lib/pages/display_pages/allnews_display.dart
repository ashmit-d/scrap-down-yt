import 'package:flutter/material.dart';
import 'package:news_scrapper/util/allnews_scrape.dart';
import 'package:news_scrapper/util/animated_backgroud.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:intl/intl.dart'; // For timestamp formatting

class AffairDisplay extends StatefulWidget {
  final String url;
  final Color backgroundColor; // Accept color dynamically

  const AffairDisplay({
    super.key,
    required this.url,
    required this.backgroundColor,
  });

  @override
  _AffairDisplayState createState() => _AffairDisplayState();
}

class _AffairDisplayState extends State<AffairDisplay> {
  List<Map<String, String>> newsList = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchNews();
  }

  Future<void> _fetchNews() async {
    List<Map<String, String>> news = await fetchMovieNews(widget.url);
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

  Future<void> _saveContentToFile() async {
    if (newsList.isEmpty) return;

    final dir = await getApplicationDocumentsDirectory();
    final savedDir = Directory('${dir.path}/saved_pages');

    if (!await savedDir.exists()) {
      await savedDir.create(recursive: true);
    }

    final timestamp = DateFormat('yyyyMMdd_HHmmss').format(DateTime.now());
    final file = File('${savedDir.path}/news_$timestamp.txt');

    String content = newsList
        .map((item) {
          return 'Title: ${item["title"]}\nLink: ${item["link"]}\n';
        })
        .join('\n');

    await file.writeAsString(content);

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('News saved as news_$timestamp.txt')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBackground(
      colors: const [
        Color.fromARGB(255, 3, 255, 255),
        Color.fromARGB(255, 0, 255, 106),
        Color.fromARGB(255, 252, 252, 252),
      ],
      child: Scaffold(
        backgroundColor: Colors.transparent, // Dynamic background color
        appBar: AppBar(
          title: Text("News from ${widget.url}"),
          backgroundColor: Colors.transparent,
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

        floatingActionButton: FloatingActionButton.extended(
          onPressed: _saveContentToFile,
          label: const Text('Save'),
          icon: const Icon(Icons.save_alt),
          backgroundColor: Colors.green,
        ),
      ),
    );
  }
}
