import 'package:flutter/material.dart';
import 'package:path2job/features/cv%20generator/presentation/pages/cv_generator.dart';
import 'package:printing/printing.dart';

import '../../data/models/cv_model.dart';

class CVPreviewPage extends StatelessWidget {
  final CVData cvData;

  const CVPreviewPage({Key? key, required this.cvData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('CV Preview'),
        actions: [
          IconButton(
            icon: Icon(Icons.print),
            onPressed: () {}, //=> _printCV(),
          ),
        ],
      ),
      body: PdfPreview(
        build: (format) => CVPdfGenerator.generateCV(cvData),
      ),
    );
  }

  // Future<void> _printCV() async {
  //   final doc = await CVPdfGenerator.generateCV(cvData);
  //   await Printing.layoutPdf(
  //     onLayout: (format) => doc.save(),
  //   );
  // }
}
