import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/interview_cubit.dart';

class GenerateQuestionsButton extends StatelessWidget {
  const GenerateQuestionsButton(this.jobTitle, {super.key});
  final String jobTitle; // This should be dynamic based on user input
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<InterviewCubit, InterviewState>(
      builder: (context, state) {
        if (state is InterviewLoading) {
          return CircularProgressIndicator();
        }
        return ElevatedButton.icon(
          icon: Icon(Icons.auto_awesome),
          label: Text("Generate Questions"),
          onPressed: () {
            context.read<InterviewCubit>().generateQuestions(jobTitle);
          },
        );
      },
    );
  }
}
