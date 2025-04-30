import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path2job/hive/category.dart';
import 'package:path2job/hive_helper/user_hive_helper.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class CategoryHiveHelper {
  static const String boxName = 'categoryBox';
  static Future<void> syncCategoriss() async {
    try {
      final response = await Supabase.instance.client
          .from('category')
          .select()
          .eq('key', (UserHiveHelper.getUser()?.email)!);
      final box = await Hive.box<Categories>(boxName);
      for (var course in response) {
        final courseObj = Categories.fromJson(course);
        await box.put(courseObj.name, courseObj);
      }
    } catch (e) {
      debugPrint('Error syncing courses: $e');
    }
  }

  static Future<void> addCategory(Categories category) async {
    try {
      await Supabase.instance.client.from('category').insert(category.toJson());
      final box = await Hive.box<Categories>(boxName);
      await box.put(category.name, category);
    } catch (e) {
      debugPrint('Error adding course: $e');
    }
  }

  static Future<List<Categories>> getAllCategories() async {
    final box = await Hive.box<Categories>(boxName);
    return box.values.toList();
  }

  static Future<void> deleteCategory(String categoryKey) async {
    try {
      await Supabase.instance.client
          .from('category')
          .delete()
          .eq('name', categoryKey);
      final box = await Hive.box<Categories>(boxName);
      await box.delete(categoryKey);
    } catch (e) {
      debugPrint('Error deleting course: $e');
    }
  }

  static Future<void> updateCategory(
    String categoryKey, {
    String? name,
    int? numberOfQuestions,
  }) async {
    try {
      final box = Hive.box<Categories>(boxName);
      final category = box.get(categoryKey);
      await Supabase.instance.client.from('category').update({
        'name': name ?? category!.name,
        'numberOfQuestions': numberOfQuestions ?? category!.numberOfQuestions,
      }).eq('name', categoryKey);

      if (category != null) {
        await box.put(
          categoryKey,
          Categories(
            name: name ?? category.name,
            numberOfQuestions: numberOfQuestions ?? category.numberOfQuestions,
          ),
        );
      }
    } catch (e) {
      debugPrint('Error updating course: $e');
    }
  }

  static Future<void> clearAllCategories() async {
    final box = Hive.box<Categories>(boxName);
    await box.clear();
  }
}
