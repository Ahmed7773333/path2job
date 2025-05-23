import 'package:flutter/material.dart';
import '../../../../core/network/gemini_helper.dart';

class PersonalInfoPage extends StatefulWidget {
  final GlobalKey<FormState> formKey;
  final Map<String, dynamic> formData;

  const PersonalInfoPage({
    required this.formKey,
    required this.formData,
    Key? key,
  }) : super(key: key);

  @override
  _PersonalInfoPageState createState() => _PersonalInfoPageState();
}

class _PersonalInfoPageState extends State<PersonalInfoPage> {
  final _linkFormKey = GlobalKey<FormState>();
  String _newPlatform = '';
  String _newUrl = '';
  final TextEditingController _summaryController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _professionController = TextEditingController();

  final GeminiHelper _geminiHelper = GeminiHelper();

  @override
  void initState() {
    super.initState();
    // Initialize summary field if it exists in formData
    _summaryController.text = widget.formData['summary'] ?? '';
    _emailController.text = widget.formData['email'] ?? '';
    _phoneController.text = widget.formData['phone'] ?? '';
    _addressController.text = widget.formData['address'] ?? '';
    _nameController.text = widget.formData['name'] ?? '';
    _professionController.text = widget.formData['profession'] ?? '';
  }

  @override
  void dispose() {
    _summaryController.dispose();
    super.dispose();
  }

  // Generate professional summary using Gemini
  void _generateSummary() async {
    final profession = widget.formData['profession'] ?? 'Software Engineer';
    try {
      final summary = await _geminiHelper
          .collectStreamToString(_geminiHelper.streamAProfileText(profession));
      setState(() {
        _summaryController.text = summary.trim();
        widget.formData['summary'] = summary.trim();
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error generating summary: $e')),
      );
    }
  }

  void _addSocialLink() {
    if (_newPlatform.isNotEmpty && _newUrl.isNotEmpty) {
      setState(() {
        if (!widget.formData.containsKey('links')) {
          widget.formData['links'] = [];
        }
        widget.formData['links'].add({
          'platform': _newPlatform,
          'url': _newUrl,
        });
        _linkFormKey.currentState?.reset();
        _newPlatform = '';
        _newUrl = '';
      });
    }
  }

  void _removeSocialLink(int index) {
    setState(() {
      widget.formData['links'].removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Form(
        key: widget.formKey,
        child: Column(
          children: [
            // Basic Info Fields
            TextFormField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: 'Full Name'),
              validator: (value) => value!.isEmpty ? 'Required' : null,
              onChanged: (value) {
                _nameController.text = value;
                widget.formData['name'] = value;
              },
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _professionController,
              decoration: const InputDecoration(labelText: 'Profession'),
              validator: (value) => value!.isEmpty ? 'Required' : null,
              onChanged: (value) {
                _professionController.text = value;
                widget.formData['profession'] = value;
              },
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _emailController,
              decoration: const InputDecoration(labelText: 'Email'),
              validator: (value) => value!.isEmpty ? 'Required' : null,
              onChanged: (value) {
                _emailController.text = value;
                widget.formData['email'] = value;
              },
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _phoneController,
              decoration: const InputDecoration(labelText: 'Phone'),
              validator: (value) => value!.isEmpty ? 'Required' : null,
              onChanged: (value) {
                _phoneController.text = value;
                widget.formData['phone'] = value;
              },
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _addressController,
              decoration: const InputDecoration(labelText: 'Address'),
              onChanged: (value) {
                _addressController.text = value;
                widget.formData['address'] = value;
              },
            ),
            const SizedBox(height: 16),
            // Professional Summary Field
            TextFormField(
              controller: _summaryController,
              decoration: const InputDecoration(
                labelText: 'Professional Summary',
                hintText: 'Enter a brief professional summary',
              ),
              maxLines: 4,
              onChanged: (value) => widget.formData['summary'] = value,
            ),
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: _generateSummary,
              child: const Text('Generate Summary'),
            ),
            // Social Links Section
            const SizedBox(height: 24),
            const Text('Social Links',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            // Add New Link Form
            Form(
              key: _linkFormKey,
              child: Column(
                children: [
                  TextFormField(
                    decoration: const InputDecoration(
                        labelText: 'Platform (e.g., LinkedIn)'),
                    onChanged: (value) => _newPlatform = value,
                  ),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'URL'),
                    onChanged: (value) => _newUrl = value,
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: _addSocialLink,
                    child: const Text('Add Link'),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            _buildlinksList(),
          ],
        ),
      ),
    );
  }

  Widget _buildlinksList() {
    if (!widget.formData.containsKey('links') ||
        widget.formData['links'].isEmpty) {
      return const Text('No links added yet');
    }
    return Column(
      children: List<Widget>.generate(
        widget.formData['links'].length,
        (index) => ListTile(
          title: Text(widget.formData['links'][index]['platform']),
          subtitle: Text(widget.formData['links'][index]['url']),
          trailing: IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () => _removeSocialLink(index),
          ),
        ),
      ),
    );
  }
}
