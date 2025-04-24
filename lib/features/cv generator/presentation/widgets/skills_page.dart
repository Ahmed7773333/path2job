import 'package:flutter/material.dart';

class SkillsPage extends StatefulWidget {
  const SkillsPage({required this.formData, super.key});
  final Map<String, dynamic> formData;
  @override
  State<SkillsPage> createState() => _SkillsPageState();
}

class _SkillsPageState extends State<SkillsPage> {
  final _skillFormKey = GlobalKey<FormState>();
  String _newSkillCategory = '';
  String _newSkill = '';
  void _addSkill() {
    if (_newSkillCategory.isNotEmpty && _newSkill.isNotEmpty) {
      setState(() {
        // Check if category exists
        var categoryIndex = widget.formData['skills']
            .indexWhere((s) => s['category'] == _newSkillCategory);
        if (categoryIndex >= 0) {
          widget.formData['skills'][categoryIndex]['skills'].add(_newSkill);
        } else {
          widget.formData['skills'].add({
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

  void _removeSkill(Map<String, dynamic> category, String skill) {
    setState(() {
      category['skills'].remove(skill);
      if (category['skills'].isEmpty) {
        widget.formData['skills'].remove(category);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(20),
      child: Column(
        children: [
          Form(
            key: _skillFormKey,
            child: Column(
              children: [
                TextFormField(
                  decoration: InputDecoration(
                      labelText:
                          'Skill Category (e.g., Programming Languages)'),
                  onChanged: (value) => _newSkillCategory = value,
                ),
                TextFormField(
                  decoration:
                      InputDecoration(labelText: 'Skill (e.g., Dart, Flutter)'),
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

  Widget _buildSkillsList() {
    if (widget.formData['skills'].isEmpty) {
      return Text('No skills added yet');
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: widget.formData['skills']
          .map<Widget>((skill) => Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(skill['category'],
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  Wrap(
                    children: skill['skills']
                        .map<Widget>((s) => Chip(
                              label: Text(s),
                              deleteIcon: Icon(Icons.close, size: 16),
                              onDeleted: () => _removeSkill(skill, s),
                            ))
                        .toList(),
                  ),
                  Divider(),
                ],
              ))
          .toList(),
    );
  }
}
