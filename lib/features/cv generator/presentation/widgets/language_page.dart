import 'package:flutter/material.dart';

class LanguagePage extends StatefulWidget {
  const LanguagePage({required this.formData, super.key});
  final Map<String, dynamic> formData;

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
                  decoration: InputDecoration(
                      labelText: 'Proficiency (e.g., Native, B2)'),
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

  Widget _buildLanguagesList() {
    if (widget.formData['languages'].isEmpty) {
      return Text('No languages added yet');
    }
    return Column(
      children: (widget.formData['languages'] as Map)
          .entries
          .map<Widget>((entry) => ListTile(
                title: Text(entry.key),
                subtitle: Text(entry.value),
                trailing: IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () => _removeLanguage(entry.key),
                ),
              ))
          .toList(),
    );
  }
}
