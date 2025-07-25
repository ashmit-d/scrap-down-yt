import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';

class AboutDeveloperPage extends StatefulWidget {
  const AboutDeveloperPage({Key? key}) : super(key: key);

  @override
  State<AboutDeveloperPage> createState() => _AboutDeveloperPageState();
}

class _AboutDeveloperPageState extends State<AboutDeveloperPage> {
  bool _isVisible = false;

  @override
  void initState() {
    super.initState();
    // Delay animation for smooth fade-in
    Future.delayed(const Duration(milliseconds: 200), () {
      setState(() {
        _isVisible = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF0F2027), Color(0xFF203A43), Color(0xFF2C5364)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: AnimatedOpacity(
            opacity: _isVisible ? 1.0 : 0.0,
            duration: const Duration(milliseconds: 600),
            child: AnimatedPadding(
              duration: const Duration(milliseconds: 600),
              padding: EdgeInsets.only(top: _isVisible ? 0 : 50),
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24),
                ),
                color: Colors.white.withOpacity(0.95),
                elevation: 8,
                margin: const EdgeInsets.symmetric(horizontal: 24),
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const CircleAvatar(
                        radius: 50,
                        backgroundImage: AssetImage(
                          'assets/images/developer.jpg',
                        ), // replace with your image
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        'Hey there! 👋',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'I\'m Ashmit',
                        style: TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 12),
                      const Text(
                        'A curious mind building beautiful apps with Flutter. I love solving problems, designing smooth interfaces, and turning ideas into real experiences.',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 16, color: Colors.black87),
                      ),
                      const SizedBox(height: 24),
                      Column(
                        children: const [
                          DeveloperInfoRow(
                            icon: LucideIcons.mail,
                            label: 'dhimanashmit106@gmail.com',
                          ),
                          DeveloperInfoRow(
                            icon: LucideIcons.globe,
                            label: 'yourportfolio.com',
                          ),
                          DeveloperInfoRow(
                            icon: LucideIcons.github,
                            label: 'github.com/ashmit_d',
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class DeveloperInfoRow extends StatelessWidget {
  final IconData icon;
  final String label;

  const DeveloperInfoRow({Key? key, required this.icon, required this.label})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 20, color: Colors.black54),
          const SizedBox(width: 8),
          Text(
            label,
            style: const TextStyle(fontSize: 16, color: Colors.black87),
          ),
        ],
      ),
    );
  }
}
