import 'package:flutter/material.dart';

class CoursePage extends StatefulWidget {
  const CoursePage({required this.formData, super.key});
  final Map<String, dynamic> formData;
  @override
  State<CoursePage> createState() => _CoursePageState();
}

class _CoursePageState extends State<CoursePage> {
  final _courseFormKey = GlobalKey<FormState>();
  String _newCourseName = '';
  String _newCoursePlatform = '';
  void _addCourse() {
    if (_newCourseName.isNotEmpty && _newCoursePlatform.isNotEmpty) {
      setState(() {
        widget.formData['courses'].add({
          'name': _newCourseName,
          'platform': _newCoursePlatform,
        });
        _courseFormKey.currentState?.reset();
        _newCourseName = '';
        _newCoursePlatform = '';
      });
    }
  }

  void _removeCourse(Map<String, dynamic> course) {
    setState(() {
      widget.formData['courses'].remove(course);
    });
  }

  @override
  Widget build(BuildContext context) {
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
                  decoration:
                      InputDecoration(labelText: 'Platform (e.g., Udemy)'),
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

  Widget _buildCoursesList() {
    if (widget.formData['courses'].isEmpty) {
      return Text('No courses added yet');
    }
    return Column(
      children: widget.formData['courses']
          .map<Widget>((course) => ListTile(
                title: Text(course['name']),
                subtitle: Text(course['platform']),
                trailing: IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () => _removeCourse(course),
                ),
              ))
          .toList(),
    );
  }
}
