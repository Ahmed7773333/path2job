import 'package:hive/hive.dart';
import 'package:path2job/hive_helper/hive_types.dart';
import 'package:path2job/hive_helper/hive_adapters.dart';
import 'package:path2job/hive_helper/fields/question_answer_fields.dart';

import '../hive_helper/user_hive_helper.dart';

part 'question_answer.g.dart';

@HiveType(
    typeId: HiveTypes.questionAnswer, adapterName: HiveAdapters.questionAnswer)
class Interviews extends HiveObject {
  Interviews(
      {required this.question,
      required this.answer,
      required this.keyId,
      required this.category});
  @HiveField(QuestionAnswerFields.question)
  String question;
  @HiveField(QuestionAnswerFields.answer)
  String answer;
  @HiveField(QuestionAnswerFields.keyId)
  String keyId;
  @HiveField(QuestionAnswerFields.category)
  String category;

  Map<String, dynamic> toJson() {
    return {
      'question': question,
      'answer': answer,
      'id': keyId,
      'category': category,
      'key': UserHiveHelper.getUser()?.email,
    };
  }

  factory Interviews.fromJson(Map<String, dynamic> json) {
    return Interviews(
        question: json['question'],
        answer: json['answer'],
        keyId: json['id'],
        category: json['category']);
  }
}
