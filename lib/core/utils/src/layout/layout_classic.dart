import 'package:flutter/material.dart';
import 'package:path2job/features/cv%20generator/data/models/cv_model.dart';
import '../../flutter_resume_template.dart';
import '../components/section_bottom_buttons.dart';

import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class LayoutClassic extends StatefulWidget {
  LayoutClassic({
    required this.cvData,
    super.key,
    required this.mode,
    this.onSaveResume,
    this.showButtons = true,
  });

  final CVData cvData;
  final TemplateMode mode;
  final Function(GlobalKey)? onSaveResume;
  final bool showButtons;

  @override
  State<LayoutClassic> createState() => _LayoutClassicState();
}

class _LayoutClassicState extends State<LayoutClassic> {
  GlobalKey globalKey = GlobalKey();
  late bool enableEditingMode = true;
  late bool isDragged = false;
  late TransformationController _controller;
  late bool absorbing = false;

  @override
  void initState() {
    setMode();
    _controller = TransformationController();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void setMode() {
    switch (widget.mode) {
      case TemplateMode.onlyEditableMode:
        enableEditingMode = true;
        isDragged = false;
        absorbing = enableEditingMode && isDragged;
        break;
      case TemplateMode.readOnlyMode:
        enableEditingMode = false;
        isDragged = false;
        absorbing = true;
        break;
      case TemplateMode.shakeEditAndSaveMode:
        enableEditingMode = true;
        isDragged = true;
        absorbing = enableEditingMode && isDragged;
        break;
    }
  }

  Future<void> _save() async {
    if (widget.onSaveResume != null &&
        widget.mode == TemplateMode.shakeEditAndSaveMode) {
      widget.onSaveResume!(globalKey);
      _controller.value = Matrix4.identity();
    }

    // Generate PDF
    final pdf = pw.Document();
    final font = await PdfGoogleFonts.robotoRegular();
    final boldFont = await PdfGoogleFonts.robotoBold();

    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        margin: const pw.EdgeInsets.all(32),
        build: (pw.Context context) => [
          // Header
          pw.Text(
            widget.cvData.name,
            style: pw.TextStyle(font: boldFont, fontSize: 24),
          ),
          pw.SizedBox(height: 4),
          pw.Text(
            widget.cvData.profession,
            style: pw.TextStyle(font: boldFont, fontSize: 18),
          ),
          pw.SizedBox(height: 8),
          pw.Text('Email: ${widget.cvData.email}',
              style: pw.TextStyle(font: font, fontSize: 12)),
          pw.Text('Phone: ${widget.cvData.phone}',
              style: pw.TextStyle(font: font, fontSize: 12)),
          pw.Text('Address: ${widget.cvData.address}',
              style: pw.TextStyle(font: font, fontSize: 12)),
          if (widget.cvData.socialLinks.isNotEmpty) ...[
            pw.SizedBox(height: 8),
            pw.Text(
              'Social Links',
              style: pw.TextStyle(font: boldFont, fontSize: 14),
            ),
            ...widget.cvData.socialLinks.map(
              (link) => pw.Text(
                '${link.platform}: ${link.url}',
                style: pw.TextStyle(font: font, fontSize: 12),
              ),
            ),
          ],
          pw.SizedBox(height: 16),

          // Professional Summary
          pw.Text(
            'Professional Summary',
            style: pw.TextStyle(font: boldFont, fontSize: 16),
          ),
          pw.Divider(),
          pw.Text(
            widget.cvData.summary,
            style: pw.TextStyle(font: font, fontSize: 12),
          ),
          pw.SizedBox(height: 16),

          // Education
          pw.Text(
            'Education',
            style: pw.TextStyle(font: boldFont, fontSize: 16),
          ),
          pw.Divider(),
          ...widget.cvData.education.map(
            (edu) => pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Text(
                  '${edu.degree}, ${edu.institution}',
                  style: pw.TextStyle(font: boldFont, fontSize: 12),
                ),
                pw.Text(
                  'Duration: ${edu.duration}',
                  style: pw.TextStyle(font: font, fontSize: 12),
                ),
                pw.Text(
                  edu.description,
                  style: pw.TextStyle(font: font, fontSize: 12),
                ),
                pw.SizedBox(height: 8),
              ],
            ),
          ),
          pw.SizedBox(height: 16),

          // Experience
          pw.Text(
            'Professional Experience',
            style: pw.TextStyle(font: boldFont, fontSize: 16),
          ),
          pw.Divider(),
          ...widget.cvData.experience.map(
            (exp) => pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Text(
                  '${exp.position}, ${exp.company}',
                  style: pw.TextStyle(font: boldFont, fontSize: 12),
                ),
                pw.Text(
                  'Duration: ${exp.duration} | Location: ${exp.location}',
                  style: pw.TextStyle(font: font, fontSize: 12),
                ),
                pw.Text(
                  exp.description,
                  style: pw.TextStyle(font: font, fontSize: 12),
                ),
                pw.SizedBox(height: 8),
              ],
            ),
          ),
          pw.SizedBox(height: 16),

          // Skills
          pw.Text(
            'Skills',
            style: pw.TextStyle(font: boldFont, fontSize: 16),
          ),
          pw.Divider(),
          pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Text(
                widget.cvData.skills.join(', '),
                style: pw.TextStyle(font: font, fontSize: 12),
              ),
              pw.SizedBox(height: 8),
            ],
          ),

          pw.SizedBox(height: 16),

          // Projects
          pw.Text(
            'Projects',
            style: pw.TextStyle(font: boldFont, fontSize: 16),
          ),
          pw.Divider(),
          ...widget.cvData.projects.map(
            (project) => pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Text(
                  project.name,
                  style: pw.TextStyle(font: boldFont, fontSize: 12),
                ),
                pw.Text(
                  project.description,
                  style: pw.TextStyle(font: font, fontSize: 12),
                ),
                pw.SizedBox(height: 8),
              ],
            ),
          ),
          pw.SizedBox(height: 16),

          // Courses
          pw.Text(
            'Courses & Certifications',
            style: pw.TextStyle(font: boldFont, fontSize: 16),
          ),
          pw.Divider(),
          ...widget.cvData.courses.map(
            (course) => pw.Text(
              '${course.name} - ${course.platform}',
              style: pw.TextStyle(font: font, fontSize: 12),
            ),
          ),
          pw.SizedBox(height: 16),

          // Languages
          pw.Text(
            'Languages',
            style: pw.TextStyle(font: boldFont, fontSize: 16),
          ),
          pw.Divider(),
          ...widget.cvData.languages.entries.map(
            (entry) => pw.Text(
              '${entry.key}: ${entry.value}',
              style: pw.TextStyle(font: font, fontSize: 12),
            ),
          ),
        ],
      ),
    );

    // Save or share the PDF
    await Printing.sharePdf(
      bytes: await pdf.save(),
      filename: '${widget.cvData.name}_CV.pdf',
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            RepaintBoundary(
              key: globalKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header Section
                  Text(
                    widget.cvData.name,
                    style: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Roboto',
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    widget.cvData.profession,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      fontFamily: 'Roboto',
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text('Email: ${widget.cvData.email}',
                      style: const TextStyle(fontSize: 14)),
                  Text('Phone: ${widget.cvData.phone}',
                      style: const TextStyle(fontSize: 14)),
                  Text('Address: ${widget.cvData.address}',
                      style: const TextStyle(fontSize: 14)),
                  if (widget.cvData.socialLinks.isNotEmpty) ...[
                    const SizedBox(height: 8),
                    Text(
                      'Social Links:',
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    ...widget.cvData.socialLinks.map(
                      (link) => Text(
                        '${link.platform}: ${link.url}',
                        style: const TextStyle(fontSize: 14),
                      ),
                    ),
                  ],
                  const SizedBox(height: 16),

                  // Professional Summary
                  const Text(
                    'Professional Summary',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Roboto',
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    widget.cvData.summary,
                    style: const TextStyle(fontSize: 14),
                  ),
                  const SizedBox(height: 16),

                  // Education Section
                  const Text(
                    'Education',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Roboto',
                    ),
                  ),
                  const SizedBox(height: 8),
                  ...widget.cvData.education.map(
                    (edu) => Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${edu.degree}, ${edu.institution}',
                            style: const TextStyle(
                                fontSize: 14, fontWeight: FontWeight.bold),
                          ),
                          Text('Duration: ${edu.duration}',
                              style: const TextStyle(fontSize: 14)),
                          Text(edu.description,
                              style: const TextStyle(fontSize: 14)),
                        ],
                      ),
                    ),
                  ),

                  // Experience Section
                  const Text(
                    'Professional Experience',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Roboto',
                    ),
                  ),
                  const SizedBox(height: 8),
                  ...widget.cvData.experience.map(
                    (exp) => Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${exp.position}, ${exp.company}',
                            style: const TextStyle(
                                fontSize: 14, fontWeight: FontWeight.bold),
                          ),
                          Text('Duration: ${exp.duration}',
                              style: const TextStyle(fontSize: 14)),
                          Text('Location: ${exp.location}',
                              style: const TextStyle(fontSize: 14)),
                          Text(exp.description,
                              style: const TextStyle(fontSize: 14)),
                        ],
                      ),
                    ),
                  ),

                  // Skills Section
                  const Text(
                    'Skills',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Roboto',
                    ),
                  ),
                  const SizedBox(height: 8),

                  Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Text(
                      widget.cvData.skills.join(', '),
                      style: const TextStyle(fontSize: 14),
                    ),
                  ),

                  // Projects Section
                  const Text(
                    'Projects',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Roboto',
                    ),
                  ),
                  const SizedBox(height: 8),
                  ...widget.cvData.projects.map(
                    (project) => Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            project.name,
                            style: const TextStyle(
                                fontSize: 14, fontWeight: FontWeight.bold),
                          ),
                          Text(project.description,
                              style: const TextStyle(fontSize: 14)),
                        ],
                      ),
                    ),
                  ),

                  // Courses Section
                  const Text(
                    'Courses & Certifications',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Roboto',
                    ),
                  ),
                  const SizedBox(height: 8),
                  ...widget.cvData.courses.map(
                    (course) => Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: Text(
                        '${course.name} - ${course.platform}',
                        style: const TextStyle(fontSize: 14),
                      ),
                    ),
                  ),

                  // Languages Section
                  const Text(
                    'Languages',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Roboto',
                    ),
                  ),
                  const SizedBox(height: 8),
                  ...widget.cvData.languages.entries.map(
                    (entry) => Padding(
                      padding: const EdgeInsets.only(bottom: 4.0),
                      child: Text(
                        '${entry.key}: ${entry.value}',
                        style: const TextStyle(fontSize: 14),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            if (widget.mode == TemplateMode.shakeEditAndSaveMode &&
                widget.showButtons)
              AnimateButton(
                onDragged: () => setState(() {
                  _controller.value = Matrix4.identity();
                  isDragged = !isDragged;
                }),
                onSave: _save,
                isDragged: isDragged,
              ),
          ],
        ),
      ),
    );
  }
}
