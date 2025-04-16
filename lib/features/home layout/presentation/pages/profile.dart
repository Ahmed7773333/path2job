import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path2job/core/routes/routes.dart';
import 'package:path2job/core/utils/assets.dart';
import 'package:path2job/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:path2job/hive_helper/hive_helper.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              // Logo at the top
              Image.asset(
                Assets.logo,
                height: 120,
                width: 120,
              ),
              const SizedBox(height: 24),

              // User Data Section
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    _buildProfileItem(Icons.person, 'Name',
                        HiveHelper.getUser()?.name ?? 'N/A'),
                    const Divider(),
                    _buildProfileItem(Icons.email, 'Email',
                        HiveHelper.getUser()?.email ?? 'N/A'),
                    const Divider(),
                    _buildProfileItem(Icons.phone, 'Phone',
                        HiveHelper.getUser()?.phone ?? 'N/A'),
                    const Divider(),
                    _buildProfileItem(Icons.work, 'Job Title',
                        HiveHelper.getUser()?.job ?? 'N/A'),
                  ],
                ),
              ),

              const SizedBox(height: 32),

              // Navigation Section
              Column(
                children: [
                  _buildNavigationTile(
                    context,
                    Icons.info_outline,
                    'About Us',
                    () => Navigator.pushNamed(context, Routes.about),
                  ),
                  const Divider(height: 1),
                  _buildNavigationTile(
                    context,
                    Icons.description,
                    'Terms & Conditions',
                    () => Navigator.pushNamed(context, Routes.terms),
                  ),
                ],
              ),

              const SizedBox(height: 32),

              // Logout Button
              BlocBuilder<AuthCubit, AuthState>(
                builder: (context, state) {
                  if (state is AuthLoading) {
                    return const CircularProgressIndicator();
                  }
                  if (state is LogoutSuccess) {
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      Navigator.pushReplacementNamed(context, Routes.signIn);
                    });
                  }
                  return ElevatedButton.icon(
                    icon: const Icon(Icons.logout),
                    label: const Text('Logout'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red[400],
                      foregroundColor: Colors.white,
                      minimumSize: const Size(double.infinity, 50),
                    ),
                    onPressed: () {
                      context.read<AuthCubit>().logout();
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProfileItem(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Icon(icon, size: 24),
          const SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: const TextStyle(
                  fontSize: 12,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                value,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildNavigationTile(
    BuildContext context,
    IconData icon,
    String title,
    VoidCallback onTap,
  ) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      trailing: const Icon(Icons.chevron_right),
      onTap: onTap,
    );
  }
}
