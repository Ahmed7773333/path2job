import 'package:flutter/material.dart';

class PersonalInfoPage extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final Map<String, dynamic> formData;

  const PersonalInfoPage({
    required this.formKey,
    required this.formData,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(20),
      child: Form(
        key: formKey,
        child: Column(
          children: [
            TextFormField(
              decoration: InputDecoration(labelText: 'Full Name'),
              validator: (value) => value!.isEmpty ? 'Required' : null,
              onChanged: (value) => formData['name'] = value,
            ),
            SizedBox(height: 16),
            TextFormField(
              decoration: InputDecoration(labelText: 'Profession'),
              validator: (value) => value!.isEmpty ? 'Required' : null,
              onChanged: (value) => formData['profession'] = value,
            ),
            SizedBox(height: 16),
            TextFormField(
              decoration: InputDecoration(labelText: 'Email'),
              validator: (value) => value!.isEmpty ? 'Required' : null,
              onChanged: (value) => formData['email'] = value,
            ),
            SizedBox(height: 16),
            TextFormField(
              decoration: InputDecoration(labelText: 'Phone'),
              validator: (value) => value!.isEmpty ? 'Required' : null,
              onChanged: (value) => formData['phone'] = value,
            ),
            SizedBox(height: 16),
            TextFormField(
              decoration: InputDecoration(labelText: 'Address'),
              onChanged: (value) => formData['address'] = value,
            ),
            SizedBox(height: 16),
            TextFormField(
              decoration: InputDecoration(labelText: 'LinkedIn URL'),
              onChanged: (value) => formData['linkedIn'] = value,
            ),
            SizedBox(height: 16),
            TextFormField(
              decoration: InputDecoration(labelText: 'GitHub URL'),
              onChanged: (value) => formData['github'] = value,
            ),
            SizedBox(height: 16),
            TextFormField(
              decoration: InputDecoration(labelText: 'LeetCode Profile'),
              onChanged: (value) => formData['leetCode'] = value,
            ),
          ],
        ),
      ),
    );
  }
}
