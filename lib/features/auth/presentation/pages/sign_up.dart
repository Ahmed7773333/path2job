import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path2job/core/utils/app_color.dart';
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
          padding: EdgeInsets.only(right: 16.w,left: 16.w,top: 60.h),
          child: Stack(
            alignment: Alignment.topCenter,
            children: [
              Column(
                spacing: 16.h,
                children: [
                  // Image.asset(
                  //   Assets.logo,
                  //   height: 200.h,
                  //   width: 200.w,
                  // ),
                  // Display selected image or placeholder
                  // Buttons to pick image
                  // ElevatedButton(
                  //   onPressed: () => _pickImage(ImageSource.gallery),
                  //   style: ButtonStyle(
                  //       fixedSize: WidgetStatePropertyAll(Size(230.w, 50.h)),
                  //      ),
                  //   child: Row(
                  //     mainAxisAlignment: MainAxisAlignment.center,
                  //     children: [
                  //       Icon(
                  //         Icons.photo,
                  //         size: 22.sp,
                  //       ),
                  //       SizedBox(
                  //         width: 20.w,
                  //       ),
                  //       Text('Pick from Gallery'),
                  //     ],
                  //   ),
                  // ),
                  // ElevatedButton(
                  //   onPressed: () => _pickImage(ImageSource.camera),
                  //   style: ButtonStyle(
                  //       fixedSize: WidgetStatePropertyAll(Size(230.w, 50.h)),
                  //       ),
                  //   child: Row(
                  //     mainAxisAlignment: MainAxisAlignment.center,
                  //     children: [
                  //       Icon(
                  //         Icons.camera_alt,
                  //         size: 22.sp,
                  //       ),
                  //       SizedBox(
                  //         width: 20.w,
                  //       ),
                  //       Text('Take A Photo'),
                  //     ],
                  //   ),
                  // ),
                  SizedBox(
                    height: 190.h,
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
                  SizedBox(height: 4.h,),
                  BlocBuilder<AuthCubit, AuthState>(
                    builder: (context, state) {
                      if (state is AuthLoading) {
                        return CircularProgressIndicator();
                      }
                      if (state is AuthSuccess) {
                        Navigator.pushReplacementNamed(
                            context, Routes.home);
                      }
                      return ElevatedButton(
                        onPressed: () {
                          final AuthModel authModel = AuthModel(
                            email: _emailController.text.trim(),
                            password: _passwordController.text.trim(),
                            name: _nameController.text.trim(),
                            phone: _phoneController.text.trim(),
                            job: _jobController.text.trim(),
                            photo:
                                _selectedImage, // Pass the selected image
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
              _selectedImage != null
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(12.r),
                      child: Image.file(
                        _selectedImage!,
                        height: 150.h,
                        width: 150.w,
                        fit: BoxFit.cover,
                      ),
                    )
                  : Container(
                      height: 150.h,
                      width: 150.w,
                      decoration: BoxDecoration(
                        color: AppColor.primaryColor,
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      child: Icon(Icons.person,
                          size: 120.sp, color: AppColor.textColor),
                    ),
              Positioned(
                left: 65,
                top: 110,
                child: InkWell(
                  onTap: () => _pickImage(ImageSource.camera),
                  child: Container(
                      padding: EdgeInsets.all(12.r),
                      height: 70.h,
                      width: 70.w,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColor.backgroundColor,
                          border:
                              Border.all(color: Colors.black, width: 2.w)),
                      child: Icon(
                        Icons.camera_alt,
                        size: 32.sp,
                        color: AppColor.primaryColor,
                      )),
                ),
              ),
              Positioned(
                right: 65,
                top: 110,
                child: InkWell(
                  onTap: () => _pickImage(ImageSource.gallery),
                  child: Container(
                      padding: EdgeInsets.all(12.r),
                      height: 70.h,
                      width: 70.w,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColor.backgroundColor,
                          border:
                              Border.all(color: Colors.black, width: 2.w)),
                      child: Icon(
                        Icons.photo,
                        size: 32.sp,
                        color: AppColor.primaryColor,
                      )),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
