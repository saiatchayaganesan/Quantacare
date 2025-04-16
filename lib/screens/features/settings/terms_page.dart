import 'package:flutter/material.dart';

class TermsOfServicePage extends StatelessWidget {
  const TermsOfServicePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Terms of Service'),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Terms of Service',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Last updated: ${DateTime.now().year}',
              style: const TextStyle(
                color: Colors.grey,
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 20),
            _buildSection(
              '1. Acceptance of Terms',
              'By accessing or using Quantacare, you agree to be bound by these Terms of Service. If you disagree with any part of the terms, you do not have permission to access the service.',
            ),
            _buildSection(
              '2. Description of Service',
              'Quantacare provides health monitoring and fitness tracking services. We reserve the right to modify, suspend, or discontinue any part of the service at any time.',
            ),
            _buildSection(
              '3. User Responsibilities',
              'You are responsible for maintaining the confidentiality of your account information and for all activities under your account. You must immediately notify us of any unauthorized use of your account.',
            ),
            _buildSection(
              '4. Health Data',
              'While using our service, you may input or collect health-related data. You grant us permission to store and process this data in accordance with our Privacy Policy. We do not provide medical advice, diagnosis, or treatment.',
            ),
            _buildSection(
              '5. Device Usage',
              'When using connected devices with our service, you agree to follow all manufacturer guidelines and safety instructions. We are not responsible for any damage or injury resulting from device misuse.',
            ),
            _buildSection(
              '6. Data Security',
              'We implement reasonable security measures to protect your data. However, no method of transmission over the internet is 100% secure. We cannot guarantee absolute security.',
            ),
            _buildSection(
              '7. Prohibited Activities',
              'You agree not to:\n• Violate any laws\n• Impersonate others\n• Submit false data\n• Interfere with service operation\n• Attempt unauthorized access',
            ),
            _buildSection(
              '8. Termination',
              'We may terminate or suspend your account at any time for any reason, including breach of these Terms. You may also terminate your account at any time.',
            ),
            _buildSection(
              '9. Changes to Terms',
              'We reserve the right to modify these terms at any time. Continued use of the service after changes constitutes acceptance of new terms.',
            ),
            _buildSection(
              '10. Contact',
              'For questions about these Terms, contact us at:\nsupport@quantacare.com',
            ),
            const SizedBox(height: 20),
            Center(
              child: Text(
                '© ${DateTime.now().year} Quantacare. All rights reserved.',
                style: const TextStyle(
                  color: Colors.grey,
                  fontSize: 12,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSection(String title, String content) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            content,
            style: const TextStyle(
              fontSize: 16,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}
