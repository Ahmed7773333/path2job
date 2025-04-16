// features/home/presentation/pages/home_page.dart
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          'Home Page',
          style: Theme.of(context).textTheme.displayMedium,
        ),
      ),
    );
  }
}