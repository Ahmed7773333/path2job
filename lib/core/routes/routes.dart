import 'package:flutter/material.dart';
import 'package:path2job/features/auth/presentation/pages/sign_in.dart';
import 'package:path2job/features/auth/presentation/pages/sign_up.dart';
import 'package:path2job/features/home%20layout/presentation/pages/home_layout.dart';
import 'package:path2job/features/home%20layout/presentation/widgets/about_page.dart';
import 'package:path2job/features/home%20layout/presentation/widgets/terms_page.dart';
import 'package:path2job/features/plan/presentation/widgets/ai_plan_page.dart';
import 'package:path2job/features/plan/presentation/widgets/course_detail.dart';
import 'package:path2job/features/plan/presentation/widgets/custom_plan_page.dart';
import 'package:path2job/features/splach_screen.dart';

import '../utils/app_animations.dart';

class Routes {
  static const String splach = '/';
  static const String signIn = 'SignIn';
  static const String home = 'home';

  static const String signUp = 'signUp';
  static const String about = 'about';
  static const String terms = 'terms';
  static const String aiPage = 'aiPage';
  static const String customPage = 'customPage';

  static const String courseDetails = 'courseDetails';
}

class RouteGenerator {
  static Route<dynamic> getRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.splach:
        return RightRouting(SplachScreen());
      case Routes.signUp:
        return LeftRouting(SignUpPage());
      case Routes.signIn:
        return LeftRouting(SignInPage());
      case Routes.home:
        return LeftRouting(HomeLayout());
      case Routes.about:
        return TopRouting(AboutPage());
      case Routes.terms:
        return TopRouting(TermsPage());
      case Routes.aiPage:
        return BottomRouting(AiPlanPage());
      case Routes.customPage:
        return BottomRouting(CustomPlanPage());
      case Routes.courseDetails:
        final course = settings.arguments as String;
        return TopRouting(CourseDetailsPage(
          course: course,
        ));

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
