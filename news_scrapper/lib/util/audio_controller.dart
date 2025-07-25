import 'package:get/get.dart';
import 'package:news_scrapper/util/yt_audio_func.dart' show downloadAudio;
import 'yt_func.dart';

class AudioController extends GetxController {
  var videos = [].obs;
  var isLoading = false.obs;
  var downloadProgress = 0.0.obs;

  void searchVideos(String query) async {
    isLoading(true);
    try {
      var results = await searchYouTube(
        query,
      ); // Call the updated searchYouTube function
      videos.assignAll(results); // Assign the list of videos
    } finally {
      isLoading(false);
    }
  }

  void download(String url, String option) async {
    downloadProgress(0.0);
    await downloadAudio(url, option, (progress) {
      downloadProgress(progress);
    });
  }
}
