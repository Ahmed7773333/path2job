import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:path2job/core/routes/routes.dart';
import 'package:path2job/core/utils/app_color.dart';
import 'package:path2job/features/home%20layout/presentation/cubit/home_layout_cubit.dart';
import 'package:path2job/hive/recent_acitivty.dart';

import '../../../home layout hr/presentation/pages/home_page.dart';
import '../widgets/show_upgrade.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<QuickAction> quickActions = [
    QuickAction(Icons.edit_document, "Generate CV", Colors.blue),
    QuickAction(Icons.quiz, "Interview Prep", Colors.green),
    QuickAction(Icons.timeline, "Career Plan", Colors.orange),
  ];

  @override
  void initState() {
    // TODO: implement initState
    context.read<HomeLayoutCubit>().getAllActivties();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            _buildHeader(context),

            // Quick Actions
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
              child: Text("Quick Actions",
                  style: Theme.of(context).textTheme.titleMedium),
            ),
            Padding(
              padding: EdgeInsets.all(8.0.r),
              child: _buildQuickActions(),
            ),

            // Progress Section
            _buildProgressCard(),

            // Recent Activity
            Padding(
              padding: EdgeInsets.fromLTRB(24.w, 24.h, 16.w, 16.h),
              child: Text("Recent Activity",
                  style: Theme.of(context).textTheme.titleMedium),
            ),
            buildActivityList(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(16.w, 56.h, 16.w, 24.h),
      decoration: BoxDecoration(
        color: AppColor.primaryColor,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(20.r),
          bottomRight: Radius.circular(20.r),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Welcome Back!",
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      )),
              TextButton(
                child: Text(
                  'UPGRADE',
                  style: TextStyle(color: Colors.amber),
                ),
                onPressed: () {
                  Future.delayed(Duration.zero, () {
                    showUpgradeDialog(context);
                  });
                },
              ),
            ],
          ),
          SizedBox(height: 8.h),
          Text("Ready to boost your career?",
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: Colors.white.withOpacity(0.9),
                  )),
        ],
      ),
    );
  }

  Widget _buildQuickActions() {
    return SizedBox(
      height: 110.h,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(horizontal: 8.h),
        itemCount: quickActions.length,
        itemBuilder: (context, index) {
          final action = quickActions[index];
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.h),
            child: InkWell(
              borderRadius: BorderRadius.circular(12.r),
              onTap: () {
                // Handle action tap
                switch (action.label) {
                  case "Generate CV":
                    Navigator.pushNamed(context, Routes.cvGenerator);
                    break;
                  case "Interview Prep":
                    Navigator.pushNamed(context, Routes.interview);
                    break;
                  case "Career Plan":
                    Navigator.pushNamed(context, Routes.plan);
                    break;
                }
              }, // Handle action
              child: Container(
                width: 100.w,
                padding: EdgeInsets.all(12.r),
                decoration: BoxDecoration(
                  color: action.color.withOpacity(0.25),
                  borderRadius: BorderRadius.circular(12.r),
                  border: Border.all(color: action.color.withOpacity(0.45)),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(action.icon, color: action.color, size: 28.sp),
                    SizedBox(height: 8.h),
                    Text(action.label,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.grey[800],
                          fontWeight: FontWeight.w500,
                        )),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildProgressCard() {
    return Card(
      margin: EdgeInsets.all(16.r),
      elevation: 10,
      color: Colors.white70,
      surfaceTintColor: AppColor.secondaryColor,
      shadowColor: Colors.white70,
      shape: RoundedRectangleBorder(
        side: BorderSide(color: AppColor.primaryColor, width: 1.w),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Padding(
        padding: EdgeInsets.all(16.r),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Career Plan Progress",
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                    )),
                Text("65%",
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                    )),
              ],
            ),
            SizedBox(height: 12.h),
            LinearProgressIndicator(
              value: 0.65,
              backgroundColor: AppColor.secondaryColor,
              valueColor: AlwaysStoppedAnimation<Color>(AppColor.primaryColor),
              minHeight: 8.h,
              borderRadius: BorderRadius.circular(4.r),
            ),
            SizedBox(height: 16.h),
            Wrap(
              spacing: 8.h,
              runSpacing: 8.r,
              children: [
                _buildProgressChip("Flutter Basics", true),
                _buildProgressChip("Dart Advanced", true),
                _buildProgressChip("Firebase", false),
                _buildProgressChip("UI/UX", false),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProgressChip(String label, bool completed) {
    return Chip(
      label: Text(label),
      backgroundColor: completed ? AppColor.secondaryColor : Colors.grey[300],
      labelStyle: TextStyle(
        color: completed ? AppColor.primaryColor : Colors.grey[700],
        fontSize: 12.sp,
      ),
      avatar: Icon(
        completed ? Icons.check : Icons.access_time,
        size: 16.sp,
        color: completed ? AppColor.primaryColor : Colors.grey[700],
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.r),
        side: BorderSide(
          color: completed ? AppColor.primaryColor : Colors.grey[200]!,
        ),
      ),
    );
  }
}

// Models for mock data
class QuickAction {
  final IconData icon;
  final String label;
  final Color color;

  QuickAction(this.icon, this.label, this.color);
}
