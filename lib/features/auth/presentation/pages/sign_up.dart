import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path2job/core/utils/app_color.dart';
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
      body: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                  colorFilter: new ColorFilter.mode(Colors.black.withOpacity(0.2), BlendMode.dstIn),
                  image: AssetImage(Assets.logo),)
            ),
          ),
          SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Column(
                spacing: 16.h,
                children: [
                  SizedBox(height: 4.h),
                  // Image.asset(
                  //   Assets.logo,
                  //   height: 200.h,
                  //   width: 200.w,
                  // ),
                  // Display selected image or placeholder
                  _selectedImage != null
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(12.r),
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
                            color: AppColor.darkPurple,
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                          child: Icon(Icons.person, size: 80.sp, color: AppColor.darkMauve),
                        ),
                  // Buttons to pick image
                  ElevatedButton(
                    onPressed: () => _pickImage(ImageSource.gallery),
                    style: ButtonStyle(
                        fixedSize: WidgetStatePropertyAll(Size(230.w, 50.h)),
                        backgroundColor: WidgetStatePropertyAll(AppColor.orchid)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.photo,size: 22.sp,),
                        SizedBox(width: 20.w,),
                        Text('Pick from Gallery'),
                      ],
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () => _pickImage(ImageSource.camera),
                    style: ButtonStyle(
                        fixedSize: WidgetStatePropertyAll(Size(230.w, 50.h)),
                        backgroundColor: WidgetStatePropertyAll(AppColor.orchid)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.camera_alt,size: 22.sp,),
                        SizedBox(width: 20.w,),
                        Text('Take A Photo'),
                      ],
                    ),
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
                        style: ButtonStyle(backgroundColor: WidgetStatePropertyAll(AppColor.orchid)),
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
                    style: ButtonStyle(foregroundColor: WidgetStatePropertyAll(AppColor.orchid)),
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
        ],
      ),
    );
  }
}