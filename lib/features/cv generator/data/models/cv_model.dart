class CVData {
  final String name;
  final String profession;
  final String email;
  final String phone;
  final String address;
  final List<dynamic> socialLinks;
  final List<dynamic> education;
  final List<dynamic> skills;
  final List<dynamic> projects;
  final List<dynamic> experience;
  final List<dynamic> courses;
  final Map<String, String> languages;
  final String summary; // Added for professional summary

  CVData({
    required this.name,
    required this.profession,
    required this.email,
    required this.phone,
    required this.address,
    required this.socialLinks,
    required this.education,
    required this.skills,
    required this.projects,
    required this.experience,
    required this.courses,
    required this.languages,
    required this.summary,
  });
}

class SocialLink {
  final String platform;
  final String url;

  SocialLink({required this.platform, required this.url});
}

class Educations {
  final String institution;
  final String degree;
  final String duration;
  final String description;

  Educations({
    required this.institution,
    required this.degree,
    required this.duration,
    required this.description,
  });
}

class SkillCategory {
  final List<String> skills;

  SkillCategory({required this.skills});
}

class Project {
  final String name;
  final String description;

  Project({required this.name, required this.description});
}

class Experience {
  final String company;
  final String position;
  final String duration;
  final String location;
  final String description;

  Experience({
    required this.company,
    required this.position,
    required this.duration,
    required this.location,
    required this.description,
  });
}

class Course {
  final String name;
  final String platform;

  Course({required this.name, required this.platform});
}
