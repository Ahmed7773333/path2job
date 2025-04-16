import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path2job/core/constants/constants.dart';
import 'package:path2job/hive_helper/hive_helper.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'core/utils/get_itt.dart' as di;

import 'core/utils/get_itt.dart';
import 'core/utils/my_bloc_observer.dart';
import 'features/auth/presentation/cubit/auth_cubit.dart';
import 'my_app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  HiveHelper.init();
  di.init();
  Bloc.observer = MyBlocObserver();
  await Supabase.initialize(
    url: Constants.supabaseUrl,
    anonKey: Constants.supabaseKey,
    authOptions: FlutterAuthClientOptions(
      localStorage: const EmptyLocalStorage(),
    ),
  );
  runApp(MultiBlocProvider(providers: [
    BlocProvider(create: (_) => sl<AuthCubit>()),
  ], child: MyApp()));
}
