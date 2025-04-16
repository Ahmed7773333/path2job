// features/career_plan/presentation/pages/career_plan_page.dart
import 'package:flutter/material.dart';

class CareerPlanPage extends StatelessWidget {
  const CareerPlanPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          'Career Plan',
          style: Theme.of(context).textTheme.displayMedium,
        ),
      ),
    );
  }
}