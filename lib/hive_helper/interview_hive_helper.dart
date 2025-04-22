import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path2job/hive/question_answer.dart';
import 'package:path2job/hive_helper/user_hive_helper.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class InterviewHiveHelper {
  static const String interviewBox = 'interviewBox';
  final supabase = Supabase.instance.client;

  static Future<void> addInterview(Interviews interview) async {
    try {
      await Supabase.instance.client
          .from('interview')
          .insert(interview.toJson());
      final box = await Hive.box<Interviews>(interviewBox);
      await box.put(interview.keyId, interview);
    } catch (e) {
      debugPrint('Error adding interview: $e');
    }
  }

  static Future<void> deleteInterview(String interviewKey) async {
    try {
      await Supabase.instance.client
          .from('interview')
          .delete()
          .eq('id', interviewKey);
      final box = await Hive.box<Interviews>(interviewBox);
      await box.delete(interviewKey);
    } catch (e) {
      debugPrint('Error deleting interview: $e');
    }
  }

  static Future<void> deleteAllInterviews(String job) async {
    try {
      await Supabase.instance.client
          .from('interview')
          .delete()
          .eq('category', job);
      final box = await Hive.box<Interviews>(interviewBox);
      await box.deleteAll(
          box.keys.where((key) => box.get(key)!.category == job).toList());
    } catch (e) {
      debugPrint('Error deleting all interviews: $e');
    }
  }

  static Future<List<Interviews>> getAllInterviews() async {
    final box = await Hive.box<Interviews>(interviewBox);
    return box.values.toList();
  }

  static Future<void> sync() async {
    try {
      final response = await Supabase.instance.client
          .from('interview')
          .select()
          .eq('key', UserHiveHelper.getUser()!.email);
      final box = await Hive.box<Interviews>(interviewBox);
      for (var interview in response) {
        final interviewObj = Interviews.fromJson(interview);
        await box.put(interviewObj.keyId, interviewObj);
      }
    } catch (e) {
      debugPrint('Error syncing interviews: $e');
    }
  }
}
