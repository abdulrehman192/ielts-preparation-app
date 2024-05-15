import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:ielts_app/Constants/AppColors.dart';
import 'package:ielts_app/Views/TipDetailsView.dart';

import '../Models/TipModel.dart';

class TipCard extends StatelessWidget {
  final Tip tip;
  final int index;
  const TipCard({super.key, required this.tip, required this.index});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.symmetric(vertical: 5.h),
      child: InkWell(
        onTap: (){
          Get.to(() => TipDetailsView(tip: tip,));
        },
        child: Ink(
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8.w),
              boxShadow: [
                BoxShadow(
                    blurRadius: 1.0,
                    spreadRadius: 1.0,
                    color: Colors.grey.shade200
                )
              ]
          ),
          child: Container(
            padding: EdgeInsets.all(10.w),
            width: 1.sw,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.min,
              children: [
                Flexible(child: Text("Tip No. ${index + 1}", style: TextStyle(fontSize: 13.sp, fontWeight: FontWeight.w500, color: AppColors.primaryColor),)),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(child: Text("${tip.title}", style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.w500),)),
                    Icon(Icons.arrow_forward_ios),
                  ],
                ),
                Text("${tip.subTitle}", style: TextStyle(fontSize: 14.sp),)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
