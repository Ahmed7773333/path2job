import 'package:flutter/material.dart';

class ExperiencePage extends StatefulWidget {
  final Map<String, dynamic> formData;

  const ExperiencePage({required this.formData});

  @override
  _ExperiencePageState createState() => _ExperiencePageState();
}

class _ExperiencePageState extends State<ExperiencePage> {
  final _experienceFormKey = GlobalKey<FormState>();
  String _newCompany = '';
  String _newPosition = '';
  String _newExpDuration = '';
  String _newLocation = '';
  String _newExpDescription = '';

  void _addExperience() {
    if (_newCompany.isNotEmpty && _newPosition.isNotEmpty) {
      setState(() {
        widget.formData['experience'].add({
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

  void _removeExperience(Map<String, dynamic> experience) {
    setState(() {
      widget.formData['experience'].remove(experience);
    });
  }

  @override
  Widget build(BuildContext context) {
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
                  decoration: InputDecoration(
                      labelText: 'Duration (e.g., Aug 2022 - Present)'),
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

  Widget _buildExperienceList() {
    if (widget.formData['experience'].isEmpty) {
      return Text('No experience added yet');
    }
    return Column(
      children: widget.formData['experience']
          .map<Widget>((exp) => ListTile(
                title: Text(exp['company']),
                subtitle: Text('${exp['position']} • ${exp['duration']}'),
                trailing: IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () => _removeExperience(exp),
                ),
              ))
          .toList(),
    );
  }
}
