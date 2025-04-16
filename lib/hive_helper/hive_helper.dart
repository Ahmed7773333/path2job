import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

import '../hive/user.dart';

class HiveHelper {
  // Box names
  static const String _userBoxName = 'userBox';
  static const String _userId = 'currentUser';

  // Initialize Hive and register adapters
  static Future<void> init() async {
    final appDocumentDir = await getApplicationDocumentsDirectory();
    Hive.init(appDocumentDir.path);

    // Register adapters
    Hive.registerAdapter(UserModelAdapter());

    // Open boxes
    await Hive.openBox<UserModel>(_userBoxName);
  }

  // --------------------- User CRUD Operations ---------------------

  /// Creates or updates a user
  static Future<void> saveUser(UserModel user) async {
    final box = Hive.box<UserModel>(_userBoxName);
    await box.put(_userId, user); // Using email as key
  }

  /// Gets a user by email
  static UserModel? getUser() {
    final box = Hive.box<UserModel>(_userBoxName);
    return box.get(_userId);
  }

  /// Gets all users
  static List<UserModel> getAllUsers() {
    final box = Hive.box<UserModel>(_userBoxName);
    return box.values.toList();
  }

  /// Updates specific fields of a user
  static Future<void> updateUser({
    String? email,
    String? name,
    String? phone,
    String? photoUrl,
  }) async {
    final box = Hive.box<UserModel>(_userBoxName);
    final user = box.get(_userId);
    if (user != null) {
      await box.put(
        _userId,
        UserModel(
          email: email ?? user.email,
          name: name ?? user.name,
          phone: phone ?? user.phone,
        ),
      );
    }
  }

  /// Deletes a user by email
  static Future<void> deleteUser() async {
    final box = Hive.box<UserModel>(_userBoxName);
    await box.delete(_userId);
  }

  /// Clears all users
  static Future<void> clearAllUsers() async {
    final box = Hive.box<UserModel>(_userBoxName);
    await box.clear();
  }

  // --------------------- Helper Methods ---------------------

  /// Closes all boxes
  static Future<void> closeBoxes() async {
    await Hive.close();
  }

  /// Deletes all boxes (for testing/logout)
  static Future<void> deleteAllBoxes() async {
    await Hive.deleteBoxFromDisk(_userBoxName);
  }
}
