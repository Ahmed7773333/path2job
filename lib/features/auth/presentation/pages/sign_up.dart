import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path2job/core/utils/app_color.dart';
import 'package:path2job/core/utils/assets.dart';
import 'package:path2job/core/utils/componetns.dart';
import 'package:path2job/features/auth/data/models/auth_model.dart';
import '../../../../core/routes/routes.dart';
import '../cubit/auth_cubit.dart';

class SignUpPage extends StatefulWidget {
  SignUpPage({super.key});

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _emailController = TextEditingController();
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _jobController = TextEditingController();
  final _passwordController = TextEditingController();
  File? _selectedImage;

  // Pick image from gallery or camera
  Future<void> _pickImage(ImageSource source) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: source);

    if (pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            spacing: 16,
            children: [
              SizedBox(height: 8),
              Image.asset(
                Assets.logo,
                height: 200,
                width: 200,
              ),
              // Display selected image or placeholder
              _selectedImage != null
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.file(
                        _selectedImage!,
                        height: 100,
                        width: 100,
                        fit: BoxFit.cover,
                      ),
                    )
                  : Container(
                      height: 100,
                      width: 100,
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Icon(Icons.person, size: 50, color: Colors.grey),
                    ),
              // Buttons to pick image
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () => _pickImage(ImageSource.gallery),
                    child: Text('Pick from Gallery'),
                  ),
                  SizedBox(width: 8),
                  ElevatedButton(
                    onPressed: () => _pickImage(ImageSource.camera),
                    child: Text('Take Photo'),
                  ),
                ],
              ),
              TextField(
                controller: _emailController,
                decoration: InputDecoration(labelText: 'Email'),
                keyboardType: TextInputType.emailAddress,
              ),
              TextField(
                controller: _nameController,
                decoration: InputDecoration(labelText: 'Name'),
                keyboardType: TextInputType.name,
              ),
              TextField(
                controller: _phoneController,
                decoration: InputDecoration(labelText: 'Phone'),
                keyboardType: TextInputType.phone,
              ),
              TextField(
                controller: _jobController,
                decoration: InputDecoration(labelText: 'Job Title'),
                keyboardType: TextInputType.text,
              ),
              TextField(
                controller: _passwordController,
                decoration: InputDecoration(labelText: 'Password'),
                obscureText: true,
              ),
              SizedBox(height: 16),
              BlocBuilder<AuthCubit, AuthState>(
                builder: (context, state) {
                  if (state is AuthError) {
                    Components.showMessage(context,
                        content: state.message,
                        icon: Icons.error,
                        color: AppColor.errorColor);
                  }
                  if (state is AuthLoading) {
                    Components.circularProgressLoad(context);
                  }
                  if (state is AuthSuccess) {
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      Navigator.pushNamedAndRemoveUntil(
                          context, Routes.home, (route) => false);
                    });
                  }
                  return ElevatedButton(
                    onPressed: () {
                      final AuthModel authModel = AuthModel(
                        email: _emailController.text.trim(),
                        password: _passwordController.text.trim(),
                        name: _nameController.text.trim(),
                        phone: _phoneController.text.trim(),
                        job: _jobController.text.trim(),
                        photo: _selectedImage, // Pass the selected image
                      );
                      context.read<AuthCubit>().signUp(authModel);
                    },
                    child: Text('Create Account'),
                  );
                },
              ),
              TextButton(
                onPressed: () => Navigator.pushReplacementNamed(
                  context,
                  Routes.signIn,
                ),
                child: Text('Already have an account? Sign In'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
