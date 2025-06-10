import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:path2job/core/routes/routes.dart';
import 'package:path2job/core/utils/app_color.dart';

import '../../../../hive/category.dart';

class CategoryCard extends StatelessWidget {
  final Categories category;

  const CategoryCard({Key? key, required this.category}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(
          context,
          Routes.categoryFaq,
          arguments: category.name,
        );
      },
      child: Card(
        elevation: 2.h,
        shape: RoundedRectangleBorder(
          side: BorderSide(color: AppColor.primaryColor,width: 1.w),
          borderRadius: BorderRadius.circular(16.r),
        ),
        child: Padding(
          padding: EdgeInsets.all(16.r),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                category.name ?? 'Unnamed Category',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                decoration: BoxDecoration(
                  color: AppColor.primaryColor,
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Text(
                  '${category.numberOfQuestions ?? 0} Qs',
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium
                      ?.copyWith(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
