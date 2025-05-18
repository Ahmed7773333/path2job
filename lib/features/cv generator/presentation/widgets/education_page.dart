import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/utils/app_color.dart';

class EducationPagee extends StatefulWidget {
  final Map<String, dynamic> formData;

  const EducationPagee({required this.formData});

  @override
  _EducationPageeState createState() => _EducationPageeState();
}

class _EducationPageeState extends State<EducationPagee> {
  final _educationFormKey = GlobalKey<FormState>();
  String _newInstitution = '';
  String _newDegree = '';
  String _newDuration = '';
  String _newDescription = '';

  void _addEducation() {
    if (_newInstitution.isNotEmpty && _newDegree.isNotEmpty) {
      setState(() {
        widget.formData['education'].add({
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

  void _removeEducation(Map<String, dynamic> education) {
    setState(() {
      widget.formData['education'].remove(education);
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(20.r),
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
                SizedBox(
                  height: 16.h,
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Degree/Program'),
                  onChanged: (value) => _newDegree = value,
                ),
                SizedBox(
                  height: 16.h,
                ),
                TextFormField(
                  decoration:
                      InputDecoration(labelText: 'Duration (e.g., 2018-2022)'),
                  onChanged: (value) => _newDuration = value,
                ),
                SizedBox(
                  height: 16.h,
                ),
                TextFormField(
                  maxLines: 4,
                  decoration:
                      InputDecoration(labelText: 'Description (e.g., GPA)'),
                  onChanged: (value) => _newDescription = value,
                ),
                SizedBox(height: 30.h),
                ElevatedButton(
                  onPressed: _addEducation,
                  child: Text('Add Education'),
                ),
              ],
            ),
          ),
          SizedBox(height: 24.h),
          _buildEducationList(),
        ],
      ),
    );
  }

  Widget _buildEducationList() {
    if (widget.formData['education'].isEmpty) {
      return Text('No education added yet');
    }
    return Column(
      children: widget.formData['education']
          .map<Widget>((edu) => Card(
                elevation: 0,
                margin: EdgeInsets.all(8.r),
                shape: RoundedRectangleBorder(
                  side: BorderSide(color: AppColor.primaryColor, width: 1.w),
                  borderRadius: BorderRadius.circular(16.r),
                ),
                child: ListTile(
                  title: Text('''${edu['institution']}
• ${edu['degree']}'''),
                  subtitle: Text('''• ${edu['duration']}
• ${edu['description']}'''),
                  trailing: IconButton(
                    icon: Icon(Icons.delete,color: Colors.red,size: 26.sp,),
                    onPressed: () => _removeEducation(edu),
                  ),
                ),
              ))
          .toList(),
    );
  }
}
