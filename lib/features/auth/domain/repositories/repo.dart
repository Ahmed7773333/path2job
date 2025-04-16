import 'package:path2job/features/auth/data/models/auth_model.dart';

abstract class AuthRepository {
  Future<void> signUp(AuthModel authEntity);
  Future<void> signIn(AuthModel authEntity);
}
