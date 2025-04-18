// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:path2job/hive_helper/user_hive_helper.dart';

import '../core/routes/routes.dart';
import '../core/utils/assets.dart';

class SplachScreen extends StatelessWidget {
  const SplachScreen({super.key});

  Future<void> _navigateToHome(BuildContext context) async {
    await Future.delayed(const Duration(seconds: 1));
    if (!context.mounted) return;

    if (UserHiveHelper.getUser() != null) {
      Navigator.of(context).pushReplacementNamed(Routes.home);
    } else {
      Navigator.of(context).pushReplacementNamed(Routes.signUp);
    }
  }

  @override
  Widget build(BuildContext context) {
    _navigateToHome(context);

    return Scaffold(
      body: Center(
        child: Image.asset(
          Assets.logo,
        ),
      ),
    );
  }
}
