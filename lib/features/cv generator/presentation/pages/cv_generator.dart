import 'dart:typed_data';

import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import '../../data/models/cv_model.dart';

class CVPdfGenerator {
  static Future<Uint8List> generateCV(CVData cvData) async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.Page(
        margin: pw.EdgeInsets.all(20),
        build: (context) => pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            _buildHeader(cvData),
            pw.Divider(),
            _buildSection('EDUCATION', _buildEducation(cvData.education)),
            _buildSection('SKILLS', _buildSkills(cvData.skills)),
            _buildSection('PROJECTS', _buildProjects(cvData.projects)),
            _buildSection(
                'PROFESSIONAL EXPERIENCE', _buildExperience(cvData.experience)),
            _buildSection('COURSES', _buildCourses(cvData.courses)),
            _buildSection('LANGUAGES', _buildLanguages(cvData.languages)),
          ],
        ),
      ),
    );

    return pdf.save();
  }

  static pw.Widget _buildHeader(CVData cvData) {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Text(
          cvData.name,
          style: pw.TextStyle(
            fontSize: 24,
            fontWeight: pw.FontWeight.bold,
          ),
        ),
        pw.Text(
          cvData.profession,
          style: pw.TextStyle(
            fontSize: 16,
            color: PdfColors.grey600,
          ),
        ),
        pw.SizedBox(height: 10),
        pw.Row(
          children: [
            pw.Text('Email: ${cvData.email}'),
            pw.SizedBox(width: 20),
            pw.Text('Phone: ${cvData.phone}'),
          ],
        ),
        pw.Text('Address: ${cvData.address}'),
        pw.Row(
          children: [
            pw.Text('LinkedIn: ${cvData.linkedIn}'),
            pw.SizedBox(width: 20),
            pw.Text('GitHub: ${cvData.github}'),
          ],
        ),
        pw.Text('LeetCode: ${cvData.leetCode}'),
      ],
    );
  }

  static pw.Widget _buildEducation(List<Education> education) {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: education
          .map((edu) => pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  pw.Text(
                    edu.institution,
                    style: pw.TextStyle(
                      fontWeight: pw.FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                  pw.Text(edu.degree),
                  pw.Text(edu.duration),
                  pw.Text(edu.description),
                  pw.SizedBox(height: 10),
                ],
              ))
          .toList(),
    );
  }

  static pw.Widget _buildSkills(List<SkillCategory> skills) {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: skills
          .map((category) => pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  pw.Text(
                    category.category,
                    style: pw.TextStyle(
                      fontWeight: pw.FontWeight.bold,
                    ),
                  ),
                  BulletList(
                    items: category.skills,
                    bulletStyle: pw.TextStyle(fontSize: 10),
                  ),
                  pw.SizedBox(height: 10),
                ],
              ))
          .toList(),
    );
  }

  static pw.Widget _buildProjects(List<Project> projects) {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: projects
          .map((project) => pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  pw.Text(
                    project.name,
                    style: pw.TextStyle(
                      fontWeight: pw.FontWeight.bold,
                    ),
                  ),
                  pw.Text(project.description),
                  pw.SizedBox(height: 10),
                ],
              ))
          .toList(),
    );
  }

  static pw.Widget _buildExperience(List<Experience> experience) {
    return pw.Table(
      border: pw.TableBorder.all(width: 0.5),
      children: experience
          .map((exp) => pw.TableRow(
                children: [
                  pw.Padding(
                    padding: pw.EdgeInsets.all(5),
                    child: pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        pw.Text(
                          exp.company,
                          style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                        ),
                        pw.Text(exp.position),
                        pw.Text(exp.location),
                      ],
                    ),
                  ),
                  pw.Padding(
                    padding: pw.EdgeInsets.all(5),
                    child: pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        pw.Text(exp.duration),
                        pw.Text(exp.description),
                      ],
                    ),
                  ),
                ],
              ))
          .toList(),
    );
  }

  static pw.Widget _buildCourses(List<Course> courses) {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: courses
          .map((course) => pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  pw.Text(
                    course.name,
                    style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                  ),
                  pw.Text(course.platform),
                  pw.SizedBox(height: 5),
                ],
              ))
          .toList(),
    );
  }

  static pw.Widget _buildLanguages(Map<String, String> languages) {
    return pw.Table(
      border: pw.TableBorder.all(width: 0.5),
      children: [
        pw.TableRow(
          children: languages.entries
              .map((entry) => pw.Padding(
                    padding: pw.EdgeInsets.all(5),
                    child: pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        pw.Text(entry.key),
                        pw.Text(entry.value),
                      ],
                    ),
                  ))
              .toList(),
        ),
      ],
    );
  }

  static pw.Widget _buildSection(String title, pw.Widget content) {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Text(
          title,
          style: pw.TextStyle(
            fontSize: 16,
            fontWeight: pw.FontWeight.bold,
            color: PdfColors.blue700,
          ),
        ),
        pw.SizedBox(height: 5),
        content,
        pw.SizedBox(height: 15),
      ],
    );
  }
}

BulletList({required List<String> items, required pw.TextStyle bulletStyle}) {
  return pw.Column(
    crossAxisAlignment: pw.CrossAxisAlignment.start,
    children: items
        .map((item) => pw.Row(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Text('• ', style: bulletStyle),
                pw.Text(item, style: bulletStyle),
              ],
            ))
        .toList(),
  );
}
