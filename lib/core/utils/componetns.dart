import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:path2job/core/utils/app_color.dart';
import 'package:shimmer/shimmer.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
// import 'package:shop_app/core/utils/app_colors.dart';

class Components {
  static Widget customTextField({
    required String hint,
    bool isPassword = false,
    bool isShow = false,
    VoidCallback? onPressed,
    ValueChanged<String>? onChange,
    ValueChanged<String>? onSubmit,
    IconData? icon,
    bool isPhone = false,
    required TextEditingController controller,
  }) {
    return SizedBox(
      width: isPhone ? 250.w : 335.w,
      height: 64.h,
      child: StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
          return TextFormField(
            keyboardType: isPhone ? TextInputType.number : null,
            style: Theme.of(context).textTheme.bodyLarge,
            onChanged: onChange,
            onFieldSubmitted: onSubmit,
            controller: controller,
            obscureText: isPassword ? !isShow : false,
            validator: (value) {
              if (value?.trim().isEmpty ?? true) {
                return isPassword
                    ? 'the password can\'t be empty and must contains capital letters and number and symbols'
                    : 'Field can\'t be empty';
              }
              return null;
            },
            decoration: InputDecoration(
              hintText: hint,
              prefixIcon: Icon(
                icon,
                size: 30.sp,
              ),
              suffixIcon: isPassword
                  ? IconButton(
                      onPressed: () {
                        setState(() {
                          isShow = !isShow;
                        });
                        if (onPressed != null) onPressed();
                      },
                      icon: Icon(
                        isShow ? Icons.visibility : Icons.visibility_off,
                        size: 30.sp,
                      ),
                    )
                  : null,
            ),
          );
        },
      ),
    );
  }

  static Widget shrimList() {
    return ListView.separated(
      itemCount: 10, // Number of shimmer items
      itemBuilder: (context, index) {
        return Shimmer.fromColors(
          baseColor: Colors.grey[300]!,
          highlightColor: Colors.grey[100]!,
          child: Card(
            elevation: 20,
            child: ListTile(
              leading: Container(
                height: 70.h,
                width: 50.w,
                decoration: ShapeDecoration(
                    color: Colors.grey[300],
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(5.r)))),
              ),
              title: Container(
                height: 20.h,
                color: Colors.grey[300],
              ),
              subtitle: Container(
                height: 14.h,
                color: Colors.grey[300],
              ),
              trailing: Container(
                height: 20.h,
                width: 60.w,
                color: Colors.grey[300],
              ),
            ),
          ),
        );
      },
      separatorBuilder: (BuildContext context, int index) {
        return SizedBox(height: 10.h);
      },
    );
  }

  static void circularProgressLoad(context) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => SpinKitFoldingCube(
              color: AppColor.secondaryColor,
              size: 50.r,
            ));
  }

  static void showMessage(BuildContext context,
      {required String content, required IconData icon, required Color color}) {
    showDialog(
      context: context,
      builder: (c) => Dialog(
        elevation: 1,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.r)),
        child: Container(
          width: MediaQuery.of(context).size.width / 1.5,
          height: MediaQuery.of(context).size.height / 5,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15.0),
              boxShadow: [
                BoxShadow(
                    offset: Offset(12.w, 26.h),
                    blurRadius: 50.r,
                    color: Colors.grey.withOpacity(0.1)),
              ]),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                  backgroundColor: color,
                  radius: 25.r,
                  child: Icon(
                    icon,
                    color: Colors.white,
                  )),
              SizedBox(
                height: 15.h,
              ),
              Text(
                content,
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 15.h,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
