import 'package:flutter/material.dart';
import 'package:path2job/features/Interview/data/models/qa_model.dart';

class QuestionCard extends StatelessWidget {
  const QuestionCard(this.question, {super.key});
  final QA question;
  @override
  Widget build(BuildContext context) {
    return Card(
      child: ExpansionTile(
        title: Text(question.question),
        children: [
          Padding(
            padding: EdgeInsets.all(16),
            child: Text(question.answer),
          ),
          // إمكانية حفظ/حذف السؤال
          Row(
            children: [
              IconButton(
                  onPressed: () {
                    // saveQuestion(question);
                  },
                  icon: Icon(Icons.bookmark)),
              IconButton(
                  onPressed: () {
                    // deleteQuestion(question);
                  },
                  icon: Icon(Icons.delete)),
            ],
          ),
        ],
      ),
    );
  }
}
