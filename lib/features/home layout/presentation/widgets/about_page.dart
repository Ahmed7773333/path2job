import 'package:flutter/material.dart';
import 'package:path2job/core/utils/app_color.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('About Path2Job'),
        backgroundColor: AppColor.primaryColor,
        foregroundColor: AppColor.textColor,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            const Text(
              'Empowering Your Career Journey',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            _buildSectionTitle('Our Mission'),
            const Text(
              'At Path2Job, we believe everyone deserves access to tools that make career development simple and effective. '
              'Our platform combines AI-driven guidance with human-centric design to help you navigate your professional path.',
              style: TextStyle(fontSize: 16, height: 1.5),
            ),
            const SizedBox(height: 30),
            _buildSectionTitle('What We Offer'),
            _buildFeatureItem('📌 Smart CV Builder',
                'ATS-optimized resumes tailored to your target roles'),
            _buildFeatureItem('🎯 Career Roadmaps',
                'Personalized learning paths for your dream job'),
            _buildFeatureItem('💼 Interview Prep',
                'Curated questions and answers for your specific field'),
            const SizedBox(height: 30),
            _buildSectionTitle('Our Team'),
            const Text(
              'Founded in 2023 by career development experts and technologists, '
              'our diverse team brings decades of experience in HR, tech, and education.',
              style: TextStyle(fontSize: 16, height: 1.5),
            ),
            const SizedBox(height: 30),
            _buildContactCard(context),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: Colors.blueGrey,
        ),
      ),
    );
  }

  Widget _buildFeatureItem(String title, String description) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                Text(
                  description,
                  style: TextStyle(
                    color: Colors.grey[700],
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContactCard(BuildContext context) {
    return Card(
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const Text(
              'Have questions?',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'Reach out to our support team at:',
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 10),
            Text(
              'support@path2job.com',
              style: TextStyle(
                color: Theme.of(context).primaryColor,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 15),
            ElevatedButton(
              onPressed: () {},
              child: const Text('Visit Our Website'),
            ),
          ],
        ),
      ),
    );
  }
}
