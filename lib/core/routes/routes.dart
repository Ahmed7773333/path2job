import 'package:flutter/material.dart';
import 'package:path2job/features/Interview/presentation/widgets/category_faq.dart';
import 'package:path2job/features/auth/presentation/pages/sign_in.dart';
import 'package:path2job/features/auth/presentation/pages/sign_up.dart';
import 'package:path2job/features/cv%20generator/presentation/pages/cv_form.dart';
import 'package:path2job/features/cv%20generator/presentation/pages/cv_preview.dart';
import 'package:path2job/features/home%20layout/presentation/pages/home_layout.dart';
import 'package:path2job/features/home%20layout/presentation/widgets/about_page.dart';
import 'package:path2job/features/home%20layout/presentation/widgets/terms_page.dart';
import 'package:path2job/features/plan/presentation/pages/ai_plan_page.dart';
import 'package:path2job/features/plan/presentation/widgets/course_detail.dart';
import 'package:path2job/features/splach_screen.dart';

import '../../features/cv generator/data/models/cv_model.dart';
import '../../features/plan/presentation/pages/custom_plan_page.dart';
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
  static const String categoryFaq = 'categoryFaq';
  static const String cvGenerator = 'cvGenerator';
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
      case Routes.cvGenerator:
        return TopRouting(CVForm());
      case Routes.aiPage:
        return BottomRouting(AiPlanPage());
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

CVData fakeCVData = CVData(
  name: "Ahmed Mohmed Ali",
  profession: "Flutter Developer",
  email: "ahmedmohmedyahoo2@gmail.com",
  phone: "01019665228",
  address: "El-Zayton, Egypt",
  linkedIn: "linkedin.com/in/ahmed-mohmed",
  github: "github.com/ahmedflutter",
  leetCode: "leetcode.com/ahmed_dev",
  education: [
    Education(
      institution: "Sadat Academy",
      degree: "4th Year of Software Engineering",
      duration: "2019 - Present",
      description: "GPA: 3.2 (B)",
    ),
  ],
  skills: [
    SkillCategory(
      category: "Programming Languages",
      skills: ["Dart", "Kotlin", "Java", "Python"],
    ),
    SkillCategory(
      category: "Flutter Development",
      skills: ["BLoC", "Cubit", "Provider", "GetX", "Animation"],
    ),
    SkillCategory(
      category: "Tools & Technologies",
      skills: ["RESTful APIs", "Firebase", "Git", "Jira", "Hive", "SQLite"],
    ),
  ],
  projects: [
    Project(
      name: "Islami App",
      description:
          "A comprehensive Islamic application with Quran, Hadith, and prayer times",
    ),
    Project(
      name: "ToDo.V2",
      description: "Advanced task manager with charts and task history",
    ),
    Project(
      name: "Spotify Clone",
      description: "Music streaming app using Spotify API with custom UI",
    ),
    Project(
      name: "Chat GPT App",
      description:
          "Mobile interface for OpenAI's ChatGPT with conversation history",
    ),
  ],
  experience: [
    Experience(
      company: "IT Sharks Training",
      position: "Intern",
      duration: "Aug 2022",
      location: "Cairo, Egypt",
      description:
          "Contributed to real-world projects under professional guidance",
    ),
    Experience(
      company: "ITI Flutter Training",
      position: "Intern",
      duration: "Aug 2023",
      location: "Cairo, Egypt",
      description:
          "Worked in teams to improve UI skills and state management techniques",
    ),
    Experience(
      company: "Route",
      position: "Flutter Intern",
      duration: "Jul 2023 - Nov 2023",
      location: "Cairo, Egypt",
      description:
          "Built 5 projects using BLoC, Cubit, SQLite, Hive and RESTful APIs",
    ),
  ],
  courses: [
    Course(
      name: "Hive Offline Database in Flutter",
      platform: "Udemy",
    ),
    Course(
      name: "Flutter Animation from Zero to Hero",
      platform: "Udemy",
    ),
    Course(
      name: "Learn Flutter GetX Course",
      platform: "Udemy",
    ),
  ],
  languages: {
    "English": "B2 (Upper Intermediate)",
    "Arabic": "Native",
  },
);
