import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:path2job/core/utils/app_color.dart';
import 'package:path2job/hive/question_answer.dart';

import '../cubit/interview_cubit.dart';

class QuestionCard extends StatelessWidget {
  const QuestionCard(this.question, {super.key});
  final Interviews question;
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2.h,
      shape: RoundedRectangleBorder(
        side: BorderSide(color: AppColor.primaryColor,width: 1.w),
        borderRadius: BorderRadius.circular(24.r),
      ),
      child: ExpansionTile(
        shape: RoundedRectangleBorder(
          side: BorderSide(color: AppColor.primaryColor,width: 1.w),
          borderRadius: BorderRadius.circular(24.r),
        ),
        title: Text(question.question),
        children: [
          Padding(
            padding: EdgeInsets.all(16.r),
            child: Text(question.answer),
          ),
          // إمكانية حفظ/حذف السؤال
          IconButton(
              onPressed: () {
                context
                    .read<InterviewCubit>()
                    .deleteQuestion(question.keyId, question.category);
              },
              icon: Icon(Icons.delete,color: Colors.red,)),
        ],
      ),
    );
  }
}
