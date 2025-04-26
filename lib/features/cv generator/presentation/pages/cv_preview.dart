import 'package:flutter/material.dart';

import '../../../../core/utils/src/app.dart';
import '../../../../core/utils/src/repository/pdf_saver.dart';
import '../../../../core/utils/src/styles/theme.dart';
import '../../../../core/utils/src/utils/enums.dart';
import '../../data/models/cv_model.dart';
// import 'package:path2job/features/cv%20generator/presentation/pages/cv_generator.dart';
// import 'package:printing/printing.dart';

// import '../../data/models/cv_model.dart';

class CVPreviewPage extends StatelessWidget {
  final CVData cvData;

  const CVPreviewPage({Key? key, required this.cvData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // return Scaffold(
    //   appBar: AppBar(
    //     title: Text('CV Preview'),
    //     actions: [
    //       IconButton(
    //         icon: Icon(Icons.print),
    //         onPressed: () {}, //=> _printCV(),
    //       ),
    //     ],
    //   ),
    //   body: PdfPreview(
    //     build: (format) => CVPdfGenerator.generateCV(cvData),
    //   ),
    // );
    return Scaffold(
      backgroundColor: Colors.white,
      body: FlutterResumeTemplate(
        cvData: cvData,
        templateTheme: TemplateTheme.classic,
        mode: TemplateMode.shakeEditAndSaveMode,
        onSaveResume: (globalKey) async =>
            await PdfHandler().createResume(globalKey),
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
