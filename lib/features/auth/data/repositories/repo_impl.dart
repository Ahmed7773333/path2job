import '../../domain/repositories/repo.dart';
import '../auth_remote_data_source.dart';
import '../models/auth_model.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;

  AuthRepositoryImpl(this.remoteDataSource);

  @override
  Future<void> signUp(AuthModel authEntity) async {
    await remoteDataSource.signUp(
      authEntity,
    );
  }

  @override
  Future<void> signIn(AuthModel authEntity) async {
    await remoteDataSource.signIn(
      authEntity,
    );
  }
}
