// features/interview/presentation/pages/interview_page.dart
import 'package:flutter/material.dart';

class InterviewPage extends StatelessWidget {
  const InterviewPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          'Interview Prep',
          style: Theme.of(context).textTheme.displayMedium,
        ),
      ),
    );
  }
}
