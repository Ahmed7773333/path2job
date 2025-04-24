import 'package:flutter/material.dart';

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
                  decoration:
                      InputDecoration(labelText: 'Duration (e.g., 2018-2022)'),
                  onChanged: (value) => _newDuration = value,
                ),
                TextFormField(
                  decoration:
                      InputDecoration(labelText: 'Description (e.g., GPA)'),
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

  Widget _buildEducationList() {
    if (widget.formData['education'].isEmpty) {
      return Text('No education added yet');
    }
    return Column(
      children: widget.formData['education']
          .map<Widget>((edu) => ListTile(
                title: Text(edu['institution']),
                subtitle: Text('${edu['degree']} • ${edu['duration']}'),
                trailing: IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () => _removeEducation(edu),
                ),
              ))
          .toList(),
    );
  }
}
