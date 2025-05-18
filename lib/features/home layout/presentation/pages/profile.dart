import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path2job/core/routes/routes.dart';
import 'package:path2job/core/utils/assets.dart';
import 'package:path2job/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:path2job/hive_helper/category_hive_helper.dart';
import 'package:path2job/hive_helper/course_hive_helper.dart';
import 'package:path2job/hive_helper/user_hive_helper.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/network/check_internet.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool isConnected = false;

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
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                  colorFilter: new ColorFilter.mode(
                      Colors.black.withOpacity(0.1), BlendMode.dstIn),
                  image: AssetImage(Assets.logo),)
            ),
          ),
          SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
              child: Column(
                children: [
                  // Logo at the top
                  SizedBox(height: 32.h),
                  _buildProfileImage(),
                  SizedBox(height: 18.h),
                  // User Data Section
                  Padding(
                    padding: EdgeInsets.all(16.0.r),
                    child: Column(
                      children: [
                        _buildProfileItem(Icons.person, 'Name',
                            UserHiveHelper
                                .getUser()
                                ?.name ?? 'N/A'),
                        const Divider(),
                        _buildProfileItem(Icons.email, 'Email',
                            UserHiveHelper
                                .getUser()
                                ?.email ?? 'N/A'),
                        const Divider(),
                        _buildProfileItem(Icons.phone, 'Phone',
                            UserHiveHelper
                                .getUser()
                                ?.phone ?? 'N/A'),
                        const Divider(),
                        _buildProfileItem(Icons.work, 'Job Title',
                            UserHiveHelper
                                .getUser()
                                ?.job ?? 'N/A'),
                      ],
                    ),
                  ),
                  SizedBox(height: 24.h),
                  // Navigation Section
                  Column(
                    children: [
                      _buildNavigationTile(
                        context,
                        Icons.info_outline,
                        'About Us',
                            () => Navigator.pushNamed(context, Routes.about),
                      ),
                      Divider(height: 1.h),
                      _buildNavigationTile(
                        context,
                        Icons.description,
                        'Terms & Conditions',
                            () => Navigator.pushNamed(context, Routes.terms),
                      ),
                    ],
                  ),
                  SizedBox(height: 24.h),
                  // Logout Button
                  BlocBuilder<AuthCubit, AuthState>(
                    builder: (context, state) {
                      if (state is AuthLoading) {
                        return const CircularProgressIndicator();
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
                        icon: Icon(Icons.logout, size: 24.sp,),
                        label: Text('Logout', style: TextStyle(fontSize: 20.sp),),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red[400],
                          foregroundColor: Colors.white,
                          minimumSize: Size(double.infinity, 50.h),
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
        ],
      ),
    );
  }

  Widget _buildProfileImage() {
    if (isConnected) //check connection
      return CircleAvatar(
        radius: 75.r,
        backgroundImage: NetworkImage(
          UserHiveHelper
              .getUser()
              ?.photoUrl ??
              'https://example.com/default.jpg',
        ),
      );
    else
      return CircleAvatar(
        radius: 75.r,
        backgroundImage:
        MemoryImage(UserHiveHelper
            .getUser()
            ?.photoLocal ?? Uint8List(0)),
      );
  }

  Widget _buildProfileItem(IconData icon, String label, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.0.w),
      child: Row(
        children: [
          Icon(icon, size: 26.sp,),
          SizedBox(width: 16.w),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w700,
                    color: Colors.black
                ),
              ),
              SizedBox(height: 4.h),
              Text(
                value,
                style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildNavigationTile(BuildContext context,
      IconData icon,
      String title,
      VoidCallback onTap,) {
    return ListTile(
      leading: Icon(icon,),
      title: Text(title,),
      trailing: const Icon(Icons.chevron_right,),
      onTap: onTap,
    );
  }
}
