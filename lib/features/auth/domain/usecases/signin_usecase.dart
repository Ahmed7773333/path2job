import 'package:path2job/features/auth/data/models/auth_model.dart';

import '../repositories/repo.dart';

class SignInUseCase {
  final AuthRepository repository;
  SignInUseCase(this.repository);

  Future<void> call(AuthModel authEntity) => repository.signIn(authEntity);
}
