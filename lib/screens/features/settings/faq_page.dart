// faq_page.dart
import 'package:flutter/material.dart';

class FAQPage extends StatelessWidget {
  const FAQPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('FAQs')),
      body: ListView(
        children: const [
          ExpansionTile(
            title: Text('How do I connect my device?'),
            children: [
              Padding(
                padding: EdgeInsets.all(16.0),
                child: Text(
                    'Enable Bluetooth and follow the pairing instructions...'),
              ),
            ],
          ),
          ExpansionTile(
            title: Text('How accurate are the measurements?'),
            children: [
              Padding(
                padding: EdgeInsets.all(16.0),
                child: Text('Our devices are clinically validated...'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
