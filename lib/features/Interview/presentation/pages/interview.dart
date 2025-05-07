// features/interview/presentation/pages/interview_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path2job/core/utils/assets.dart';
import 'package:path2job/features/Interview/presentation/cubit/interview_cubit.dart';
import 'package:path2job/features/Interview/presentation/widgets/add_category.dart';
import 'package:path2job/features/Interview/presentation/widgets/category_list.dart';

import '../../../../core/utils/app_color.dart';
import '../../../../core/utils/componetns.dart';

class InterviewPage extends StatefulWidget {
  const InterviewPage({super.key});

  @override
  State<InterviewPage> createState() => _InterviewPageState();
}

class _InterviewPageState extends State<InterviewPage> {
  @override
  void initState() {
    super.initState();
    // Trigger sync when page initializes
    context.read<InterviewCubit>().syncCategories();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Interview Preparation")),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Handle floating action button press
          _showAddCategorySheet(context);
        },
        child: const Icon(Icons.add),
      ),
      body: BlocBuilder<InterviewCubit, InterviewState>(
        builder: (context, state) {
          if (state is CategoriesSyncLoading) {
            Components.circularProgressLoad(context);
          } else if (state is CategoriesSyncError) {
            Components.showMessage(context,
                content: state.message,
                icon: Icons.error,
                color: AppColor.errorColor);
          } else if (state is CategoriesSyncEmpty) {
            return Center(
              child: Image.asset(Assets.emptyFaq),
            );
          } else if (state is CategoriesSyncSuccess) {
            return CategoriesListView();

            // Your actual content widget
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

  void _showAddCategorySheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: const AddCategorySheet(),
      ),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
    );
  }
}
