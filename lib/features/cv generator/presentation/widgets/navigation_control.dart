import 'package:flutter/material.dart';

class NavigationControls extends StatelessWidget {
  final int currentPage;
  final PageController pageController;
  final GlobalKey<FormState> formKey;
  final VoidCallback onGenerateCV;

  const NavigationControls({
    required this.currentPage,
    required this.pageController,
    required this.formKey,
    required this.onGenerateCV,
  });

  void _goToNextPage() {
    if (currentPage < 7) {
      if (currentPage == 0 && !formKey.currentState!.validate()) {
        return;
      }
      pageController.nextPage(
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut);
    } else {
      onGenerateCV();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          if (currentPage > 0)
            ElevatedButton(
              onPressed: () => pageController.previousPage(
                duration: Duration(milliseconds: 300),
                curve: Curves.easeInOut),
              child: Text('Back')),
          ElevatedButton(
            onPressed: _goToNextPage,
            child: Text(currentPage == 7 ? 'Generate CV' : 'Next')),
        ],
      ),
    );
  }
}