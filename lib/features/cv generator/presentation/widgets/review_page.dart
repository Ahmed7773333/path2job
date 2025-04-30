import 'package:flutter/material.dart';

import '../../../../core/utils/flutter_resume_template.dart';
import '../../data/models/cv_model.dart';

class ReviewPage extends StatelessWidget {
  final Map<String, dynamic> _formData;

  ReviewPage(this._formData, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('My Resume'),
      ),
      body: FlutterResumeTemplate(
        cvData: CVData(
          name: _formData['name'],
          summary: _formData['summary'],
          profession: _formData['profession'],
          email: _formData['email'],
          phone: _formData['phone'],
          address: _formData['address'],
          socialLinks: _formData['links']
              .map((link) => SocialLink(
                    platform: link['platform'],
                    url: link['url'],
                  ))
              .toList(),
          education: _formData['education']
              .map((e) => Educations(
                    institution: e['institution'],
                    degree: e['degree'],
                    duration: e['duration'],
                    description: e['description'],
                  ))
              .toList(),
          skills: _formData['skills'],
          projects: _formData['projects']
              .map((p) => Project(
                    name: p['name'],
                    description: p['description'],
                  ))
              .toList(),
          experience: _formData['experience']
              .map((e) => Experience(
                    company: e['company'],
                    position: e['position'],
                    duration: e['duration'],
                    location: e['location'],
                    description: e['description'],
                  ))
              .toList() ,
          courses: _formData['courses']
              .map((c) => Course(
                    name: c['name'],
                    platform: c['platform'],
                  ))
              .toList() ,
          languages: Map<String, String>.from(_formData['languages']),
        ),
        templateTheme: TemplateTheme.classic,
        mode: TemplateMode.shakeEditAndSaveMode,
        onSaveResume: (globalKey) async =>
            await PdfHandler().createResume(globalKey),
      ),
    );
  }

  //    SingleChildScrollView(
  //     padding: EdgeInsets.all(20),
  //     child: Column(
  //       crossAxisAlignment: CrossAxisAlignment.start,
  //       children: [
  //         Text('Personal Information',
  //             style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
  //         _buildReviewItem('Name', formData['name']),
  //         _buildReviewItem('Profession', formData['profession']),
  //         _buildReviewItem('Email', formData['email']),
  //         _buildReviewItem('Phone', formData['phone']),
  //         _buildReviewItem('Address', formData['address']),
  //         _buildReviewItem('Summary', formData['summary']),
  //         SizedBox(height: 24),
  //         Text('Social Links',
  //             style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
  //         if (formData['links'] != null)
  //           ...formData['links']
  //               .map<Widget>(
  //                   (link) => _buildReviewItem(link['platform'], link['url']))
  //               .toList(),
  //         SizedBox(height: 24),
  //         Text('Education',
  //             style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
  //         ...formData['education']
  //             .map<Widget>((edu) => _buildReviewItem(
  //                 edu['institution'], '${edu['degree']} • ${edu['duration']}'))
  //             .toList(),
  //         SizedBox(height: 24),
  //         Text('Experience',
  //             style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
  //         ...formData['experience']
  //             .map<Widget>((exp) => _buildReviewItem(
  //                 '${exp['company']} - ${exp['position']}',
  //                 '${exp['duration']}\n${exp['description']}'))
  //             .toList(),
  //         SizedBox(height: 24),
  //         Text('Skills',
  //             style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
  //         Wrap(spacing: 8, children: [
  //           ...formData['skills']
  //               .map<Widget>(
  //                 (skill) => Chip(label: Text(skill)),
  //               )
  //               .toList()
  //         ]),
  //         SizedBox(height: 24),
  //         Text('Projects',
  //             style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
  //         ...formData['projects']
  //             .map<Widget>((project) =>
  //                 _buildReviewItem(project['name'], project['description']))
  //             .toList(),
  //         SizedBox(height: 24),
  //         Text('Courses',
  //             style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
  //         ...formData['courses']
  //             .map<Widget>((course) =>
  //                 _buildReviewItem(course['name'], course['platform']))
  //             .toList(),
  //         SizedBox(height: 24),
  //         Text('Languages',
  //             style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
  //         ...(formData['languages'] as Map)
  //             .entries
  //             .map<Widget>((entry) => _buildReviewItem(entry.key, entry.value))
  //             .toList(),
  //       ],
  //     ),
  //   );
  // }

}
