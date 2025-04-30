import 'package:hive_flutter/hive_flutter.dart';
import 'package:path2job/hive/recent_acitivty.dart';

class RecentActivityHelper {
  static const String recentActivityBox = 'recent_activity_box';

  static Future<void> addRecentActivity(RecentAcitivty activity) async {
    final box = await Hive.openBox<RecentAcitivty>(recentActivityBox);
    await box.add(activity);
  }

  static Future<List<RecentAcitivty>> getAllActivities() async {
    final box = await Hive.openBox<RecentAcitivty>(recentActivityBox);
    return box.values.toList();
  }

  static Future<void> clearActivities() async {
    final box = await Hive.openBox<RecentAcitivty>(recentActivityBox);
    await box.clear();
  }

  static Future<void> deleteActivity(int index) async {
    final box = await Hive.openBox<RecentAcitivty>(recentActivityBox);
    await box.deleteAt(index);
  }
}
