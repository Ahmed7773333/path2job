import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProjectPage extends StatefulWidget {
  const ProjectPage({required this.formData, super.key});

  final Map<String, dynamic> formData;

  @override
  State<ProjectPage> createState() => _ProjectPageState();
}

class _ProjectPageState extends State<ProjectPage> {
  final _projectFormKey = GlobalKey<FormState>();
  String _newProjectName = '';
  String _newProjectDescription = '';

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(20.r),
      child: Column(
        children: [
          Form(
            key: _projectFormKey,
            child: Column(
              children: [
                TextFormField(
                  decoration: InputDecoration(labelText: 'Project Name'),
                  onChanged: (value) => _newProjectName = value,
                ),
                SizedBox(height: 16.h),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Description'),
                  maxLines: 3,
                  onChanged: (value) => _newProjectDescription = value,
                ),
                SizedBox(height: 32.h),
                ElevatedButton(
                  onPressed: _addProject,
                  child: Text('Add Project'),
                ),
              ],
            ),
          ),
          SizedBox(height: 32.h),
          _buildProjectsList(),
        ],
      ),
    );
  }

  void _addProject() {
    if (_newProjectName.isNotEmpty) {
      setState(() {
        widget.formData['projects'].add({
          'name': _newProjectName,
          'description': _newProjectDescription,
        });
        _projectFormKey.currentState?.reset();
        _newProjectName = '';
        _newProjectDescription = '';
      });
    }
  }

  Widget _buildProjectsList() {
    if (widget.formData['projects'].isEmpty) {
      return Text('No projects added yet');
    }
    return Column(
      children: widget.formData['projects']
          .map<Widget>((project) => Card(
                elevation: 0,
                margin: EdgeInsets.all(8.r),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16.r)),
                child: ListTile(
                  title: Text(project['name']),
                  subtitle: Text(project['description']),
                  trailing: IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () => _removeProject(project),
                  ),
                ),
              ))
          .toList(),
    );
  }

  void _removeProject(Map<String, dynamic> project) {
    setState(() {
      widget.formData['projects'].remove(project);
    });
  }
}
