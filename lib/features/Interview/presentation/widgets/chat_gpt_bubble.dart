import 'package:chat_bubbles/bubbles/bubble_normal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/utils/app_color.dart';

class ChatGptBubble extends StatelessWidget {
  const ChatGptBubble({super.key});

  @override
  Widget build(BuildContext context) {
    return  BubbleNormal(
      leading: CircleAvatar(
          backgroundColor: AppColor.darkMauve,
          radius: 20.r,
          child: Icon(
            Icons.person,
            color: AppColor.darkPurple,
            size: 30.sp,
          )),
      text: "Hi, Hatem.",
      textStyle: TextStyle(
        fontSize: 14.sp,
        fontWeight: FontWeight.w400,
        color: AppColor.darkPurple,
      ),
      color: AppColor.darkMauve,
      isSender: false,
      padding: EdgeInsets.all(12.r),
    );
  }
}
