import 'package:get_it/get_it.dart';
import 'package:path2job/features/auth/data/repositories/repo_impl.dart';
import 'package:path2job/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:path2job/features/home%20layout/presentation/cubit/home_layout_cubit.dart';
import 'package:path2job/features/plan/presentation/cubit/plan_cubit.dart';

import '../../features/auth/data/auth_remote_data_source.dart';
import '../../features/auth/domain/usecases/signin_usecase.dart';
import '../../features/auth/domain/usecases/signup_usecase.dart';

final GetIt sl = GetIt.instance;

void init() {
  // // Core
  // sl.registerLazySingleton<ApiManager>(() => ApiManager());

  // Auth Data sources
  sl.registerLazySingleton<AuthRemoteDataSource>(() => AuthRemoteDataSource());

  // Auth Repository
  sl.registerLazySingleton<AuthRepositoryImpl>(
      () => AuthRepositoryImpl(sl<AuthRemoteDataSource>()));

  // // Auth Use Cases
  sl.registerLazySingleton(() => SignInUseCase(sl<AuthRepositoryImpl>()));
  sl.registerLazySingleton(() => SignUpUseCase(sl<AuthRepositoryImpl>()));

  // Auth Bloc
  sl.registerFactory(() => AuthCubit(sl<SignUpUseCase>(), sl<SignInUseCase>()));
  sl.registerFactory(() => PlanCubit());
  sl.registerFactory(() => HomeLayoutCubit());
}
