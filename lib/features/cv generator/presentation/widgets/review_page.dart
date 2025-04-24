import 'package:flutter/material.dart';

class ReviewPage extends StatelessWidget {
  final Map<String, dynamic> formData;

  const ReviewPage(this.formData, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Personal Information',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          _buildReviewItem('Name', formData['name']),
          _buildReviewItem('Profession', formData['profession']),
          _buildReviewItem('Email', formData['email']),
          _buildReviewItem('Phone', formData['phone']),
          _buildReviewItem('Address', formData['address']),
          _buildReviewItem('LinkedIn', formData['linkedIn']),
          _buildReviewItem('GitHub', formData['github']),
          _buildReviewItem('LeetCode', formData['leetCode']),
          SizedBox(height: 24),
          Text('Education',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          ...formData['education']
              .map<Widget>((edu) => _buildReviewItem(
                  edu['institution'], '${edu['degree']} • ${edu['duration']}'))
              .toList(),
          SizedBox(height: 24),
          Text('Experience',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          ...formData['experience']
              .map<Widget>((exp) => _buildReviewItem(
                  '${exp['company']} - ${exp['position']}',
                  '${exp['duration']}\n${exp['description']}'))
              .toList(),
          SizedBox(height: 24),
          Text('Skills',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          ...formData['skills']
              .map<Widget>((skill) => Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(skill['category'],
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      Wrap(
                        spacing: 8,
                        children: skill['skills']
                            .map<Widget>((s) => Chip(
                                  label: Text(s),
                                ))
                            .toList(),
                      ),
                      Divider(),
                    ],
                  ))
              .toList(),
          SizedBox(height: 24),
          Text('Projects',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          ...formData['projects']
              .map<Widget>((project) =>
                  _buildReviewItem(project['name'], project['description']))
              .toList(),
          SizedBox(height: 24),
          Text('Courses',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          ...formData['courses']
              .map<Widget>((course) =>
                  _buildReviewItem(course['name'], course['platform']))
              .toList(),
          SizedBox(height: 24),
          Text('Languages',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          ...(formData['languages'] as Map)
              .entries
              .map<Widget>((entry) => _buildReviewItem(entry.key, entry.value))
              .toList(),
        ],
      ),
    );
  }

  Widget _buildReviewItem(String label, String? value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: TextStyle(fontWeight: FontWeight.bold)),
          Text(value ?? 'Not provided'),
          Divider(),
        ],
      ),
    );
  }
}
