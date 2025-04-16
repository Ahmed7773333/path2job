import 'package:flutter/material.dart';
import 'package:path2job/features/auth/presentation/pages/sign_in.dart';
import 'package:path2job/features/auth/presentation/pages/sign_up.dart';
import 'package:path2job/features/home%20layout/presentation/pages/home_layout.dart';

import '../utils/app_animations.dart';

class Routes {
  static const String splach = '/';
  static const String signIn = 'SignIn';
  static const String home = 'home';

  static const String signUp = 'signUp';
}

class RouteGenerator {
  static Route<dynamic> getRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.splach:
        return RightRouting(SignUpPage());
      case Routes.signUp:
        return LeftRouting(SignUpPage());
      case Routes.signIn:
        return LeftRouting(SignInPage());
      case Routes.home:
        return LeftRouting(HomeLayout());

      default:
        return unDefinedScreen();
    }
  }

  static Route<dynamic> unDefinedScreen() {
    return MaterialPageRoute(
      builder: (_) => Scaffold(
        appBar: AppBar(
          title: Text('  // AppStrings.noRoute,'
              // style: AppStyles.titleStyle,
              ),
        ),
        body: Center(
          child: Text(' // AppStrings.noRoute,'
              // style: AppStyles.titleStyle,
              ),
        ),
      ),
    );
  }
}
