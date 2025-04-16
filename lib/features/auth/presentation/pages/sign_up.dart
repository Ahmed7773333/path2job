import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path2job/core/utils/assets.dart';
import 'package:path2job/features/auth/data/models/auth_model.dart';

import '../../../../core/routes/routes.dart';
import '../cubit/auth_cubit.dart';

class SignUpPage extends StatelessWidget {
  final _emailController = TextEditingController();
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _jobController = TextEditingController();
  final _passwordController = TextEditingController();

  SignUpPage({super.key});

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
              TextField(
                controller: _emailController,
                decoration: InputDecoration(labelText: 'Email'),
                keyboardType: TextInputType.emailAddress,
              ),
              TextField(
                controller: _nameController,
                decoration: InputDecoration(labelText: 'Name'),
                keyboardType: TextInputType.emailAddress,
              ),
              TextField(
                controller: _phoneController,
                decoration: InputDecoration(labelText: 'phone'),
                keyboardType: TextInputType.emailAddress,
              ),
              TextField(
                controller: _jobController,
                decoration: InputDecoration(labelText: 'Job Title'),
                keyboardType: TextInputType.emailAddress,
              ),
              TextField(
                controller: _passwordController,
                decoration: InputDecoration(labelText: 'Password'),
                obscureText: true,
              ),
              SizedBox(height: 16),
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
                      );
                      context.read<AuthCubit>().signUp(
                            authModel,
                          );
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
