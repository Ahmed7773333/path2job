import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:path2job/features/Interview/presentation/cubit/interview_cubit.dart';
import 'package:path2job/features/Interview/presentation/pages/chat.dart';
import 'package:path2job/features/Interview/presentation/widgets/add_category.dart';
import '../../../../core/utils/assets.dart';
import '../widgets/category_list.dart';

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

  TextEditingController text = TextEditingController();
  List<Widget> chats = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Interview Preparation")),
      floatingActionButton: Padding(
        padding: EdgeInsets.only(left: 30.w),
        child: FloatingActionButton(
          onPressed: () {
            // Handle floating action button press
            _showAddCategorySheet(context);
          },
          child: Icon(
            Icons.add,
            size: 26.sp,
          ),
        ),
      ),
      body: BlocConsumer<InterviewCubit, InterviewState>(
        listener: (BuildContext context, InterviewState state) {
          if (state is CategoriesSyncLoading) {
            // Components.circularProgressLoad(context);
          }
          if (state is CategoriesSyncError) {
            Components.showMessage(context,
                content: state.message,
                icon: Icons.error,
                color: AppColor.errorColor);
          }
          // if (state is CategoriesSyncEmpty || state is CategoriesSyncSuccess) {
          //   Navigator.pop(context);
          // }
        },
        builder: (context, state) {
          if (state is CategoriesSyncEmpty) {
            return Center(
              child: Image.asset(Assets.emptyFaq),
            );
          }
          return CategoriesListView();

          // Your actual content widget
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
