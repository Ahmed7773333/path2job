import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
        padding: EdgeInsets.all(20.r),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20.h),
            Text(
              'Empowering Your Career Journey',
              style: TextStyle(
                fontSize: 24.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20.h),
            _buildSectionTitle('Our Mission'),
            Text(
              'At Path2Job, we believe everyone deserves access to tools that make career development simple and effective. '
              'Our platform combines AI-driven guidance with human-centric design to help you navigate your professional path.',
              style: TextStyle(fontSize: 16.sp, height: 1.5.h),
            ),
            SizedBox(height: 30.h),
            _buildSectionTitle('What We Offer'),
            _buildFeatureItem('📌 Smart CV Builder',
                'ATS-optimized resumes tailored to your target roles'),
            _buildFeatureItem('🎯 Career Roadmaps',
                'Personalized learning paths for your dream job'),
            _buildFeatureItem('💼 Interview Prep',
                'Curated questions and answers for your specific field'),
            SizedBox(height: 30.h),
            _buildSectionTitle('Our Team'),
            Text(
              'Founded in 2023 by career development experts and technologists, '
              'our diverse team brings decades of experience in HR, tech, and education.',
              style: TextStyle(fontSize: 16.sp, height: 1.5.h),
            ),
            SizedBox(height: 30.h),
            _buildContactCard(context),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String text) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8.r),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 20.sp,
          fontWeight: FontWeight.w600,
          color: Colors.black,
        ),
      ),
    );
  }

  Widget _buildFeatureItem(String title, String description) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(width: 8.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16.sp,
                  ),
                ),
                Text(
                  description,
                  style: TextStyle(
                    color: Colors.grey[700],
                    height: 1.4.h,
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
    return SizedBox(
      width: 350.w,
      child: Card(
        elevation: 3,
        child: Padding(
          padding: EdgeInsets.all(16.r),
          child: Column(
            children: [
              Text(
                'Have questions?',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18.sp,
                ),
              ),
              SizedBox(height: 10.h),
              Text(
                'Reach out to our support team at:',
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 10.h),
              Text(
                'support@path2job.com',
                style: TextStyle(
                  color: Colors.grey,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 15.h),
              ElevatedButton(
                onPressed: () {},
                child: const Text('Visit Our Website'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
