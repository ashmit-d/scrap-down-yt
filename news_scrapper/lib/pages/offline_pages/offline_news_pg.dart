import 'package:flutter/material.dart';

class OfflineNewsPage extends StatelessWidget {
  const OfflineNewsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Ofline News'), backgroundColor: Colors.green),
      body: Center(child: Text('Offline News Page')),
      backgroundColor: Colors.green,
    );
  }
}
