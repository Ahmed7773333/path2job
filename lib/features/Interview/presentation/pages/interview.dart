// features/interview/presentation/pages/interview_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path2job/features/Interview/presentation/cubit/interview_cubit.dart';
import 'package:path2job/features/Interview/presentation/widgets/category_list.dart';

import '../widgets/job_input.dart';
import '../widgets/question_bottom.dart';
import '../widgets/question_list.dart';

class InterviewPage extends StatefulWidget {
  const InterviewPage({super.key});

  @override
  State<InterviewPage> createState() => _InterviewPageState();
}

class _InterviewPageState extends State<InterviewPage> {
  @override
  void initState() {
    super.initState();
    // Trigger sync when page initializes
    context.read<InterviewCubit>().sync();
  }
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<InterviewCubit, InterviewState>(
      builder: (context, state) {
        if (state is CategoriesSyncLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is CategoriesSyncError) {
          return Scaffold(
            body: Center(
              child: Text(
                state.message,
                style: Theme.of(context).textTheme.displayMedium,
              ),
            ),
          );
        } else if (state is CategoriesSyncEmpty) {
          return Center(
            child: Text(
              'No categories available.',
              style: Theme.of(context).textTheme.displayMedium,
            ),
          );
        } else if (state is CategoriesSyncSuccess) {
          return Scaffold(
            appBar: AppBar(title: Text("Interview Preparation")),
            body: CategoriesListView(),
            // body: Column(
            //   children: [
            //     // 1. حقل إدخال الوظيفة المطلوبة
            //     JobInputField(),

            //     // 2. زر توليد الأسئلة
            //     GenerateQuestionsButton('Software Engineer'), // This should be dynamic based on user input

            //     // 3. عرض الأسئلة المُنشأة (بعد التوليد)
            //     QuestionsList(),

            //     // 4. إمكانية حفظ/حذف الأسئلة
            //     // SaveOrDeleteOptions(),
            //   ],
            // ),
          );
          // Your actual content widget
        }
        return const Center(child: CircularProgressIndicator());
      },
    );
  }
}
