import 'package:html/parser.dart' as html_parser;
import 'package:http/http.dart' as http;

Future<List<Map<String, String>>> fetchMovieNews(String url) async {
  try {
    var response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      var document = html_parser.parse(response.body);
      var newsList = <Map<String, String>>[];

      var articles = document.querySelectorAll("article a");

      for (var article in articles) {
        String? title = article.text.trim();
        String? link = article.attributes["href"];

        if (title.isNotEmpty && link != null) {
          newsList.add({
            "title": title,
            "link": link.startsWith("http") ? link : "$url$link",
          });
        }
      }

      return newsList;
    } else {
      print("Failed to load page: ${response.statusCode}");
      return [];
    }
  } catch (e) {
    print("Error: $e");
    return [];
  }
}
