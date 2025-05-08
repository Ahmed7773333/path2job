import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path2job/core/utils/assets.dart';
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
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Column(
            spacing: 16.h,
            children: [
              SizedBox(height: 4.h),
              Image.asset(
                Assets.logo,
                height: 200.h,
                width: 200.w,
              ),
              // Display selected image or placeholder
              _selectedImage != null
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.file(
                        _selectedImage!,
                        height: 100.h,
                        width: 100.w,
                        fit: BoxFit.cover,
                      ),
                    )
                  : Container(
                      height: 100.h,
                      width: 100.w,
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      child: Icon(Icons.person, size: 80.sp, color: Colors.grey),
                    ),
              // Buttons to pick image
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () => _pickImage(ImageSource.gallery),
                    child: Text('Pick from Gallery'),
                  ),
                  SizedBox(width: 12.w),
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
              BlocBuilder<AuthCubit, AuthState>(
                builder: (context, state) {
                  if (state is AuthLoading) {
                    return CircularProgressIndicator();
                  }
                  if (state is AuthSuccess) {
                    Navigator.pushReplacementNamed(context, Routes.home);
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