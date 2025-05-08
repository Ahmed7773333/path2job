import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
      padding: EdgeInsets.all(20.r),
      child: Column(
        children: [
          Form(
            key: _courseFormKey,
            child: Column(
              children: [
                TextFormField(
                  decoration: InputDecoration(labelText: 'Course Name',),
                  onChanged: (value) => _newCourseName = value,
                  textInputAction: TextInputAction.next,
                ),
                SizedBox(height: 32.h),
                TextFormField(
                  decoration:
                      InputDecoration(labelText: 'Platform (e.g., Udemy)'),
                  onChanged: (value) => _newCoursePlatform = value,
                  textInputAction: TextInputAction.done,
                ),
                SizedBox(height: 40.h),
                ElevatedButton(
                  onPressed: _addCourse,
                  child: Text('Add Course'),
                ),
              ],
            ),
          ),
          SizedBox(height: 24.h),
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
          .map<Widget>((course) => Card(
            elevation: 0,
            margin: EdgeInsets.all(8.r),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
            child: ListTile(
                  title: Text(course['name']),
                  subtitle: Text(course['platform']),
                  trailing: IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () => _removeCourse(course),
                  ),
                ),
          ))
          .toList(),
    );
  }
}
