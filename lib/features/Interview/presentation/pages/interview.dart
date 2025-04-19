// features/interview/presentation/pages/interview_page.dart
import 'package:flutter/material.dart';

import '../widgets/job_input.dart';
import '../widgets/question_bottom.dart';
import '../widgets/question_list.dart';

class InterviewPage extends StatelessWidget {
  const InterviewPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Interview Preparation")),
      body: Column(
        children: [
          // 1. حقل إدخال الوظيفة المطلوبة
          JobInputField(),

          // 2. زر توليد الأسئلة
          GenerateQuestionsButton('Software Engineer'), // This should be dynamic based on user input

          // 3. عرض الأسئلة المُنشأة (بعد التوليد)
          QuestionsList(),

          // 4. إمكانية حفظ/حذف الأسئلة
          // SaveOrDeleteOptions(),
        ],
      ),
    );
  }
}
