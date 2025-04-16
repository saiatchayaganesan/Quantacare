import 'package:flutter/material.dart';

class PrivacyPolicyPage extends StatelessWidget {
  const PrivacyPolicyPage({super.key}); // Correct constructor

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Privacy Policy'),
      ),
      body: const SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Text('''
          Privacy Policy for Quantacare

          1. Information We Collect
          - Personal information
          - Health data
          - Device information

          2. How We Use Your Information
          - To provide health monitoring services
          - To improve our services
          - To communicate with you

          3. Data Security
          We implement security measures to protect your information.

          4. Your Rights
          You have the right to access, modify, or delete your data.
        '''),
      ),
    );
  }
}
