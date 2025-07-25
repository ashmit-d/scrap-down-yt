import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_scrapper/util/audio_controller.dart';

class DisplayPage extends StatelessWidget {
  final AudioController controller = Get.put(AudioController());

  @override
  Widget build(BuildContext context) {
    TextEditingController searchController = TextEditingController();

    return Scaffold(
      appBar: AppBar(title: Text("YouTube Audio Downloader")),
      backgroundColor: Colors.red,
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(10),
            child: TextField(
              controller: searchController,
              decoration: InputDecoration(
                hintText: "Search YouTube...",
                suffixIcon: IconButton(
                  icon: Icon(Icons.search),
                  onPressed:
                      () => controller.searchVideos(searchController.text),
                ),
              ),
              onSubmitted: (value) => controller.searchVideos(value),
            ),
          ),
          Expanded(
            child: Obx(
              () =>
                  controller.isLoading.value
                      ? Center(child: CircularProgressIndicator())
                      : controller.videos.isEmpty
                      ? Center(child: Text("No results found."))
                      : ListView.builder(
                        itemCount: controller.videos.length,
                        itemBuilder: (context, index) {
                          var video = controller.videos[index];
                          var title = video['title'] ?? 'No Title';
                          var url = video['url'] ?? 'No URL';
                          var videoId = Uri.parse(url).queryParameters['v'];

                          // Thumbnail URL (if videoId exists)
                          var thumbnailUrl =
                              videoId != null
                                  ? 'https://img.youtube.com/vi/$videoId/hqdefault.jpg'
                                  : null;

                          return Card(
                            color: Colors.red,
                            margin: EdgeInsets.symmetric(
                              vertical: 5,
                              horizontal: 10,
                            ),
                            child: ListTile(
                              leading:
                                  thumbnailUrl != null
                                      ? Image.network(
                                        thumbnailUrl,
                                        width: 50,
                                        height: 50,
                                        fit: BoxFit.cover,
                                        errorBuilder: (
                                          context,
                                          error,
                                          stackTrace,
                                        ) {
                                          return Icon(
                                            Icons.image_not_supported,
                                            size: 50,
                                          );
                                        },
                                      )
                                      : Icon(
                                        Icons.image_not_supported,
                                        size: 50,
                                      ),
                              title: Text(
                                title,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              subtitle: Text(
                                url,
                                style: TextStyle(color: Colors.white70),
                              ),
                              trailing: IconButton(
                                icon: Icon(Icons.download, color: Colors.white),
                                onPressed:
                                    () => controller.download(url, "audio"),
                              ),
                            ),
                          );
                        },
                      ),
            ),
          ),
          Obx(
            () =>
                controller.downloadProgress.value > 0
                    ? LinearProgressIndicator(
                      value: controller.downloadProgress.value,
                    )
                    : SizedBox.shrink(),
          ),
        ],
      ),
    );
  }
}
