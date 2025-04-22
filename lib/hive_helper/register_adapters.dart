import 'package:hive/hive.dart';
import 'package:path2job/hive/user.dart';
import 'package:path2job/hive/course.dart';
import 'package:path2job/hive/question_answer.dart';
import 'package:path2job/hive/category.dart';

void registerAdapters() {
	Hive.registerAdapter(UserModelAdapter());
	Hive.registerAdapter(CourseAdapter());
	Hive.registerAdapter(QuestionAnswerAdapter());
	Hive.registerAdapter(CategoryAdapter());
}
