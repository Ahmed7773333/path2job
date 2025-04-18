import 'package:hive/hive.dart';
import 'package:path2job/hive/user.dart';
import 'package:path2job/hive/course.dart';

void registerAdapters() {
	Hive.registerAdapter(UserModelAdapter());
	Hive.registerAdapter(CourseAdapter());
}
