import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path2job/features/plan/presentation/cubit/plan_cubit.dart';
import 'package:path2job/hive_helper/course_hive_helper.dart';

import '../../../../hive/course.dart';

class CourseDetailsPage extends StatefulWidget {
  final String course;

  const CourseDetailsPage({
    super.key,
    required this.course,
  });

  @override
  State<CourseDetailsPage> createState() => _CourseDetailsPageState();
}

class _CourseDetailsPageState extends State<CourseDetailsPage> {
  final TextEditingController _descController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _linkController = TextEditingController();
  final TextEditingController _totalVideosController = TextEditingController();
  final TextEditingController _completedVideosController =
      TextEditingController();
  late final Course course;
  @override
  void initState() {
    super.initState();
    getCourse();
    setState(() {});
  }

  Future<void> getCourse() async {
    course = (await CourseHiveHelper.getCourse(widget.course))!;
    debugPrint('<<<<<<<<<<<<here<<<<<<<>>>>>>>${course.courseName}');
    _nameController.value =
        TextEditingController(text: course.courseName ?? '').value;
    _descController.value =
        TextEditingController(text: course.courseDescription).value;
    _linkController.value = TextEditingController(text: course.link).value;
    _totalVideosController.value = TextEditingController(
      text: course.numberOfvideos?.toString() ?? '0',
    ).value;
    _completedVideosController.value = TextEditingController(
      text: course.done == true
          ? course.numberOfvideos?.toString() ?? '0'
          : course.numberOfvideosDone?.toString() ?? '0',
    ).value;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descController.dispose();
    _linkController.dispose();
    _totalVideosController.dispose();
    _completedVideosController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Course Details'),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: _showDeleteConfirmation,
          ),
          IconButton(
              onPressed: () {
                context
                    .read<PlanCubit>()
                    .updateCourse(course.copyWith(done: !(course.done ?? false)));
              },
              icon:  Icon((course.done ?? false)? Icons.check_box_outline_blank:Icons.check_box)),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Course Name
            TextFormField(
              readOnly: true,
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: 'Course Name',
                border: OutlineInputBorder(),
              ),
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 20),

            // Expanded Description Field
            TextFormField(
              controller: _descController,
              decoration: const InputDecoration(
                labelText: 'Description',
                border: OutlineInputBorder(),
                alignLabelWithHint: true,
              ),
              maxLines: 5,
              minLines: 3,
              keyboardType: TextInputType.multiline,
            ),
            const SizedBox(height: 20),

            // Course Link
            TextFormField(
              controller: _linkController,
              decoration: InputDecoration(
                labelText: 'Course URL',
                border: OutlineInputBorder(),
                prefixIcon: IconButton(
                  onPressed: () {
                    context.read<PlanCubit>().launchUrll(course.link ?? '');
                  },
                  icon: Icon(Icons.launch),
                ),
              ),
              keyboardType: TextInputType.url,
            ),
            const SizedBox(height: 20),

            // Progress Section
            const Text(
              'Progress Tracking',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    readOnly: course.done == true,
                    onTap: () {
                      if (course.done == true) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Course is already completed.'),
                          ),
                        );
                      }
                    },
                    controller: _completedVideosController,
                    decoration: const InputDecoration(
                      labelText: 'Completed Videos',
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.number,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: TextFormField(
                    readOnly: course.done == true,
                    onTap: () {
                      if (course.done == true) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Course is already completed.'),
                          ),
                        );
                      }
                    },
                    controller: _totalVideosController,
                    decoration: const InputDecoration(
                      labelText: 'Total Videos',
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.number,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),

            // Progress Indicator
            _buildProgressIndicator(),
            const SizedBox(height: 40),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16),
        child: ElevatedButton(
          onPressed: _saveChanges,
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 16),
          ),
          child: const Text('Save Changes'),
        ),
      ),
    );
  }

  Widget _buildProgressIndicator() {
    final total = int.tryParse(_totalVideosController.text) ?? 0;
    final completed = int.tryParse(_completedVideosController.text) ?? 0;
    final percentage = course.done == true
        ? 100.0
        : total > 0
            ? (completed / total) * 100
            : 0;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Completion: ${percentage.toStringAsFixed(1)}%',
          style: const TextStyle(fontSize: 14),
        ),
        const SizedBox(height: 8),
        LinearProgressIndicator(
          value: percentage / 100,
          minHeight: 8,
          backgroundColor: Colors.grey[200],
          valueColor: AlwaysStoppedAnimation<Color>(
            Theme.of(context).primaryColor,
          ),
        ),
      ],
    );
  }

  void _saveChanges() {
    final updatedCourse = Course(
      courseName: _nameController.text,
      courseDescription: _descController.text,
      link: _linkController.text,
      numberOfvideos: int.tryParse(_totalVideosController.text),
      numberOfvideosDone: int.tryParse(_completedVideosController.text),
    );

    context.read<PlanCubit>().updateCourse(
          updatedCourse,
        );

    Navigator.pop(context);
  }

  void _showDeleteConfirmation() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Course'),
        content: const Text('Are you sure you want to delete this course?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              context.read<PlanCubit>().deleteCourse(course.courseName!);
              Navigator.pop(context); // Close dialog
              Navigator.pop(context); // Return to previous screen
            },
            child: const Text(
              'Delete',
              style: TextStyle(color: Colors.red),
            ),
          ),
        ],
      ),
    );
  }
}
