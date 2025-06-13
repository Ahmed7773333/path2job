import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:path2job/hive/favs.dart';

class FavsHiveHelper {
  static const String boxName = 'favsBox';

  static Future<void> addFavs(int favs) async {
    try {
      final box = await Hive.box<FavoritModel>(boxName);
      await box.add(FavoritModel(favs));
    } catch (e) {
      debugPrint('Error adding Favs: $e');
    }
  }

  static Future<List<FavoritModel>> getAllFavss() async {
    final box = await Hive.box<FavoritModel>(boxName);
    return box.values.toList();
  }

  static Future<void> deleteFavs(int favs) async {
    try {
      final box = await Hive.box<FavoritModel>(boxName);
      await box.deleteAt(favs);
    } catch (e) {
      debugPrint('Error adding Favs: $e');
    }
  }

  static Future<void> clearAllFavss() async {
    final box = await Hive.box<FavoritModel>(boxName);
    await box.clear();
  }
}
