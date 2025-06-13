import 'package:flutter/material.dart';
import 'package:path2job/features/Interview/presentation/pages/interview.dart';
import 'package:path2job/features/Interview/presentation/widgets/category_faq.dart';
import 'package:path2job/features/auth/presentation/pages/sign_in.dart';
import 'package:path2job/features/auth/presentation/pages/sign_up.dart';
import 'package:path2job/features/cv%20generator/presentation/pages/cv_form.dart';
import 'package:path2job/features/home%20layout%20hr/data/models/candidate_model.dart';
import 'package:path2job/features/home%20layout%20hr/presentation/pages/candidate_details.dart';
import 'package:path2job/features/home%20layout%20hr/presentation/pages/favorite.dart';
import 'package:path2job/features/home%20layout/presentation/pages/home_layout.dart';
import 'package:path2job/features/home%20layout/presentation/widgets/about_page.dart';
import 'package:path2job/features/home%20layout/presentation/widgets/terms_page.dart';
import 'package:path2job/features/plan/presentation/pages/ai_plan_page.dart';
import 'package:path2job/features/plan/presentation/widgets/course_detail.dart';
import 'package:path2job/features/splach_screen.dart';

import '../../features/home layout hr/presentation/pages/home_layout_hr.dart';
import '../../features/plan/presentation/pages/custom_plan_page.dart';
import '../../features/plan/presentation/pages/plan.dart';
import '../utils/app_animations.dart';

class Routes {
  static const String splach = '/';
  static const String signIn = 'SignIn';
  static const String home = 'home';

  static const String signUp = 'signUp';
  static const String about = 'about';
  static const String terms = 'terms';
  static const String aiPage = 'aiPage';
  static const String plan = 'plan';
  static const String interview = 'interview';

  static const String customPage = 'customPage';

  static const String courseDetails = 'courseDetails';
  static const String categoryFaq = 'categoryFaq';
  static const String cvGenerator = 'cvGenerator';

  static const String homeHr = 'homeHr';
  static const String candidateDetails = 'candidateDetails';
  static const String favorite = 'favorite';
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
      case Routes.homeHr:
        return LeftRouting(HomeLayoutHr());
      case Routes.about:
        return TopRouting(AboutPage());
      case Routes.terms:
        return TopRouting(TermsPage());
      case Routes.cvGenerator:
        return TopRouting(CVForm());
      case Routes.plan:
        return TopRouting(CareerPlanPage());
      case Routes.interview:
        return TopRouting(InterviewPage());
      case Routes.candidateDetails:
        final candidate = settings.arguments as CandidateModel;
        return TopRouting(CandidateDetails(candidate));
      // return TopRouting(CVPreviewPage());

      case Routes.aiPage:
        return BottomRouting(AiPlanPage());
      case Routes.favorite:
        return BottomRouting(FavoritePage());
      case Routes.customPage:
        return BottomRouting(CustomPlanPage());
      case Routes.courseDetails:
        final course = settings.arguments as String;
        return TopRouting(CourseDetailsPage(
          course: course,
        ));
      case Routes.categoryFaq:
        final category = settings.arguments as String;
        return TopRouting(CategoryFaq(
          category,
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
