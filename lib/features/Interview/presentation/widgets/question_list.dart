import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path2job/features/Interview/data/models/qa_model.dart';

import '../cubit/interview_cubit.dart';
import 'question_card.dart';

class QuestionsList extends StatelessWidget {
  const QuestionsList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<InterviewCubit, InterviewState>(
        builder: (context, state) {
      final List<QA> questions = [
        QA('question', 'answer'),
        QA('question', 'answer'),
        QA('question', 'answer'),
        QA('question', 'answer'),
        QA('question', 'answer')
      ];
      // if (state is InterviewLoaded) {
      return Expanded(
        child: ListView.builder(
          // itemCount: state.questions.length,
          itemCount: 5,

          itemBuilder: (context, index) {
            return QuestionCard(
              // state.questions[index],
              questions[index],
            );
          },
        ),
      );
    }
        // return Expanded(
        //     child: Center(child: Text("No questions generated yet")));
        // },
        );
  }
}
