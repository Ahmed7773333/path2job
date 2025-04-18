import 'package:flutter/material.dart';
import 'package:path2job/core/utils/app_color.dart';

class TermsPage extends StatelessWidget {
  const TermsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Terms & Conditions'),
        backgroundColor: AppColor.primaryColor,
        foregroundColor: AppColor.textColor,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Last Updated: January 1, 2023',
              style: TextStyle(fontStyle: FontStyle.italic),
            ),
            const SizedBox(height: 20),
            _buildSection('1. Acceptance of Terms',
                'By accessing or using Path2Job, you agree to be bound by these Terms. If you disagree, please refrain from using our services.'),
            _buildSection('2. User Responsibilities',
                'You agree to provide accurate information and maintain the confidentiality of your account credentials.'),
            _buildSection('3. Intellectual Property',
                'All content, features, and functionality are owned by Path2Job and protected by international copyright laws.'),
            _buildSection('4. Data Privacy',
                'We collect and process personal data in accordance with our Privacy Policy. By using our services, you consent to such processing.'),
            _buildSection('5. Prohibited Activities',
                'Users may not:\n• Reverse engineer our systems\n• Use bots/scrapers\n• Share illegal content\n• Violate others\' privacy'),
            _buildSection('6. Limitation of Liability',
                'Path2Job shall not be liable for any indirect, incidental, or consequential damages arising from service use.'),
            _buildSection('7. Changes to Terms',
                'We may modify these terms at any time. Continued use after changes constitutes acceptance.'),
            const SizedBox(height: 30),
            const Text(
              'For questions regarding these terms, contact legal@path2job.com',
              style: TextStyle(fontStyle: FontStyle.italic),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSection(String title, String content) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
              color: Colors.blueGrey,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            content,
            style: const TextStyle(height: 1.5),
          ),
        ],
      ),
    );
  }
}
