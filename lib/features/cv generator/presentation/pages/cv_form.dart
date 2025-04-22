import 'package:flutter/material.dart';
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
    'linkedIn': '',
    'github': '',
    'leetCode': '',
    'education': [],
    'skills': [],
    'projects': [],
    'experience': [],
    'courses': [],
    'languages': {},
  };

  // Temporary variables for adding items
  final _educationFormKey = GlobalKey<FormState>();
  final _experienceFormKey = GlobalKey<FormState>();
  final _skillFormKey = GlobalKey<FormState>();
  final _projectFormKey = GlobalKey<FormState>();
  final _courseFormKey = GlobalKey<FormState>();
  
  String _newInstitution = '';
  String _newDegree = '';
  String _newDuration = '';
  String _newDescription = '';
  
  String _newCompany = '';
  String _newPosition = '';
  String _newExpDuration = '';
  String _newLocation = '';
  String _newExpDescription = '';
  
  String _newSkillCategory = '';
  String _newSkill = '';
  
  String _newProjectName = '';
  String _newProjectDescription = '';
  
  String _newCourseName = '';
  String _newCoursePlatform = '';
  
  String _newLanguage = '';
  String _newProficiency = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Create Your CV')),
      body: PageView(
        controller: _pageController,
        physics: NeverScrollableScrollPhysics(),
        onPageChanged: (index) => setState(() => _currentPage = index),
        children: [
          _buildPersonalInfoPage(),
          _buildEducationPage(),
          _buildExperiencePage(),
          _buildSkillsPage(),
          _buildProjectsPage(),
          _buildCoursesPage(),
          _buildLanguagesPage(),
          _buildReviewPage(),
        ],
      ),
      bottomNavigationBar: _buildNavigationControls(),
    );
  }

  Widget _buildPersonalInfoPage() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(20),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            TextFormField(
              decoration: InputDecoration(labelText: 'Full Name'),
              validator: (value) => value!.isEmpty ? 'Required' : null,
              onSaved: (value) => _formData['name'] = value!,
            ),
            SizedBox(height: 16),
            TextFormField(
              decoration: InputDecoration(labelText: 'Profession'),
              validator: (value) => value!.isEmpty ? 'Required' : null,
              onSaved: (value) => _formData['profession'] = value!,
            ),
            SizedBox(height: 16),
            TextFormField(
              decoration: InputDecoration(labelText: 'Email'),
              validator: (value) => value!.isEmpty ? 'Required' : null,
              onSaved: (value) => _formData['email'] = value!,
            ),
            SizedBox(height: 16),
            TextFormField(
              decoration: InputDecoration(labelText: 'Phone'),
              validator: (value) => value!.isEmpty ? 'Required' : null,
              onSaved: (value) => _formData['phone'] = value!,
            ),
            SizedBox(height: 16),
            TextFormField(
              decoration: InputDecoration(labelText: 'Address'),
              onSaved: (value) => _formData['address'] = value!,
            ),
            SizedBox(height: 16),
            TextFormField(
              decoration: InputDecoration(labelText: 'LinkedIn URL'),
              onSaved: (value) => _formData['linkedIn'] = value!,
            ),
            SizedBox(height: 16),
            TextFormField(
              decoration: InputDecoration(labelText: 'GitHub URL'),
              onSaved: (value) => _formData['github'] = value!,
            ),
            SizedBox(height: 16),
            TextFormField(
              decoration: InputDecoration(labelText: 'LeetCode Profile'),
              onSaved: (value) => _formData['leetCode'] = value!,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEducationPage() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(20),
      child: Column(
        children: [
          Form(
            key: _educationFormKey,
            child: Column(
              children: [
                TextFormField(
                  decoration: InputDecoration(labelText: 'Institution'),
                  onChanged: (value) => _newInstitution = value,
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Degree/Program'),
                  onChanged: (value) => _newDegree = value,
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Duration (e.g., 2018-2022)'),
                  onChanged: (value) => _newDuration = value,
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Description (e.g., GPA)'),
                  onChanged: (value) => _newDescription = value,
                ),
                SizedBox(height: 16),
                ElevatedButton(
                  onPressed: _addEducation,
                  child: Text('Add Education'),
                ),
              ],
            ),
          ),
          SizedBox(height: 24),
          _buildEducationList(),
        ],
      ),
    );
  }

  Widget _buildExperiencePage() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(20),
      child: Column(
        children: [
          Form(
            key: _experienceFormKey,
            child: Column(
              children: [
                TextFormField(
                  decoration: InputDecoration(labelText: 'Company'),
                  onChanged: (value) => _newCompany = value,
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Position'),
                  onChanged: (value) => _newPosition = value,
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Duration (e.g., Aug 2022 - Present)'),
                  onChanged: (value) => _newExpDuration = value,
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Location'),
                  onChanged: (value) => _newLocation = value,
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Description'),
                  maxLines: 3,
                  onChanged: (value) => _newExpDescription = value,
                ),
                SizedBox(height: 16),
                ElevatedButton(
                  onPressed: _addExperience,
                  child: Text('Add Experience'),
                ),
              ],
            ),
          ),
          SizedBox(height: 24),
          _buildExperienceList(),
        ],
      ),
    );
  }

  Widget _buildSkillsPage() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(20),
      child: Column(
        children: [
          Form(
            key: _skillFormKey,
            child: Column(
              children: [
                TextFormField(
                  decoration: InputDecoration(labelText: 'Skill Category (e.g., Programming Languages)'),
                  onChanged: (value) => _newSkillCategory = value,
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Skill (e.g., Dart, Flutter)'),
                  onChanged: (value) => _newSkill = value,
                ),
                SizedBox(height: 16),
                ElevatedButton(
                  onPressed: _addSkill,
                  child: Text('Add Skill'),
                ),
              ],
            ),
          ),
          SizedBox(height: 24),
          _buildSkillsList(),
        ],
      ),
    );
  }

  Widget _buildProjectsPage() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(20),
      child: Column(
        children: [
          Form(
            key: _projectFormKey,
            child: Column(
              children: [
                TextFormField(
                  decoration: InputDecoration(labelText: 'Project Name'),
                  onChanged: (value) => _newProjectName = value,
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Description'),
                  maxLines: 3,
                  onChanged: (value) => _newProjectDescription = value,
                ),
                SizedBox(height: 16),
                ElevatedButton(
                  onPressed: _addProject,
                  child: Text('Add Project'),
                ),
              ],
            ),
          ),
          SizedBox(height: 24),
          _buildProjectsList(),
        ],
      ),
    );
  }

  Widget _buildCoursesPage() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(20),
      child: Column(
        children: [
          Form(
            key: _courseFormKey,
            child: Column(
              children: [
                TextFormField(
                  decoration: InputDecoration(labelText: 'Course Name'),
                  onChanged: (value) => _newCourseName = value,
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Platform (e.g., Udemy)'),
                  onChanged: (value) => _newCoursePlatform = value,
                ),
                SizedBox(height: 16),
                ElevatedButton(
                  onPressed: _addCourse,
                  child: Text('Add Course'),
                ),
              ],
            ),
          ),
          SizedBox(height: 24),
          _buildCoursesList(),
        ],
      ),
    );
  }

  Widget _buildLanguagesPage() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(20),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  decoration: InputDecoration(labelText: 'Language'),
                  onChanged: (value) => _newLanguage = value,
                ),
              ),
              SizedBox(width: 16),
              Expanded(
                child: TextFormField(
                  decoration: InputDecoration(labelText: 'Proficiency (e.g., Native, B2)'),
                  onChanged: (value) => _newProficiency = value,
                ),
              ),
            ],
          ),
          SizedBox(height: 16),
          ElevatedButton(
            onPressed: _addLanguage,
            child: Text('Add Language'),
          ),
          SizedBox(height: 24),
          _buildLanguagesList(),
        ],
      ),
    );
  }

  Widget _buildReviewPage() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Personal Information', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          _buildReviewItem('Name', _formData['name']),
          _buildReviewItem('Profession', _formData['profession']),
          _buildReviewItem('Email', _formData['email']),
          _buildReviewItem('Phone', _formData['phone']),
          _buildReviewItem('Address', _formData['address']),
          _buildReviewItem('LinkedIn', _formData['linkedIn']),
          _buildReviewItem('GitHub', _formData['github']),
          _buildReviewItem('LeetCode', _formData['leetCode']),
          
          SizedBox(height: 24),
          Text('Education', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          ..._formData['education'].map((edu) => _buildReviewItem(edu['institution'], '${edu['degree']} • ${edu['duration']}')).toList(),
          
          // Similar sections for Experience, Skills, Projects, Courses, Languages
        ],
      ),
    );
  }

  Widget _buildReviewItem(String label, String? value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: TextStyle(fontWeight: FontWeight.bold)),
          Text(value ?? 'Not provided'),
          Divider(),
        ],
      ),
    );
  }

  // List builders for each section
  Widget _buildEducationList() {
    if (_formData['education'].isEmpty) {
      return Text('No education added yet');
    }
    return Column(
      children: _formData['education'].map<Widget>((edu) => ListTile(
        title: Text(edu['institution']),
        subtitle: Text('${edu['degree']} • ${edu['duration']}'),
        trailing: IconButton(
          icon: Icon(Icons.delete),
          onPressed: () => _removeEducation(edu),
        ),
      )).toList(),
    );
  }

  Widget _buildExperienceList() {
    if (_formData['experience'].isEmpty) {
      return Text('No experience added yet');
    }
    return Column(
      children: _formData['experience'].map<Widget>((exp) => ListTile(
        title: Text(exp['company']),
        subtitle: Text('${exp['position']} • ${exp['duration']}'),
        trailing: IconButton(
          icon: Icon(Icons.delete),
          onPressed: () => _removeExperience(exp),
        ),
      )).toList(),
    );
  }

  Widget _buildSkillsList() {
    if (_formData['skills'].isEmpty) {
      return Text('No skills added yet');
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: _formData['skills'].map<Widget>((skill) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(skill['category'], style: TextStyle(fontWeight: FontWeight.bold)),
          Wrap(
            children: skill['skills'].map<Widget>((s) => Chip(
              label: Text(s),
              deleteIcon: Icon(Icons.close, size: 16),
              onDeleted: () => _removeSkill(skill, s),
            )).toList(),
          ),
          Divider(),
        ],
      )).toList(),
    );
  }

  Widget _buildProjectsList() {
    if (_formData['projects'].isEmpty) {
      return Text('No projects added yet');
    }
    return Column(
      children: _formData['projects'].map<Widget>((project) => ListTile(
        title: Text(project['name']),
        subtitle: Text(project['description']),
        trailing: IconButton(
          icon: Icon(Icons.delete),
          onPressed: () => _removeProject(project),
        ),
      )).toList(),
    );
  }

  Widget _buildCoursesList() {
    if (_formData['courses'].isEmpty) {
      return Text('No courses added yet');
    }
    return Column(
      children: _formData['courses'].map<Widget>((course) => ListTile(
        title: Text(course['name']),
        subtitle: Text(course['platform']),
        trailing: IconButton(
          icon: Icon(Icons.delete),
          onPressed: () => _removeCourse(course),
        ),
      )).toList(),
    );
  }

  Widget _buildLanguagesList() {
    if (_formData['languages'].isEmpty) {
      return Text('No languages added yet');
    }
    return Column(
      children: (_formData['languages'] as Map).entries.map<Widget>((entry) => ListTile(
        title: Text(entry.key),
        subtitle: Text(entry.value),
        trailing: IconButton(
          icon: Icon(Icons.delete),
          onPressed: () => _removeLanguage(entry.key),
        ),
      )).toList(),
    );
  }

  // Add methods for each section
  void _addEducation() {
    if (_newInstitution.isNotEmpty && _newDegree.isNotEmpty) {
      setState(() {
        _formData['education'].add({
          'institution': _newInstitution,
          'degree': _newDegree,
          'duration': _newDuration,
          'description': _newDescription,
        });
        _educationFormKey.currentState?.reset();
        _newInstitution = '';
        _newDegree = '';
        _newDuration = '';
        _newDescription = '';
      });
    }
  }

  void _addExperience() {
    if (_newCompany.isNotEmpty && _newPosition.isNotEmpty) {
      setState(() {
        _formData['experience'].add({
          'company': _newCompany,
          'position': _newPosition,
          'duration': _newExpDuration,
          'location': _newLocation,
          'description': _newExpDescription,
        });
        _experienceFormKey.currentState?.reset();
        _newCompany = '';
        _newPosition = '';
        _newExpDuration = '';
        _newLocation = '';
        _newExpDescription = '';
      });
    }
  }

  void _addSkill() {
    if (_newSkillCategory.isNotEmpty && _newSkill.isNotEmpty) {
      setState(() {
        // Check if category exists
        var categoryIndex = _formData['skills'].indexWhere((s) => s['category'] == _newSkillCategory);
        if (categoryIndex >= 0) {
          _formData['skills'][categoryIndex]['skills'].add(_newSkill);
        } else {
          _formData['skills'].add({
            'category': _newSkillCategory,
            'skills': [_newSkill],
          });
        }
        _skillFormKey.currentState?.reset();
        _newSkillCategory = '';
        _newSkill = '';
      });
    }
  }

  void _addProject() {
    if (_newProjectName.isNotEmpty) {
      setState(() {
        _formData['projects'].add({
          'name': _newProjectName,
          'description': _newProjectDescription,
        });
        _projectFormKey.currentState?.reset();
        _newProjectName = '';
        _newProjectDescription = '';
      });
    }
  }

  void _addCourse() {
    if (_newCourseName.isNotEmpty) {
      setState(() {
        _formData['courses'].add({
          'name': _newCourseName,
          'platform': _newCoursePlatform,
        });
        _courseFormKey.currentState?.reset();
        _newCourseName = '';
        _newCoursePlatform = '';
      });
    }
  }

  void _addLanguage() {
    if (_newLanguage.isNotEmpty && _newProficiency.isNotEmpty) {
      setState(() {
        _formData['languages'][_newLanguage] = _newProficiency;
        _newLanguage = '';
        _newProficiency = '';
      });
    }
  }

  // Remove methods for each section
  void _removeEducation(Map<String, dynamic> education) {
    setState(() {
      _formData['education'].remove(education);
    });
  }

  void _removeExperience(Map<String, dynamic> experience) {
    setState(() {
      _formData['experience'].remove(experience);
    });
  }

  void _removeSkill(Map<String, dynamic> category, String skill) {
    setState(() {
      category['skills'].remove(skill);
      if (category['skills'].isEmpty) {
        _formData['skills'].remove(category);
      }
    });
  }

  void _removeProject(Map<String, dynamic> project) {
    setState(() {
      _formData['projects'].remove(project);
    });
  }

  void _removeCourse(Map<String, dynamic> course) {
    setState(() {
      _formData['courses'].remove(course);
    });
  }

  void _removeLanguage(String language) {
    setState(() {
      _formData['languages'].remove(language);
    });
  }

  Widget _buildNavigationControls() {
    return Padding(
      padding: EdgeInsets.all(20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          if (_currentPage > 0)
            ElevatedButton(
              onPressed: () => _pageController.previousPage(
                duration: Duration(milliseconds: 300),
                curve: Curves.easeInOut),
              child: Text('Back')),
          ElevatedButton(
            onPressed: _goToNextPage,
            child: Text(_currentPage == 7 ? 'Generate CV' : 'Next')),
        ],
      ),
    );
  }

  void _goToNextPage() {
    if (_currentPage < 7) {
      if (_currentPage == 0 && !_formKey.currentState!.validate()) {
        return;
      }
      _pageController.nextPage(
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut);
    } else {
      _generateCV();
    }
  }

  void _generateCV() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      
      // Convert form data to CVData model
      final cvData = CVData(
        name: _formData['name'],
        profession: _formData['profession'],
        email: _formData['email'],
        phone: _formData['phone'],
        address: _formData['address'],
        linkedIn: _formData['linkedIn'],
        github: _formData['github'],
        leetCode: _formData['leetCode'],
        education: _formData['education'].map((e) => Education(
          institution: e['institution'],
          degree: e['degree'],
          duration: e['duration'],
          description: e['description'],
        )).toList(),
        skills: _formData['skills'].map((s) => SkillCategory(
          category: s['category'],
          skills: List<String>.from(s['skills']),
        )).toList(),
        projects: _formData['projects'].map((p) => Project(
          name: p['name'],
          description: p['description'],
        )).toList(),
        experience: _formData['experience'].map((e) => Experience(
          company: e['company'],
          position: e['position'],
          duration: e['duration'],
          location: e['location'],
          description: e['description'],
        )).toList(),
        courses: _formData['courses'].map((c) => Course(
          name: c['name'],
          platform: c['platform'],
        )).toList(),
        languages: Map<String, String>.from(_formData['languages']),
      );

      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => CVPreviewPage(cvData: cvData)),
      );
    }
  }
}