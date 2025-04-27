import 'dart:io';

import 'package:path2job/hive_helper/user_hive_helper.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../hive/user.dart';
import 'models/auth_model.dart';

class AuthRemoteDataSource {
  final _supabase = Supabase.instance.client;

  Future<void> signUp(AuthModel authModel) async {
    try {
      String? photoUrl;

      // Upload photo to Supabase Storage if provided
      if (authModel.photo != null) {
        final File file = authModel.photo!;
        final userId = DateTime.now()
            .millisecondsSinceEpoch
            .toString(); // Unique identifier
        final filePath = '$userId/${file.path.split('/').last}';

        // Upload to the 'user_photos' bucket
        await _supabase.storage.from('profile.photos').upload(filePath, file);

        // Get the public URL of the uploaded photo
        photoUrl =
            _supabase.storage.from('profile.photos').getPublicUrl(filePath);
      }

      // Sign up the user with Supabase Auth
      final response = await _supabase.auth.signUp(
        email: authModel.email,
        password: authModel.password,
        data: {
          'name': authModel.name,
          'phone': authModel.phone,
          'job': authModel.job,
          'photo_url': photoUrl, // Store photo URL in user metadata
        },
      );

      if (response.user == null) throw AuthException('Signup failed');

      // Save user data to Hive
      UserHiveHelper.saveUser(UserModel(
        email: authModel.email,
        name: authModel.name,
        phone: authModel.phone,
        job: authModel.job,
        photoUrl: photoUrl, // Save photo URL in Hive
        photoLocal: authModel.photo != null
            ? await authModel.photo!.readAsBytes()
            : null,
      ));
    } catch (e) {
      throw AuthException(e.toString());
    }
  }

  Future<void> signIn(AuthModel authModel) async {
    try {
      final AuthResponse res = await _supabase.auth.signInWithPassword(
        email: authModel.email,
        password: authModel.password,
      );
      final user = res.user;
      UserHiveHelper.saveUser(UserModel(
        email: user?.email ?? '',
        name: user?.userMetadata?['name'] ?? '',
        phone: user?.userMetadata?['phone'] ?? '',
        job: user?.userMetadata?['job'] ?? '',
      ));
    } catch (e) {
      throw AuthException(e.toString());
    }
  }

  Future<void> logout() async {
    try {
      await _supabase.auth.signOut();
      UserHiveHelper.deleteUser();
    } catch (e) {
      throw AuthException(e.toString());
    }
  }
}
