import 'dart:convert';
import 'package:http/http.dart' as http;

final String backendUrl =
    "http://192.0.0.2:5000"; // Use your phone's IP address

Future<List<dynamic>> searchYouTube(String query) async {
  final url = Uri.parse("$backendUrl/search?query=$query");
  final response = await http.get(url);

  if (response.statusCode == 200) {
    var data = jsonDecode(response.body);
    var videos =
        data['items'].map((item) {
          return {
            'title': item['snippet']['title'],
            'url': 'https://www.youtube.com/watch?v=${item['id']['videoId']}',
            'thumbnail':
                item['snippet']['thumbnails']['default']['url'], // Extract the thumbnail URL
          };
        }).toList();

    print("Videos data: $videos"); // Log videos data to check structure
    return videos;
  } else {
    throw Exception("Failed to fetch search results");
  }
}

Future<void> downloadAudio(
  String url,
  String option,
  Function(double) onProgress,
) async {
  var response = await http.post(
    Uri.parse('$backendUrl/download'),
    headers: {'Content-Type': 'application/json'},
    body: jsonEncode({'url': url, 'option': option}),
  );

  if (response.statusCode == 200) {
    for (double progress = 0; progress <= 1.0; progress += 0.1) {
      await Future.delayed(Duration(milliseconds: 200));
      onProgress(progress);
    }
  } else {
    throw Exception('Failed to download audio');
  }
}
