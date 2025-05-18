import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/utils/app_color.dart';
import '../widgets/chat_gpt_bubble.dart';
import '../widgets/normal_chat_bubble.dart';

class ChatScreen extends StatefulWidget {
  static String routeName = "ChatScreen";

  ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  TextEditingController text = TextEditingController();

  List<Widget> chats = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.secondaryColor,
      appBar: AppBar(
        title: Text(
          "AI Chat",
          style: TextStyle(fontSize: 22.sp),
        ),
        elevation: 1,
      ),
      extendBody: true,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(8.0.r),
          child: Column(
            children: [
              NormalChatBubble(text: "Hi, ChatGPT",),
              ChatGptBubble(),
              SizedBox(
                height: 520.h,
                child: ListView.builder(
                  itemCount: chats.length,
                  itemBuilder: (context, index) {
                    return chats[index];
                  },
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                child: TextFormField(
                  controller: text,
                  textInputAction: TextInputAction.newline,
                  minLines: 1,
                  maxLines: 20,
                  expands: false,
                  selectionControls: MaterialTextSelectionControls(),
                  decoration: InputDecoration(
                    prefixIcon: Icon(
                      Icons.add_rounded,
                      size: 25.sp,
                    ),
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          if (text.text.isNotEmpty) {
                            chats.add(
                              NormalChatBubble(text: text.text),
                            );
                            text = TextEditingController();
                          }
                        });
                      },
                      icon: Icon(
                        Icons.send,
                        size: 22.sp,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(18.r),
                      borderSide: BorderSide(color: AppColor.primaryColor, width: 2),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(18.r),
                      borderSide: BorderSide(color: Colors.red, width: 2),
                    ),
                    disabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(18.r),
                      borderSide: BorderSide(color: AppColor.primaryColor, width: 2),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(18.r),
                      borderSide: BorderSide(color: AppColor.primaryColor, width: 2),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
