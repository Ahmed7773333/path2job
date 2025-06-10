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
      body: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            decoration: BoxDecoration(
                image: DecorationImage(
              colorFilter: new ColorFilter.mode(
                  Colors.black.withOpacity(0.1), BlendMode.dstIn),
              image: AssetImage(Assets.logo),
            )),
          ),
          SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.only(right: 20.w,left: 20.w,top: 30.h),
              child: Column(
                spacing: 24.h,
                children: [
                  Text(
                    '''Welcome!
Lets Get Started!''',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 28.sp,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 40.h),
                  // Image.asset(
                  //   Assets.logo,
                  //   height: 250.h,
                  //   width: 250.w,
                  // ),
                  TextField(
                    controller: _emailController,
                    decoration: InputDecoration(
                      labelText: 'Email',
                      filled: true,
                      fillColor: Colors.white.withOpacity(0.8),
                    ),
                    keyboardType: TextInputType.emailAddress,
                  ),
                  TextField(
                    controller: _passwordController,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      filled: true,
                      fillColor: Colors.white.withOpacity(0.8),
                    ),
                    obscureText: true,
                  ),
                  TextButton(
                    onPressed: () {
                      /* Add forgot password logic */
                    },
                    child: Text('Forgot Password?'),
                  ),
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
                        child: Text(
                          'Sign In',
                          style: TextStyle(color: Colors.white),
                        ),
                      );
                    },
                  ),
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
        ],
      ),
    );
  }
}
