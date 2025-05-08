import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:path2job/features/auth/presentation/cubit/auth_cubit.dart';
import '../../../../core/routes/routes.dart';
import '../../../../core/utils/assets.dart';

class SignInPage extends StatelessWidget {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  SignInPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(20.r),
          child: Column(
            children: [
              SizedBox(height: 16.h),
              Image.asset(
                Assets.logo,
                height: 250.h,
                width: 250.w,
              ),
              TextField(
                controller: _emailController,
                decoration: InputDecoration(labelText: 'Email'),
                keyboardType: TextInputType.emailAddress,
              ),
              SizedBox(height: 24.h),
              TextField(
                controller: _passwordController,
                decoration: InputDecoration(labelText: 'Password'),
                obscureText: true,
              ),
              SizedBox(height: 24.h),
              TextButton(
                onPressed: () {/* Add forgot password logic */},
                child: Text('Forgot Password?'),
              ),
              SizedBox(height: 32.h),
              BlocBuilder<AuthCubit, AuthState>(
                builder: (context, state) {
                  if (state is AuthLoading) {
                    return CircularProgressIndicator();
                  }
                  if (state is AuthSuccess) {
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      Navigator.pushReplacementNamed(context, Routes.home);
                    });
                  }
                  return ElevatedButton(
                    onPressed: () {
                      context.read<AuthCubit>().signIn(
                            _emailController.text.trim(),
                            _passwordController.text.trim(),
                          );
                    },
                    child: Text('Sign In'),
                  );
                },
              ),
              SizedBox(height: 12.h),
              TextButton(
                onPressed: () => Navigator.pushReplacementNamed(
                  context,
                  Routes.signUp,
                ),
                child: Text('Don\'t have an account? Sign Up'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
