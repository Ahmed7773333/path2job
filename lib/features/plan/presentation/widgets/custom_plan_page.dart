import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path2job/features/plan/presentation/cubit/plan_cubit.dart';
import 'package:path2job/hive_helper/user_hive_helper.dart';

import 'add_course_sheet.dart';

class CustomPlanPage extends StatefulWidget {
  const CustomPlanPage({super.key});

  @override
  State<CustomPlanPage> createState() => _CustomPlanPageState();
}

class _CustomPlanPageState extends State<CustomPlanPage> {
  late TextEditingController _jobController;

  @override
  void dispose() {
    _jobController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    _jobController =
        TextEditingController(text: UserHiveHelper.getUser()?.job ?? '');
    super.initState();
  }

  void _showAddCourseSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: const AddCourseSheet(
          isCustom: true,
        ),
      ),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddCourseSheet(context),
        child: const Icon(Icons.add),
      ),
      appBar: AppBar(
        title: const Text('Make Your Own Career Plan'),
      ),
      body: BlocConsumer<PlanCubit, PlanState>(
        listener: (context, state) {
          if (state is SavingCustomPlanSuccess) {
            Navigator.pop(context);
          }
        },
        builder: (context, state) {
          final cubit = context.read<PlanCubit>();
          final courses = state is CustomCoursesUpdated
              ? state.courses
              : cubit.customCourses;
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextField(
                  controller: _jobController,
                  decoration: const InputDecoration(
                    labelText: 'What career are you targeting?',
                    hintText: 'e.g. Flutter Developer, Data Scientist',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  'Your Courses:',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                Expanded(
                  child: courses.isEmpty
                      ? const Center(
                          child: Text('No courses added yet'),
                        )
                      : ListView.separated(
                          itemCount: courses.length,
                          separatorBuilder: (_, __) => const Divider(height: 1),
                          itemBuilder: (context, index) {
                            final course = courses[index];
                            final title = course.courseName;
                            final url = course.link ?? '';

                            return ListTile(
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 8,
                              ),
                              leading: const Icon(Icons.school),
                              title: Text(title ?? 'Untitled Course'),
                              subtitle: url.isNotEmpty ? Text(url) : null,
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  IconButton(
                                    icon:
                                        const Icon(Icons.open_in_new, size: 20),
                                    onPressed: url.isNotEmpty
                                        ? () => cubit.launchUrll(url)
                                        : null,
                                  ),
                                  IconButton(
                                    icon: const Icon(Icons.delete, size: 20),
                                    onPressed: () =>
                                        cubit.deleteCustomCourse(course),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () => cubit.deleteCustomPlan(),
                        child: const Text('Delete All Courses'),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          cubit.saveCustomPlan();
                        },
                        child: const Text('Save Plan'),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
