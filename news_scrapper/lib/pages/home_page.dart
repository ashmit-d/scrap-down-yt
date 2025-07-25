import 'package:flutter/material.dart';
import 'package:news_scrapper/pages/news_page.dart';
import 'package:news_scrapper/pages/tech_page.dart';
import 'package:news_scrapper/pages/video_page.dart';
import 'package:news_scrapper/util/animated_backgroud.dart';
import 'package:news_scrapper/util/yo_tile.dart';
import 'package:get/get.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Widget _buildDrawerItem({
    required IconData icon,
    required String text,
    required Color color,
    required VoidCallback onTap,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
      child: Material(
        color: Colors.blueGrey[800],
        borderRadius: BorderRadius.circular(12),
        child: ListTile(
          leading: Icon(icon, color: color),
          title: Text(text, style: const TextStyle(color: Colors.white)),
          onTap: onTap,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          tileColor: Colors.transparent,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBackground(
      colors: const [
        Color.fromARGB(255, 0, 0, 0),
        Color.fromARGB(255, 83, 83, 76),
        Color.fromARGB(255, 155, 150, 150),
      ],
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: const Text(
            'What can i do for you ?',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w800,
              color: Colors.white,
              fontStyle: FontStyle.normal,
              letterSpacing: 2.0,
              wordSpacing: 5.0,
            ),
          ),
          centerTitle: true,
          elevation: 0,
          backgroundColor: Colors.transparent,
          leading: Builder(
            builder:
                (context) => IconButton(
                  icon: const Padding(
                    padding: EdgeInsets.only(left: 12.0),
                    child: Icon(Icons.menu, color: Colors.white),
                  ),
                  onPressed: () {
                    Scaffold.of(context).openDrawer();
                  },
                ),
          ),
        ),
        drawer: Drawer(
          backgroundColor: Colors.blueGrey[900],
          child: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: ListView(
                    padding: const EdgeInsets.only(top: 20),
                    children: [
                      DelayedAnimatedItem(
                        delay: 0,
                        child: const CircleAvatar(
                          radius: 50,
                          backgroundImage: AssetImage(
                            'assets/icons/world-news.png',
                          ),
                          backgroundColor: Colors.grey,
                        ),
                      ),
                      const SizedBox(height: 10),
                      DelayedAnimatedItem(
                        delay: 200,
                        child: const Text(
                          '      News Scrapper',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.2,
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      DelayedAnimatedItem(
                        delay: 400,
                        child: _buildDrawerItem(
                          icon: Icons.newspaper,
                          text: 'Offline News',
                          color: Colors.green,
                          onTap: () => Get.toNamed('/offline-news'),
                        ),
                      ),
                      DelayedAnimatedItem(
                        delay: 600,
                        child: _buildDrawerItem(
                          icon: Icons.library_music,
                          text: 'Offline Audios',
                          color: Colors.yellow,
                          onTap: () => Get.toNamed('/offline-audio'),
                        ),
                      ),
                      DelayedAnimatedItem(
                        delay: 800,
                        child: _buildDrawerItem(
                          icon: Icons.video_collection,
                          text: 'Offline Videos',
                          color: Colors.white,
                          onTap: () => Get.toNamed('/offline-video'),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20.0, bottom: 20),
                  child: DelayedAnimatedItem(
                    delay: 1000,
                    child: _buildDrawerItem(
                      icon: Icons.info_outline,
                      text: 'About the Developer',
                      color: Colors.cyanAccent,
                      onTap: () => Get.toNamed('/about-the-dev'),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.only(bottom: 20),
          child: Column(
            children: [
              YoTile(
                title: "Breaking News",
                description: "Latest world updates",
                color: Colors.green,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const NewsPage()),
                  );
                },
              ),
              YoTile(
                title: "Tech Article",
                description: "Explore new technology trends",
                color: Colors.blue,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const TechPage()),
                  );
                },
              ),
              YoTile(
                title: "Video, Movies links",
                description: "Get free movies and videos.!",
                color: Colors.blueGrey,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const VideoPage()),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class DelayedAnimatedItem extends StatefulWidget {
  final Widget child;
  final int delay;

  const DelayedAnimatedItem({
    super.key,
    required this.child,
    required this.delay,
  });

  @override
  State<DelayedAnimatedItem> createState() => _DelayedAnimatedItemState();
}

class _DelayedAnimatedItemState extends State<DelayedAnimatedItem>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );

    _fadeAnimation = CurvedAnimation(parent: _controller, curve: Curves.easeIn);

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    _scaleAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.elasticOut, // 🍩 Bouncy!
      ),
    );

    Future.delayed(Duration(milliseconds: widget.delay), () {
      if (mounted) _controller.forward();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _fadeAnimation,
      child: SlideTransition(
        position: _slideAnimation,
        child: ScaleTransition(scale: _scaleAnimation, child: widget.child),
      ),
    );
  }
}
