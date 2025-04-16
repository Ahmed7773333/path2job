import 'package:path2job/hive_helper/hive_helper.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../hive/user.dart';
import 'models/auth_model.dart';

class AuthRemoteDataSource {
  final _supabase = Supabase.instance.client;

  Future<void> signUp(AuthModel authModel) async {
    try {
      
      final response = await _supabase.auth.signUp(
        email: authModel.email,
        password: authModel.password,
        data: {
          'name': authModel.name,
          'phone': authModel.phone,
          'job': authModel.job,
        },
      );

      if (response.user == null) throw AuthException('Signup failed');

      HiveHelper.saveUser(UserModel(
        email: authModel.email,
        name: authModel.name,
        phone: authModel.phone,
        job: authModel.job,
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
      HiveHelper.saveUser(UserModel(
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
      HiveHelper.deleteUser();
    } catch (e) {
      throw AuthException(e.toString());
    }
  }
}
