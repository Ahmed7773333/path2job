import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:path2job/features/Interview/presentation/cubit/interview_cubit.dart';
import 'package:path2job/features/Interview/presentation/widgets/category_card.dart';

import '../../../../hive/category.dart';

class CategoriesListView extends StatelessWidget {
  // Generate fake data
  final List<Categories> fakeCategories = List.generate(
    15,
    (index) => Categories(
      name: "Category ${index + 1}",
      numberOfQuestions: (index + 1) * 5,
    ),
  );

  @override
  Widget build(BuildContext context) {
    final categories = context.read<InterviewCubit>().categories;
    return ListView.separated(
      padding: EdgeInsets.all(16.r),
      itemCount: categories.length,
      separatorBuilder: (context, index) => SizedBox(height: 8.h),
      itemBuilder: (context, index) {
        final category = categories[index];
        return CategoryCard(category: category);
      },
    );
  }
}
