import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../hive/course.dart';

class CourseHiveHelper {
  static const String boxName = 'courseBox';
  final supabase = Supabase.instance.client;

  static Future<void> syncCourses() async {
    try {
      final response = await Supabase.instance.client.from('Courses').select();
      final box = await Hive.openBox<Course>(boxName);
      for (var course in response) {
        final courseObj = Course.fromJson(course);
        await box.put(courseObj.courseName, courseObj);
      }
    } catch (e) {
      debugPrint('Error syncing courses: $e');
    }
  }

  static Future<void> addCourse(Course course) async {
    try {
      await Supabase.instance.client.from('Courses').insert(course.toJson());
      final box = await Hive.openBox<Course>(boxName);
      await box.put(course.courseName, course);
    } catch (e) {
      debugPrint('Error adding course: $e');
    }
  }

  static Future<Course?> getCourse(String courseKey) async {
    final box = await Hive.openBox<Course>(boxName);
    return box.get(courseKey);
  }

  static Future<List<Course>> getAllCourses() async {
    final box = await Hive.openBox<Course>(boxName);
    return box.values.toList();
  }

  static Future<void> deleteCourse(String courseKey) async {
    try {
      await Supabase.instance.client
          .from('Courses')
          .delete()
          .eq('name', courseKey);
      final box = await Hive.openBox<Course>(boxName);
      await box.delete(courseKey);
    } catch (e) {
      debugPrint('Error adding course: $e');
    }
  }

  static Future<void> updateCourse(
    String courseKey, {
    String? link,
    String? name,
    String? description,
    int? numberOfVideos,
    int? numberOfvideosDone,
  }) async {
    try {
      await Supabase.instance.client.from('Courses').update({
        'name': name,
        'description': description,
        'link': link,
        'numberOfvideos': numberOfVideos,
        'numberOfvideosDone': numberOfvideosDone,
      }).eq('name', courseKey);
      final box = Hive.box<Course>(boxName);
      final course = box.get(courseKey);
      if (course != null) {
        await box.put(
          courseKey,
          Course(
            courseName: name ?? course.courseName,
            courseDescription: description ?? course.courseDescription,
            link: link ?? course.link,
            numberOfvideos: numberOfVideos ?? course.numberOfvideos,
            numberOfvideosDone: numberOfvideosDone ?? course.numberOfvideosDone,
          ),
        );
      }
    } catch (e) {
      debugPrint('Error updating course: $e');
    }
  }

  static Future<void> clearAllCourses() async {
    final box = Hive.box<Course>(boxName);
    await box.clear();
  }
}
