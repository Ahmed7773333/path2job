import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:path2job/core/constants/constants.dart';
import 'package:path2job/features/home%20layout/presentation/cubit/home_layout_cubit.dart';
import 'package:path2job/features/plan/presentation/cubit/plan_cubit.dart';
import 'package:path2job/hive_helper/user_hive_helper.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'core/utils/get_itt.dart' as di;

import 'core/utils/get_itt.dart';
import 'core/utils/my_bloc_observer.dart';
import 'features/auth/presentation/cubit/auth_cubit.dart';
import 'my_app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Gemini.init(apiKey: Constants.gimeniKey);
  UserHiveHelper.init();
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
    BlocProvider(create: (_) => sl<PlanCubit>()),
    BlocProvider(create: (_) => sl<HomeLayoutCubit>()),
  ], child: MyApp()));
}
