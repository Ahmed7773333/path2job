import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path2job/hive/question_answer.dart';

import '../cubit/interview_cubit.dart';

class QuestionCard extends StatelessWidget {
  const QuestionCard(this.question, {super.key});
  final Interviews question;
  @override
  Widget build(BuildContext context) {
    return Card(
      child: ExpansionTile(
        title: Text(question.question),
        children: [
          Padding(
            padding: EdgeInsets.all(16),
            child: Text(question.answer),
          ),
          // إمكانية حفظ/حذف السؤال
          IconButton(
              onPressed: () {
                context
                    .read<InterviewCubit>()
                    .deleteQuestion(question.keyId, question.category);
              },
              icon: Icon(Icons.delete)),
        ],
      ),
    );
  }
}
