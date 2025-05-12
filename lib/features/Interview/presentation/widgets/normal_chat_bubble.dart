import 'package:chat_bubbles/bubbles/bubble_normal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/utils/app_color.dart';

class NormalChatBubble extends StatelessWidget {
  String text = "";
  NormalChatBubble({super.key,required this.text});

  @override
  Widget build(BuildContext context) {
    return BubbleNormal(
      text: text,
      textStyle: TextStyle(
          fontSize: 14.sp,
          fontWeight: FontWeight.w400,
          color: AppColor.darkPurple
      ),
      color: AppColor.lightMauve,
      padding: EdgeInsets.all(12.r),
    );
  }
}
