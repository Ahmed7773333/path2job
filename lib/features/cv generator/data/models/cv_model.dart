class CVData {
  final String name;
  final String profession;
  final String email;
  final String phone;
  final String address;
  final String linkedIn;
  final String github;
  final String leetCode;
  final List<Education> education;
  final List<SkillCategory> skills;
  final List<Project> projects;
  final List<Experience> experience;
  final List<Course> courses;
  final Map<String, String> languages;

  CVData({
    required this.name,
    required this.profession,
    required this.email,
    required this.phone,
    required this.address,
    required this.linkedIn,
    required this.github,
    required this.leetCode,
    required this.education,
    required this.skills,
    required this.projects,
    required this.experience,
    required this.courses,
    required this.languages,
  });
}

class Education {
  final String institution;
  final String degree;
  final String duration;
  final String description;

  Education({
    required this.institution,
    required this.degree,
    required this.duration,
    required this.description,
  });
}

class SkillCategory {
  final String category;
  final List<String> skills;

  SkillCategory({required this.category, required this.skills});
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