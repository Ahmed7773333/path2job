import 'package:flutter/material.dart';
import 'package:path2job/core/routes/routes.dart';
import 'package:path2job/core/utils/app_color.dart';

class HomePage extends StatelessWidget {
  final List<QuickAction> quickActions = [
    QuickAction(Icons.edit_document, "Generate CV", Colors.blue),
    QuickAction(Icons.quiz, "Interview Prep", Colors.green),
    QuickAction(Icons.timeline, "Career Plan", Colors.orange),
  ];

  final List<ActivityItem> recentActivities = [
    ActivityItem("Updated CV", "2 hours ago", Icons.history),
    ActivityItem("Completed Flutter Quiz", "1 day ago", Icons.quiz),
    ActivityItem("Added new career goal", "3 days ago", Icons.flag),
  ];

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
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Text("Quick Actions",
                  style: Theme.of(context).textTheme.titleMedium),
            ),
            _buildQuickActions(),

            // Progress Section
            _buildProgressCard(),

            // Recent Activity
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 24, 16, 8),
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
      padding: const EdgeInsets.fromLTRB(16, 56, 16, 24),
      decoration: BoxDecoration(
        color: AppColor.primaryColor,
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(20),
          bottomRight: Radius.circular(20),
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
          const SizedBox(height: 8),
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
      height: 105,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 8),
        itemCount: quickActions.length,
        itemBuilder: (context, index) {
          final action = quickActions[index];
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: InkWell(
              borderRadius: BorderRadius.circular(12),
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
                width: 100,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: action.color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: action.color.withOpacity(0.3)),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(action.icon, color: action.color, size: 28),
                    const SizedBox(height: 8),
                    Text(action.label,
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
      margin: const EdgeInsets.all(16),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Career Plan Progress",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[800],
                    )),
                Text("65%",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: AppColor.secondaryColor,
                    )),
              ],
            ),
            const SizedBox(height: 12),
            LinearProgressIndicator(
              value: 0.65,
              backgroundColor: Colors.grey[200],
              valueColor:
                  AlwaysStoppedAnimation<Color>(AppColor.secondaryColor!),
              minHeight: 8,
              borderRadius: BorderRadius.circular(4),
            ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 8,
              runSpacing: 8,
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
      backgroundColor: completed ? Colors.green[50] : Colors.grey[100],
      labelStyle: TextStyle(
        color: completed ? Colors.green[800] : Colors.grey[600],
        fontSize: 12,
      ),
      avatar: Icon(
        completed ? Icons.check : Icons.access_time,
        size: 16,
        color: completed ? Colors.green[800] : Colors.grey[600],
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        side: BorderSide(
          color: completed ? Colors.green[100]! : Colors.grey[200]!,
        ),
      ),
    );
  }

  Widget _buildActivityList() {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListView.separated(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: recentActivities.length,
        separatorBuilder: (context, index) => Divider(height: 1, indent: 16),
        itemBuilder: (context, index) {
          final activity = recentActivities[index];
          return ListTile(
            leading: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: Colors.blue[50],
                shape: BoxShape.circle,
              ),
              child:
                  Icon(activity.icon, color: AppColor.secondaryColor, size: 20),
            ),
            title: Text(activity.title,
                style: TextStyle(fontWeight: FontWeight.w500)),
            subtitle: Text(activity.time,
                style: TextStyle(color: Colors.grey[600], fontSize: 12)),
            trailing: Icon(Icons.chevron_right, color: Colors.grey[400]),
            onTap: () {}, // Handle tap
          );
        },
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

class ActivityItem {
  final String title;
  final String time;
  final IconData icon;

  ActivityItem(this.title, this.time, this.icon);
}
