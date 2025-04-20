import 'package:hive_flutter/hive_flutter.dart';
import 'package:path2job/hive/question_answer.dart';

class InterviewHiveHelper {
  static const String interviewBox = 'interviewBox';

  static Future<void> addInterview(Interviews interview) async {
    final box = await Hive.box<Interviews>(interviewBox);
    await box.put(interview.keyId, interview);
  }

  static Future<void> deleteInterview(String interviewKey) async {
    final box = await Hive.box<Interviews>(interviewBox);
    await box.delete(interviewKey);
  }
}
