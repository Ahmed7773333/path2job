import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path2job/hive/question_answer.dart';

import '../cubit/interview_cubit.dart';
import 'question_card.dart';

class QuestionsList extends StatelessWidget {
  QuestionsList(this.questions, {super.key});
  final List<Interviews> questions;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.separated(
        itemCount: questions.length,
        itemBuilder: (context, index) {
          return QuestionCard(
            questions[index],
          );
        },
        separatorBuilder: (BuildContext context, int index) {
          return const SizedBox(height: 10);
        },
      ),
    );
  }
}
