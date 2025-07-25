import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_scrapper/util/controller.dart';

class HomeScreen extends StatelessWidget {
  final VideoController controller = Get.put(VideoController());

  @override
  Widget build(BuildContext context) {
    TextEditingController searchController = TextEditingController();

    return Scaffold(
      appBar: AppBar(title: Text("YouTube Downloader")),
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
              onSubmitted: (value) {
                controller.searchVideos(value);
              },
            ),
          ),
          Expanded(
            child: Obx(
              () =>
                  controller.isLoading.value
                      ? Center(child: CircularProgressIndicator())
                      : ListView.builder(
                        itemCount: controller.videos.length,
                        itemBuilder: (context, index) {
                          var video = controller.videos[index];
                          var title = video['title'] ?? 'No Title';
                          var url = video['url'] ?? 'No URL';

                          // Extract Video ID from URL
                          var videoId = Uri.parse(url).queryParameters['v'];

                          // Thumbnail URL (if videoId exists)
                          var thumbnailUrl =
                              videoId != null
                                  ? 'https://img.youtube.com/vi/$videoId/hqdefault.jpg'
                                  : null;

                          return Card(
                            color: Colors.red,
                            child: ListTile(
                              leading:
                                  thumbnailUrl != null
                                      ? Image.network(
                                        thumbnailUrl,
                                        width: 100,
                                        fit: BoxFit.cover,
                                      )
                                      : SizedBox(
                                        width: 100,
                                      ), // Placeholder if no thumbnail
                              title: Text(title),
                              subtitle: Text(url),
                              trailing: IconButton(
                                icon: Icon(Icons.download),
                                onPressed: () => controller.download(url),
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
