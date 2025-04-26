// import 'dart:typed_data';

// import 'package:pdf/pdf.dart';
// import 'package:pdf/widgets.dart' as pw;
// import '../../data/models/cv_model.dart';

// class CVPdfGenerator {
//   static Future<Uint8List> generateCV(CVData cvData) async {
//     final pdf = pw.Document();

//     // Calculate content to determine page breaks
//     final content = _buildContent(cvData);

//     // Split content into chunks that fit on one page
//     final chunks = _splitContentIntoPages(content);

//     // Add each chunk as a separate page
//     for (var chunk in chunks) {
//       pdf.addPage(
//         pw.Page(
//           margin: pw.EdgeInsets.all(20),
//           build: (context) => pw.Column(
//             crossAxisAlignment: pw.CrossAxisAlignment.start,
//             children: [
//               if (chunk == chunks.first) _buildHeader(cvData),
//               if (chunk == chunks.first) pw.SizedBox(height: 10),
//               ...chunk,
//             ],
//           ),
//         ),
//       );
//     }

//     return pdf.save();
//   }

//   // Helper method to split content into pages
//   static List<List<pw.Widget>> _splitContentIntoPages(List<pw.Widget> content) {
//     // Simplified approach: We'll estimate page sizes and split accordingly
//     // For a more accurate approach, you'd need to measure content heights

//     const int estimatedItemsPerPage = 6; // Adjust based on content size

//     // Create page chunks - first page has header so fits less content
//     List<List<pw.Widget>> pages = [];
//     int currentIndex = 0;

//     // First page (with header)
//     pages.add(content.sublist(
//         currentIndex,
//         currentIndex + estimatedItemsPerPage > content.length
//             ? content.length
//             : currentIndex + estimatedItemsPerPage));
//     currentIndex += estimatedItemsPerPage;

//     // Additional pages if needed
//     while (currentIndex < content.length) {
//       final remainingItems = content.length - currentIndex;
//       final itemsForThisPage = remainingItems > estimatedItemsPerPage + 2
//           ? estimatedItemsPerPage + 2 // Subsequent pages can fit more content
//           : remainingItems;

//       pages.add(content.sublist(currentIndex, currentIndex + itemsForThisPage));
//       currentIndex += itemsForThisPage;
//     }

//     return pages;
//   }

//   // Build all content sections
//   static List<pw.Widget> _buildContent(CVData cvData) {
//     return [
//       _buildSection('EDUCATION', _buildEducation(cvData.education)),
//       _buildSection('SKILLS', _buildSkills(cvData.skills)),
//       _buildSection('PROJECTS', _buildProjects(cvData.projects)),
//       _buildSection(
//           'PROFESSIONAL EXPERIENCE', _buildExperience(cvData.experience)),
//       _buildSection('COURSES', _buildCourses(cvData.courses)),
//       _buildSection('LANGUAGES', _buildLanguages(cvData.languages)),
//     ];
//   }

//   static pw.Widget _buildHeader(CVData cvData) {
//     // Styled after the sample CV with name prominently displayed
//     return pw.Column(
//       crossAxisAlignment: pw.CrossAxisAlignment.start,
//       children: [
//         pw.Text(
//           cvData.name,
//           style: pw.TextStyle(
//             fontSize: 24,
//             fontWeight: pw.FontWeight.bold,
//           ),
//         ),
//         pw.Text(
//           cvData.profession,
//           style: pw.TextStyle(
//             fontSize: 16,
//             fontWeight: pw.FontWeight.bold,
//             color: PdfColors.grey700,
//           ),
//         ),
//         pw.SizedBox(height: 8),
//         pw.Row(
//           children: [
//             pw.Expanded(
//               child: pw.Row(
//                 mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
//                 children: [
//                   pw.Text(cvData.email),
//                   pw.Text(cvData.phone),
//                   pw.Text(cvData.address),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ],
//     );
//   }

//   static pw.Widget _buildEducation(List<Educations> education) {
//     return pw.Column(
//       crossAxisAlignment: pw.CrossAxisAlignment.start,
//       children: education
//           .map((edu) => pw.Column(
//                 crossAxisAlignment: pw.CrossAxisAlignment.start,
//                 children: [
//                   pw.Row(
//                     mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
//                     children: [
//                       pw.Text(
//                         edu.institution,
//                         style: pw.TextStyle(
//                           fontWeight: pw.FontWeight.bold,
//                           fontSize: 14,
//                         ),
//                       ),
//                       pw.Text(edu.duration),
//                     ],
//                   ),
//                   pw.Text(edu.degree),
//                   if (edu.description.isNotEmpty) pw.Text(edu.description),
//                   pw.SizedBox(height: 5),
//                 ],
//               ))
//           .toList(),
//     );
//   }

//   static pw.Widget _buildSkills(List<SkillCategory> skills) {
//     // Styled as a more compact list like in the sample CV
//     return pw.Column(
//       crossAxisAlignment: pw.CrossAxisAlignment.start,
//       children: skills
//           .map((category) => pw.Column(
//                 crossAxisAlignment: pw.CrossAxisAlignment.start,
//                 children: [
//                   if (category.category.isNotEmpty)
//                     pw.Text(
//                       category.category,
//                       style: pw.TextStyle(
//                         fontWeight: pw.FontWeight.bold,
//                       ),
//                     ),
//                   pw.SizedBox(height: 2),
//                   BulletList(
//                     items: category.skills,
//                     bulletStyle: pw.TextStyle(fontSize: 10),
//                   ),
//                   pw.SizedBox(height: 5),
//                 ],
//               ))
//           .toList(),
//     );
//   }

//   static pw.Widget _buildProjects(List<Project> projects) {
//     // Styled as a more compact list like in the sample CV
//     return pw.Wrap(
//       spacing: 10,
//       runSpacing: 5,
//       children: projects
//           .map((project) => pw.Container(
//                 width: 200,
//                 child: pw.Column(
//                   crossAxisAlignment: pw.CrossAxisAlignment.start,
//                   children: [
//                     pw.Text(
//                       project.name,
//                       style: pw.TextStyle(
//                         fontWeight: pw.FontWeight.bold,
//                       ),
//                     ),
//                     if (project.description.isNotEmpty)
//                       pw.Text(
//                         project.description,
//                         style: pw.TextStyle(
//                           fontSize: 9,
//                           color: PdfColors.grey700,
//                         ),
//                       ),
//                   ],
//                 ),
//               ))
//           .toList(),
//     );
//   }

//   static pw.Widget _buildExperience(List<Experience> experience) {
//     // Styled to match the format in the sample CV
//     return pw.Column(
//       children: experience
//           .map((exp) => pw.Container(
//                 margin: pw.EdgeInsets.only(bottom: 10),
//                 child: pw.Row(
//                   crossAxisAlignment: pw.CrossAxisAlignment.start,
//                   children: [
//                     pw.Expanded(
//                       flex: 2,
//                       child: pw.Column(
//                         crossAxisAlignment: pw.CrossAxisAlignment.start,
//                         children: [
//                           pw.Text(
//                             exp.company,
//                             style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
//                           ),
//                           pw.Text(exp.position),
//                           pw.Text(
//                             exp.location,
//                             style: pw.TextStyle(
//                               fontSize: 9,
//                               color: PdfColors.grey700,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                     pw.Expanded(
//                       flex: 3,
//                       child: pw.Column(
//                         crossAxisAlignment: pw.CrossAxisAlignment.start,
//                         children: [
//                           pw.Text(exp.duration),
//                           pw.Text(
//                             exp.description,
//                             style: pw.TextStyle(fontSize: 10),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//               ))
//           .toList(),
//     );
//   }

//   static pw.Widget _buildCourses(List<Course> courses) {
//     // Styled to match the format in the sample CV
//     return pw.Column(
//       crossAxisAlignment: pw.CrossAxisAlignment.start,
//       children: courses
//           .map((course) => pw.Row(
//                 crossAxisAlignment: pw.CrossAxisAlignment.start,
//                 children: [
//                   pw.Expanded(
//                     flex: 3,
//                     child: pw.Text(
//                       course.name,
//                       style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
//                     ),
//                   ),
//                   pw.Expanded(
//                     flex: 2,
//                     child: pw.Text(course.platform),
//                   ),
//                 ],
//               ))
//           .toList(),
//     );
//   }

//   static pw.Widget _buildLanguages(Map<String, String> languages) {
//     // Styled to match the format in the sample CV
//     return pw.Row(
//       children: languages.entries
//           .map((entry) => pw.Expanded(
//                 child: pw.Column(
//                   crossAxisAlignment: pw.CrossAxisAlignment.start,
//                   children: [
//                     pw.Text(
//                       entry.key,
//                       style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
//                     ),
//                     pw.Text(entry.value),
//                   ],
//                 ),
//               ))
//           .toList(),
//     );
//   }

//   static pw.Widget _buildSection(String title, pw.Widget content) {
//     // Styled to match the section headers in the sample CV
//     return pw.Column(
//       crossAxisAlignment: pw.CrossAxisAlignment.start,
//       children: [
//         pw.Container(
//           padding: pw.EdgeInsets.only(bottom: 2),
//           decoration: pw.BoxDecoration(
//             border: pw.Border(
//               bottom: pw.BorderSide(
//                 color: PdfColors.grey400,
//                 width: 1,
//               ),
//             ),
//           ),
//           child: pw.Text(
//             title,
//             style: pw.TextStyle(
//               fontSize: 14,
//               fontWeight: pw.FontWeight.bold,
//             ),
//           ),
//         ),
//         pw.SizedBox(height: 5),
//         content,
//         pw.SizedBox(height: 10),
//       ],
//     );
//   }
// }

// class BulletList extends pw.StatelessWidget {
//   final List<String> items;
//   final pw.TextStyle bulletStyle;

//   BulletList({required this.items, required this.bulletStyle});

//   @override
//   pw.Widget build(pw.Context context) {
//     return pw.Column(
//       crossAxisAlignment: pw.CrossAxisAlignment.start,
//       children: items
//           .map((item) => pw.Padding(
//                 padding: pw.EdgeInsets.only(bottom: 2),
//                 child: pw.Row(
//                   crossAxisAlignment: pw.CrossAxisAlignment.start,
//                   children: [
//                     pw.Text('• ', style: bulletStyle),
//                     pw.Expanded(
//                       child: pw.Text(item, style: bulletStyle),
//                     ),
//                   ],
//                 ),
//               ))
//           .toList(),
//     );
//   }
// }
