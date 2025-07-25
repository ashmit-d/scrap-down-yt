import 'package:get/get.dart';
import 'package:news_scrapper/util/yt_func.dart'; // Import API functions

class VideoController extends GetxController {
  var videos =
      <Map<String, dynamic>>[]
          .obs; // Changed from [].obs to <Map<String, dynamic>>[].obs
  var isLoading = false.obs;
  var downloadProgress = 0.0.obs;

  void searchVideos(String query) async {
    isLoading(true);
    try {
      var results = await searchYouTube(query);

      videos.assignAll(results.cast<Map<String, dynamic>>());
      print("Videos loaded successfully");
    } catch (e) {
      print("Error: $e");
    } finally {
      isLoading(false);
    }
  }

  void download(String url) async {
    try {
      downloadProgress(0.0);
      await downloadVideo(url, (progress) {
        downloadProgress(progress);
      });
      Get.snackbar("Download", "Download completed!");
    } catch (e) {
      print("Download Error: $e");
    }
  }
}
