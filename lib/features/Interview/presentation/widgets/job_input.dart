import 'package:flutter/material.dart';

class JobInputField extends StatelessWidget {
  const JobInputField({super.key});

  @override
  Widget build(BuildContext context) {
    return TextField(
  decoration: InputDecoration(
    labelText: "Job Title",
    hintText: "e.g., Flutter Developer, Data Scientist",
    prefixIcon: Icon(Icons.work),
    border: OutlineInputBorder(),
  ),
  // onChanged: (value) => updateJobTitle(value),
);
  }
}