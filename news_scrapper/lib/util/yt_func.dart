import 'dart:convert';
import 'package:http/http.dart' as http;

final String backendUrl =
    "http://192.0.0.2:5000"; // Use your phone's IP address

Future<List<dynamic>> searchYouTube(String query) async {
  final url = Uri.parse("$backendUrl/search?query=$query");
  final response = await http.get(url);

  if (response.statusCode == 200) {
    return jsonDecode(response.body);
  } else {
    throw Exception("Failed to fetch search results");
  }
}

Future<void> downloadVideo(String url, Function(double) onProgress) async {
  var response = await http.post(
    Uri.parse('$backendUrl/download'),
    headers: {'Content-Type': 'application/json'},
    body: jsonEncode({'url': url}),
  );

  if (response.statusCode == 200) {
    // Simulate download progress
    for (double progress = 0; progress <= 1.0; progress += 0.1) {
      await Future.delayed(Duration(milliseconds: 200));
      onProgress(progress);
    }
  } else {
    throw Exception('Failed to download video');
  }
}
