import 'package:hive/hive.dart';
import 'package:path2job/hive/user.dart';

void registerAdapters() {
	Hive.registerAdapter(UserModelAdapter());
}
