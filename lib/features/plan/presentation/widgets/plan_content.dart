import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path2job/core/routes/routes.dart';
import 'package:path2job/features/plan/presentation/cubit/plan_cubit.dart';
import 'package:path2job/features/plan/presentation/widgets/course_widget.dart';
import 'package:path2job/hive_helper/user_hive_helper.dart';

import '../../../../hive/course.dart';
import 'add_course_sheet.dart';

class PlanContent extends StatelessWidget {
  const PlanContent({super.key});

  double _calculateTotalProgress(List<Course> courses) {
    if (courses.isEmpty) return 0;

    int totalVideos = 0;
    int completedVideos = 0;

    for (final course in courses) {
      totalVideos += course.numberOfvideos ?? 0;
      completedVideos += course.numberOfvideosDone ?? 0;
    }

    return totalVideos > 0 ? (completedVideos / totalVideos) * 100 : 0;
  }

  void _showAddCourseSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: const AddCourseSheet(),
      ),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<PlanCubit>();
    final courses = cubit.planCourses;
    final totalProgress = _calculateTotalProgress(courses);
    debugPrint('Total Progress: $totalProgress');
    return Scaffold(
      appBar: AppBar(
        title: Text(
            'You will be ${UserHiveHelper.getUser()?.job ?? 'No job found'}'),
        actions: [
          IconButton(
            icon: const Icon(Icons.sync),
            onPressed: () {
              cubit.sync();
            },
          ),
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () {
              cubit.deleteAllCourses();
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddCourseSheet(context),
        child: const Icon(Icons.add),
      ),
      body: Column(
        children: [
          // Progress Header
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
            ),
            child: Column(
              children: [
                Text(
                  'Overall Progress',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const SizedBox(height: 16),
                Stack(
                  alignment: Alignment.center,
                  children: [
                    SizedBox(
                      height: 120,
                      width: 120,
                      child: CircularProgressIndicator(
                        value: totalProgress / 100,
                        strokeWidth: 12,
                        backgroundColor: Colors.grey[200],
                        valueColor: AlwaysStoppedAnimation<Color>(
                          Theme.of(context).primaryColor,
                        ),
                      ),
                    ),
                    Text(
                      '${totalProgress.toStringAsFixed(1)}%',
                      style:
                          Theme.of(context).textTheme.headlineSmall?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  '${courses.length} courses in your plan',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
          ),

          // Courses List
          Expanded(
            child: courses.isEmpty
                ? const Center(
                    child: Text('No courses added yet'),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.only(top: 16),
                    itemCount: courses.length,
                    itemBuilder: (context, index) {
                      final course = courses[index];
                      return CourseCard(
                        course: course,
                        onTap: () {
                          // if (course.link != null) {
                          //   cubit.launchUrll(course.link!);
                          // }
                          Navigator.pushNamed(context, Routes.courseDetails,
                              arguments: course.courseName);
                        },
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
