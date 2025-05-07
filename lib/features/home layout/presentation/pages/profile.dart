import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path2job/core/routes/routes.dart';
import 'package:path2job/core/utils/assets.dart';
import 'package:path2job/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:path2job/hive_helper/category_hive_helper.dart';
import 'package:path2job/hive_helper/course_hive_helper.dart';
import 'package:path2job/hive_helper/user_hive_helper.dart';

import '../../../../core/network/check_internet.dart';
import '../../../../core/utils/app_color.dart';
import '../../../../core/utils/componetns.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late bool isConnected;
  @override
  void initState() {
    // TODO: implement initState
    checkConnect();
    super.initState();
  }

  Future<void> checkConnect() async {
    isConnected = await ConnectivityService().getConnectionStatus();
    setState(() {});
  }

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
              _buildProfileImage(),
              const SizedBox(height: 24),
              // User Data Section
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    _buildProfileItem(Icons.person, 'Name',
                        UserHiveHelper.getUser()?.name ?? 'N/A'),
                    const Divider(),
                    _buildProfileItem(Icons.email, 'Email',
                        UserHiveHelper.getUser()?.email ?? 'N/A'),
                    const Divider(),
                    _buildProfileItem(Icons.phone, 'Phone',
                        UserHiveHelper.getUser()?.phone ?? 'N/A'),
                    const Divider(),
                    _buildProfileItem(Icons.work, 'Job Title',
                        UserHiveHelper.getUser()?.job ?? 'N/A'),
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
                  if (state is AuthError) {
                    Components.showMessage(context,
                        content: state.message,
                        icon: Icons.error,
                        color: AppColor.errorColor);
                  }
                  if (state is AuthLoading) {
                    Components.circularProgressLoad(context);
                  }
                  if (state is LogoutSuccess) {
                    CourseHiveHelper.clearAllCourses();
                    UserHiveHelper.clearAllUsers();
                    // InterviewHiveHelper.deleteAllInterviews();
                    CategoryHiveHelper.clearAllCategories();
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

  Widget _buildProfileImage() {
    if (isConnected) //check connection
      return CircleAvatar(
        radius: 50,
        backgroundImage: NetworkImage(
          UserHiveHelper.getUser()?.photoUrl ??
              'https://example.com/default.jpg',
        ),
      );
    else
      return CircleAvatar(
        radius: 50,
        backgroundImage:
            MemoryImage(UserHiveHelper.getUser()?.photoLocal ?? Uint8List(0)),
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
