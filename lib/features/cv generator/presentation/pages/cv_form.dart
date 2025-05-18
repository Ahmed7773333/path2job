import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:path2job/core/utils/app_color.dart';
import 'package:path2job/features/cv%20generator/presentation/widgets/course_page.dart';
import 'package:path2job/features/cv%20generator/presentation/widgets/education_page.dart';
import 'package:path2job/features/cv%20generator/presentation/widgets/experience_page.dart';
import 'package:path2job/features/cv%20generator/presentation/widgets/language_page.dart';
import 'package:path2job/features/cv%20generator/presentation/widgets/navigation_control.dart';
import 'package:path2job/features/cv%20generator/presentation/widgets/personal_info_page.dart';
import 'package:path2job/features/cv%20generator/presentation/widgets/project_page.dart';
import 'package:path2job/features/cv%20generator/presentation/widgets/review_page.dart';
import 'package:path2job/features/cv%20generator/presentation/widgets/skills_page.dart';
import '../../data/models/cv_model.dart';
import 'cv_preview.dart';

class CVForm extends StatefulWidget {
  @override
  _CVFormState createState() => _CVFormState();
}

class _CVFormState extends State<CVForm> {
  final _formKey = GlobalKey<FormState>();
  final _pageController = PageController();
  int _currentPage = 0;

  // Form controllers
  final Map<String, dynamic> _formData = {
    'name': '',
    'profession': '',
    'email': '',
    'phone': '',
    'address': '',
    'summary': '',
    'links': [],
    'education': [],
    'skills': [],
    'projects': [],
    'experience': [],
    'courses': [],
    'languages': {},
  };

  int selectedIndex = 0;

  // Temporary variables for adding items

  @override
  Widget build(BuildContext context) {
    List<Widget> tabs = [
      PersonalInfoPage(
        formData: _formData,
        formKey: _formKey,
      ),
      EducationPagee(formData: _formData),
      ExperiencePage(formData: _formData),
      SkillsPage(formData: _formData),
      ProjectPage(formData: _formData),
      CoursePage(formData: _formData),
      LanguagePage(formData: _formData),
    ];
    return Scaffold(
      appBar: AppBar(title: Text('Create Your CV')),
      body: SingleChildScrollView(
        child: Column(
          children: [
            DefaultTabController(
              length: tabs.length,
              initialIndex: 0,
              child: TabBar(
                  onTap: (index) {
                    selectedIndex = index;
                    setState(() {});
                  },
                  isScrollable: true,
                  indicatorColor: AppColor.primaryColor,
                  indicatorWeight: 5.w,
                  unselectedLabelColor: Colors.black,
                  dividerHeight: 0.h,
                  tabAlignment: TabAlignment.center,
                  indicator: UnderlineTabIndicator(
                      borderSide:
                          BorderSide(color: AppColor.primaryColor, width: 2.w)),
                  tabs: [
                    Tab(
                      text: "Personal Profile",
                    ),
                    Tab(
                      child: Text("Education Page"),
                    ),
                    Tab(
                      child: Text("Experience Page"),
                    ),
                    Tab(
                      child: Text("Skills Page"),
                    ),
                    Tab(
                      child: Text("Project Page"),
                    ),
                    Tab(
                      child: Text("Course Page"),
                    ),
                    Tab(
                      child: Text("Language Page"),
                    ),
                  ]),
            ),
            tabs[selectedIndex],
          ],
        ),
      ),
      // body: PageView(
      //   controller: _pageController,
      //   physics: NeverScrollableScrollPhysics(),
      //   onPageChanged: (index) => setState(() => _currentPage = index),
      //   children: [
      //     PersonalInfoPage(
      //       formData: _formData,
      //       formKey: _formKey,
      //     ),
      //     EducationPagee(formData: _formData),
      //     ExperiencePage(formData: _formData),
      //     SkillsPage(formData: _formData),
      //     ProjectPage(formData: _formData),
      //     CoursePage(formData: _formData),
      //     LanguagePage(formData: _formData),
      //     ReviewPage(_formData),
      //   ],
      // ),
      // bottomNavigationBar: NavigationControls(
      //   currentPage: _currentPage,
      //   pageController: _pageController,
      //   formKey: _formKey,
      //   onGenerateCV: _generateCV,
      // ),
    );
  }

  // List builders for each section

  // Add methods for each section

  // Remove methods for each section

  void _generateCV() {
    if (_formKey.currentState?.validate() ?? false) {
      _formKey.currentState!.save();

      // Convert form data to CVData model
      final cvData = CVData(
        name: _formData['name'],
        summary: _formData['summary'],
        profession: _formData['profession'],
        email: _formData['email'],
        phone: _formData['phone'],
        address: _formData['address'],
        socialLinks: _formData['links']
            .map((link) => SocialLink(
                  platform: link['platform'],
                  url: link['url'],
                ))
            .toList(),
        education: _formData['education']
            .map((e) => Educations(
                  institution: e['institution'],
                  degree: e['degree'],
                  duration: e['duration'],
                  description: e['description'],
                ))
            .toList(),
        skills: _formData['skills']
            .map((s) => SkillCategory(
                  skills: List<String>.from(s['skills']),
                ))
            .toList(),
        projects: _formData['projects']
            .map((p) => Project(
                  name: p['name'],
                  description: p['description'],
                ))
            .toList(),
        experience: _formData['experience']
            .map((e) => Experience(
                  company: e['company'],
                  position: e['position'],
                  duration: e['duration'],
                  location: e['location'],
                  description: e['description'],
                ))
            .toList(),
        courses: _formData['courses']
            .map((c) => Course(
                  name: c['name'],
                  platform: c['platform'],
                ))
            .toList(),
        languages: Map<String, String>.from(_formData['languages']),
      );

      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => CVPreviewPage(cvData: cvData)),
      );
    }
  }
}
