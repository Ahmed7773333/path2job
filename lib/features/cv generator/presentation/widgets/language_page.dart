import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:path2job/features/cv%20generator/presentation/widgets/review_page.dart';
import '../../../../core/utils/app_color.dart';

class LanguagePage extends StatefulWidget {
  LanguagePage({required this.formData,required this.formKey, super.key});

  final Map<String, dynamic> formData;
  final formKey;

  @override
  State<LanguagePage> createState() => _LanguagePageState();
}

class _LanguagePageState extends State<LanguagePage> {
  String _newLanguage = '';
  String _newProficiency = '';

  void _addLanguage() {
    if (_newLanguage.isNotEmpty && _newProficiency.isNotEmpty) {
      setState(() {
        widget.formData['languages'][_newLanguage] = _newProficiency;
        _newLanguage = '';
        _newProficiency = '';
      });
    }
  }

  void _removeLanguage(String language) {
    setState(() {
      widget.formData['languages'].remove(language);
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(20.r),
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
              SizedBox(width: 16.w),
              Expanded(
                child: TextFormField(
                  decoration: InputDecoration(
                      labelText: 'Proficiency (e.g., Native, B2)'),
                  onChanged: (value) => _newProficiency = value,
                ),
              ),
            ],
          ),
          SizedBox(height: 40.h),
          ElevatedButton(
            onPressed: _addLanguage,
            child: Text('Add Language'),
          ),
          SizedBox(height: 30.h),
          _buildLanguagesList(),
          SizedBox(height: 100.h),
          ElevatedButton(
            style: ButtonStyle(
              fixedSize: WidgetStatePropertyAll(Size(250.w, 50.h)),
              backgroundColor: WidgetStatePropertyAll(Color(0xff46a545))
            ),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ReviewPage(widget.formData)));
            },
            child: Text('Review CV'),
          ),
        ],
      ),
    );
  }

  Widget _buildLanguagesList() {
    if (widget.formData['languages'].isEmpty) {
      return Text('No languages added yet');
    }
    return Column(
      children: (widget.formData['languages'] as Map)
          .entries
          .map<Widget>((entry) => Card(
                elevation: 0,
                margin: EdgeInsets.all(8.r),
                shape: RoundedRectangleBorder(
                  side: BorderSide(color: AppColor.primaryColor, width: 1.w),
                  borderRadius: BorderRadius.circular(16.r),
                ),
                child: ListTile(
                  title: Text('${entry.key}   •   ${entry.value}'),
                  // subtitle: Text(entry.value),
                  trailing: IconButton(
                    icon: Icon(
                      Icons.delete,
                      color: Colors.red,
                      size: 26.sp,
                    ),
                    onPressed: () => _removeLanguage(entry.key),
                  ),
                ),
              ))
          .toList(),
    );
  }
}
