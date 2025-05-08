import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:path2job/core/routes/routes.dart';
import 'package:path2job/core/utils/assets.dart';

class EmptyPlanPage extends StatelessWidget {
  const EmptyPlanPage({super.key});

  void _showPlanOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: EdgeInsets.all(20.r),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Create Career Plan',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            SizedBox(height: 20.h),
            _buildOptionButton(
              context,
              icon: Icons.auto_awesome,
              title: 'AI Generated Plan',
              subtitle: 'Get personalized recommendations',
              onTap: () {
                Navigator.pushNamed(context, Routes.aiPage);
              },
            ),
            SizedBox(height: 16.h),
            _buildOptionButton(
              context,
              icon: Icons.edit,
              title: 'Manual Plan',
              subtitle: 'Build your own custom plan',
              onTap: () {
                Navigator.pushNamed(context, Routes.customPage);
              },
            ),
            SizedBox(height: 20.h),
          ],
        ),
      ),
    );
  }

  Widget _buildOptionButton(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(16.r),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(
            color: Theme.of(context).dividerColor,
            width: 1,
          ),
        ),
        child: Row(
          children: [
            Icon(icon, size: 32.sp, color: Theme.of(context).primaryColor),
            SizedBox(width: 16.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  Text(
                    subtitle,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Theme.of(context).hintColor,
                        ),
                  ),
                ],
              ),
            ),
            const Icon(Icons.chevron_right),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(Assets.emptyPlan, width: 200.w),
            SizedBox(height: 32.h),
            Text(
              'No Career Plan Yet',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            SizedBox(height: 8.h),
            Text(
              'Create a personalized plan to reach your goals',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Theme.of(context).hintColor,
                  ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 32.h),
            ElevatedButton.icon(
              icon: const Icon(Icons.add, color: Colors.white),
              label: const Text('Create Plan'),
              onPressed: () => _showPlanOptions(context),
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(
                  horizontal: 24.w,
                  vertical: 16.h,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
