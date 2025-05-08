import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:path2job/features/plan/presentation/cubit/plan_cubit.dart';
import 'package:path2job/hive_helper/user_hive_helper.dart';

import '../widgets/add_course_sheet.dart';

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
            padding: EdgeInsets.all(16.0.r),
            child: Stack(
              alignment: Alignment.center,
              children: [
                Column(
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
                    SizedBox(height: 20.h),
                    Text(
                      'Your Courses:',
                      style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 10.h),
                    Expanded(
                      child: courses.isEmpty
                          ? const Center(
                              child: Text('No courses added yet'),
                            )
                          : ListView.separated(
                              itemCount: courses.length,
                              separatorBuilder: (_, __) => Divider(height: 1.h),
                              itemBuilder: (context, index) {
                                final course = courses[index];
                                final title = course.courseName;
                                final url = course.link ?? '';

                                return Card(
                                  elevation: 0,
                                  margin: EdgeInsets.all(8.r),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(16.r)),
                                  child: ListTile(
                                    contentPadding: EdgeInsets.symmetric(
                                      horizontal: 16.w,
                                      vertical: 8.h,
                                    ),
                                    leading: const Icon(Icons.school),
                                    title: Text(title ?? 'Untitled Course'),
                                    subtitle: url.isNotEmpty ? Text(url) : null,
                                    trailing: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        IconButton(
                                          icon:
                                            Icon(Icons.open_in_new, size: 20.sp),
                                          onPressed: url.isNotEmpty
                                              ? () => cubit.launchUrll(url)
                                              : null,
                                        ),
                                        IconButton(
                                          icon: Icon(Icons.delete, size: 20.sp),
                                          onPressed: () =>
                                              cubit.deleteCustomCourse(course),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                    ),
                    SizedBox(height: 20.h),
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Expanded(
                          child: OutlinedButton(
                            style: ButtonStyle(fixedSize: WidgetStatePropertyAll(Size(200.w, 70.h))),
                            onPressed: () => cubit.deleteCustomPlan(),
                            child: const Text('Delete All Courses',textAlign: TextAlign.center,),
                          ),
                        ),
                        SizedBox(width: 16.w),
                        Expanded(
                          child: ElevatedButton(
                            style: ButtonStyle(fixedSize: WidgetStatePropertyAll(Size(200.w, 70.h))),
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
                Positioned(
                  bottom: 45.h,
                  child: FloatingActionButton(
                    elevation: 0,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
                    onPressed: () => _showAddCourseSheet(context),
                    child: const Icon(Icons.add),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
