import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:path2job/features/plan/presentation/cubit/plan_cubit.dart';
import 'package:path2job/hive_helper/user_hive_helper.dart';

class AiPlanPage extends StatefulWidget {
  const AiPlanPage({super.key});

  @override
  State<AiPlanPage> createState() => _AiPlanPageState();
}

class _AiPlanPageState extends State<AiPlanPage> {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AI Career Plan Generator'),
      ),
      body: BlocConsumer<PlanCubit, PlanState>(
        listener: (context, state) {
          if (state is PlanGeneratingError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.error)),
            );
          }
          if (state is SavingPlanSuccess) {}
        },
        builder: (context, state) {
          final cubit = context.read<PlanCubit>();

          return Padding(
            padding: EdgeInsets.all(16.0.r),
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
                SizedBox(height: 20.h),
                ElevatedButton(
                  onPressed: state is PlanGeneratingLoading
                      ? null
                      : () => cubit.generatePlan(_jobController.text.trim()),
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 16.h),
                  ),
                  child: state is PlanGeneratingLoading
                      ? const CircularProgressIndicator()
                      : const Text('Generate Plan'),
                ),
                SizedBox(height: 20.h),
                if (cubit.generatedCourses.isNotEmpty) ...[
                  Text(
                    'Suggested Courses:',
                    style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10.h),
                  Expanded(
                    child: ListView.separated(
                      itemCount: cubit.generatedCourses.length,
                      separatorBuilder: (_, __) => const Divider(),
                      itemBuilder: (context, index) {
                        final parts = cubit.generatedCourses[index].split('|');
                        final title = parts[0];
                        final url = parts.length > 1 ? parts[1] : '';

                        return ListTile(
                          leading: const Icon(Icons.school),
                          title: Text(title),
                          subtitle: url.isNotEmpty ? Text(url) : null,
                          trailing: IconButton(
                            icon: const Icon(Icons.open_in_new),
                            onPressed: url.isNotEmpty
                                ? () => cubit.launchUrll(url)
                                : null,
                          ),
                        );
                      },
                    ),
                  ),
                  SizedBox(height: 20.h),
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () =>
                              cubit.generatePlan(_jobController.text.trim()),
                          child: const Text('Regenerate'),
                        ),
                      ),
                      SizedBox(width: 16.h),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            cubit.savePlan();
                            Navigator.pop(context);
                            Navigator.pop(context);
                          },
                          child: const Text('Accept Plan'),
                        ),
                      ),
                    ],
                  ),
                ],
              ],
            ),
          );
        },
      ),
    );
  }
}
