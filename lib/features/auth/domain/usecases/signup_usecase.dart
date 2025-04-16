import 'package:path2job/features/auth/data/models/auth_model.dart';

import '../repositories/repo.dart';

class SignUpUseCase {
  final AuthRepository repository;
  SignUpUseCase(this.repository);

  Future<void> call(AuthModel authEntity) => repository.signUp(authEntity);
}
