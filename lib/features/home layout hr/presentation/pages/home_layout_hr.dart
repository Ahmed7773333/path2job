import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:path2job/core/utils/app_color.dart';
import 'package:path2job/features/home%20layout%20hr/presentation/pages/favorite.dart';

import '../../../home layout/presentation/pages/profile.dart';
import 'home_page.dart';

class HomeLayoutHr extends StatefulWidget {
  const HomeLayoutHr({super.key});

  @override
  State<HomeLayoutHr> createState() => _HomeLayoutHrState();
}

class _HomeLayoutHrState extends State<HomeLayoutHr> {
  int _currentIndex = 0;
  final PageController _pageController = PageController();

  final List<Widget> _pages = [
    HomePage(),
    FavoritePage(),
    const ProfilePage(),

  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Use PageView for swipe navigation
      body: PageView(
        controller: _pageController,
        physics: const ClampingScrollPhysics(), // For smoother swiping
        onPageChanged: (index) {
          setState(() => _currentIndex = index);
        },
        children: _pages,
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10.r,
              spreadRadius: 2.r,
            ),
          ],
        ),
        child: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (index) {
            setState(() => _currentIndex = index);
            _pageController.animateToPage(
              index,
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
            );
          },
          type: BottomNavigationBarType.fixed,
          backgroundColor: AppColor.primaryColor,
          selectedItemColor: AppColor.textColor,
          unselectedItemColor: AppColor.textColor.withOpacity(0.6),
          selectedLabelStyle: const TextStyle(fontWeight: FontWeight.w600),
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined),
              activeIcon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.star_border_outlined),
              activeIcon: Icon(Icons.star),
              label: 'Favorite',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person_outlined),
              activeIcon: Icon(Icons.person),
              label: 'Profile',
            ),
            
          ],
        ),
      ),
    );
  }
}
