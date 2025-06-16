import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:path2job/features/home%20layout/presentation/cubit/home_layout_cubit.dart';
import 'package:path2job/features/home%20layout/presentation/widgets/success.dart';
import 'package:path2job/hive_helper/user_hive_helper.dart';

import '../../../../core/constants/constants.dart';
import '../../../../core/utils/app_color.dart';
import 'package:flutter_paymob_egypt/flutter_paymob_egypt.dart';

void showUpgradeDialog(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.r),
        ),
        child: Container(
          padding: EdgeInsets.all(24.r),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.workspace_premium, size: 64.sp, color: Colors.amber),
              SizedBox(height: 16.h),
              Text(
                "Upgrade to Pro!",
                style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 12.h),
              Text(
                "Unlock all features, premium templates,\nand priority support for only 100 EGP.",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 14.sp, color: Colors.grey[700]),
              ),
              SizedBox(height: 24.h),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => FlutterPaymobPayment(
                                    cardInfo: CardInfo(
                                      apiKey: Constants
                                          .payKey, // from dashboard Select Settings -> Account Info -> API Key
                                      iframesID:
                                          '854679', // from paymob Select Developers -> iframes
                                      integrationID:
                                          '4605671', // from dashboard Select Developers -> Payment Integrations -> Online Card ID
                                    ),
                                    totalPrice:
                                        100, // 100 EGP --required pay with Egypt currency
                                    successResult: (data) {
                                      context.read<HomeLayoutCubit>().upgrade();
                                      Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                              builder: (c) =>
                                                  PaymentSuccessPage()));
                                    },
                                    errorResult: (error) {
                                      Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                              builder: (c) =>
                                                  PaymentFailedPage()));
                                    })));
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColor.primaryColor,
                        padding: EdgeInsets.symmetric(vertical: 12.h),
                      ),
                      child: Text("Upgrade for 100 EGP"),
                    ),
                  ),
                ],
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context); // stay free
                },
                child: Text("Continue with Free Version"),
              ),
            ],
          ),
        ),
      );
    },
  );
}
