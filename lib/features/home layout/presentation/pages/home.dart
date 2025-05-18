import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:path2job/core/routes/routes.dart';
import 'package:path2job/core/utils/app_color.dart';
import 'package:path2job/features/home%20layout/presentation/cubit/home_layout_cubit.dart';
import 'package:path2job/hive/recent_acitivty.dart';

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
            _buildActivityList(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {}, // Generate CV action
        child: Icon(Icons.add, color: Colors.white),
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
              IconButton(
                icon: Icon(Icons.notifications, color: Colors.white),
                onPressed: () {},
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
                    // Navigate to Interview Prep
                    break;
                  case "Career Plan":
                    // Navigate to Career Plan
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
        side: BorderSide(color: AppColor.primaryColor,width: 1.w),
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
                      fontSize: 16.sp ,
                      fontWeight: FontWeight.bold,
                    )),
              ],
            ),
            SizedBox(height: 12.h),
            LinearProgressIndicator(
              value: 0.65,
              backgroundColor: AppColor.secondaryColor,
              valueColor:
                  AlwaysStoppedAnimation<Color>(AppColor.primaryColor),
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

  Widget _buildActivityList() {
    return BlocBuilder<HomeLayoutCubit, HomeLayoutState>(
      builder: (context, state) {
        if (state is RecentAcitivtyEmpty) {
          return Center(
            child: Text(
              'No recent activities found.',
            ),
          );
        }
        if (state is RecentAcitivtySuccess) {
          return Center(
            child: Card(
              margin: EdgeInsets.symmetric(horizontal: 16.w),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount:
                    context.read<HomeLayoutCubit>().recentActivities.length >= 3
                        ? 3
                        : context.read<HomeLayoutCubit>().recentActivities.length,
                separatorBuilder: (context, index) =>
                    Divider(height: 1.h, indent: 16.w),
                itemBuilder: (context, index) {
                  final RecentAcitivty activity =
                      context.read<HomeLayoutCubit>().recentActivities[index];
                  return ListTile(
                    leading: Container(
                      width: 40.w,
                      height: 40.h,
                      decoration: BoxDecoration(
                        color: Colors.blue[50],
                        shape: BoxShape.circle,
                      ),
                      child: Icon(IconData(activity.icon!),
                          color: AppColor.secondaryColor, size: 20.sp),
                    ),
                    title: Text(activity.name ?? "",
                        style: TextStyle(fontWeight: FontWeight.w500)),
                    subtitle: Text(activity.time.toString(),
                        style: TextStyle(color: Colors.grey[600], fontSize: 12.sp)),
                    trailing: Icon(Icons.chevron_right, color: Colors.grey[400]),
                    onTap: () {}, // Handle tap
                  );
                },
              ),
            ),
          );
        }
        return CircularProgressIndicator();
      },
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
