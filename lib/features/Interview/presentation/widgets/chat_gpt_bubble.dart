import 'package:chat_bubbles/bubbles/bubble_normal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ChatGptBubble extends StatelessWidget {
  const ChatGptBubble({super.key});

  @override
  Widget build(BuildContext context) {
    return  BubbleNormal(
      leading: CircleAvatar(
          radius: 20.r,
          child: Icon(
            Icons.person,
            size: 30.sp,
          )),
      text: "Hi, Hatem.",
      textStyle: TextStyle(
        fontSize: 14.sp,
        fontWeight: FontWeight.w400,
      ),
      isSender: false,
      padding: EdgeInsets.all(12.r),
    );
  }
}
