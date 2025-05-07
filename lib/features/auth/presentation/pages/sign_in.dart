import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path2job/features/auth/presentation/cubit/auth_cubit.dart';
import '../../../../core/routes/routes.dart';
import '../../../../core/utils/app_color.dart';
import '../../../../core/utils/assets.dart';
import '../../../../core/utils/componetns.dart';

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
          padding: EdgeInsets.all(16),
          child: Column(
            children: [
              SizedBox(height: 8),
              Image.asset(
                Assets.logo,
                height: 200,
                width: 200,
              ),
              TextField(
                controller: _emailController,
                decoration: InputDecoration(labelText: 'Email'),
                keyboardType: TextInputType.emailAddress,
              ),
              SizedBox(height: 16),
              TextField(
                controller: _passwordController,
                decoration: InputDecoration(labelText: 'Password'),
                obscureText: true,
              ),
              SizedBox(height: 16),
              TextButton(
                onPressed: () {/* Add forgot password logic */},
                child: Text('Forgot Password?'),
              ),
              SizedBox(height: 32),
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
                      context.read<AuthCubit>().signIn(
                            _emailController.text.trim(),
                            _passwordController.text.trim(),
                          );
                    },
                    child: Text('Sign In'),
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
    );
  }
}
