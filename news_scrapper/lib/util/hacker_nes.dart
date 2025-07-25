import 'package:http/http.dart' as http;
import 'package:html/parser.dart' as html_parser;
import 'package:html/dom.dart';

class WebScraper {
  // Function to fetch website content
  Future<String> fetchWebsiteData(String url) async {
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception('Failed to load website');
    }
  }

  // Function to extract news headlines
  Future<List<Map<String, String>>> scrapeNews() async {
    String url = "https://news.ycombinator.com/";
    List<Map<String, String>> newsList = [];

    try {
      String htmlData = await fetchWebsiteData(url);
      Document document = html_parser.parse(htmlData);

      // Find elements with class "titleline"
      List<Element> newsElements = document.getElementsByClassName('title');

      for (var element in newsElements) {
        String title = element.text.trim();
        String? link = element.querySelector("a")?.attributes['href'];

        if (link != null) {
          newsList.add({"title": title, "link": link});
        }
      }
    } catch (e) {
      print("Error: $e");
    }

    return newsList;
  }
}
