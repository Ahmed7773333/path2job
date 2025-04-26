import 'package:flutter/material.dart';
import '../../../../core/network/gemini_helper.dart';

class SkillsPage extends StatefulWidget {
  final Map<String, dynamic> formData;

  const SkillsPage({required this.formData, super.key});

  @override
  State<SkillsPage> createState() => _SkillsPageState();
}

class _SkillsPageState extends State<SkillsPage> {
  final _skillFormKey = GlobalKey<FormState>();
  String _newSkill = '';
  final GeminiHelper _geminiHelper = GeminiHelper();

  @override
  void initState() {
    super.initState();
    // Ensure skills is initialized as a list (not categories)
    if (!widget.formData.containsKey('skills')) {
      widget.formData['skills'] = [];
    }
  }

  void _addSkill() {
    if (_newSkill.isNotEmpty) {
      setState(() {
        widget.formData['skills'].add(_newSkill);
        _skillFormKey.currentState?.reset();
        _newSkill = '';
      });
    }
  }

  // Generate skills using Gemini
  void _generateSkills() async {
    final profession = widget.formData['profession'] ?? 'Software Engineer';
    try {
      final skills = await _geminiHelper
          .collectStreamToList(_geminiHelper.streamAListOfSkills(profession));
      setState(() {
        // Add new skills, avoiding duplicates
        for (var skill in skills) {
          if (!widget.formData['skills'].contains(skill)) {
            widget.formData['skills'].add(skill);
          }
        }
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error generating skills: $e')),
      );
    }
  }

  void _removeSkill(String skill) {
    setState(() {
      widget.formData['skills'].remove(skill);
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          Form(
            key: _skillFormKey,
            child: Column(
              children: [
                TextFormField(
                  decoration: const InputDecoration(
                      labelText: 'Skill (e.g., Dart, Flutter)'),
                  onChanged: (value) => _newSkill = value,
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: _addSkill,
                        child: const Text('Add Skill'),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: _generateSkills,
                        child: const Text('Generate Skills'),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          _buildSkillsList(),
        ],
      ),
    );
  }

  Widget _buildSkillsList() {
    if (widget.formData['skills'].isEmpty) {
      return const Text('No skills added yet');
    }
    return Wrap(
      spacing: 8,
      children: widget.formData['skills']
          .map<Widget>((skill) => Chip(
                label: Text(skill),
                deleteIcon: const Icon(Icons.close, size: 16),
                onDeleted: () => _removeSkill(skill),
              ))
          .toList(),
    );
  }
}