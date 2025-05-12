import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:path2job/features/Interview/presentation/cubit/interview_cubit.dart';
import 'package:path2job/features/Interview/presentation/widgets/add_category.dart';
import '../../../../core/utils/assets.dart';
import '../widgets/category_list.dart';


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

  TextEditingController text = TextEditingController();
  List<Widget> chats = [];

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
            return const Center(child: CircularProgressIndicator());
          } else if (state is CategoriesSyncError) {
            return Center(
              child: Text(
                state.message,
                style: Theme.of(context).textTheme.displayMedium,
              ),
            );
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
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
    );
  }
}


