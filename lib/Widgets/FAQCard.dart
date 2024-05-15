import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:ielts_app/Models/FAQModel.dart';
import 'package:ielts_app/Views/FAQDetailsView.dart';

class FAQCard extends StatelessWidget {
  final FAQ faq;
  const FAQCard({super.key, required this.faq});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.symmetric(vertical: 5.h),
      child: InkWell(
        onTap: (){
          Get.to(() => FAQDetailsView(faq: faq));
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
          child: Padding(
            padding:  EdgeInsets.symmetric(horizontal: 8.w, vertical: 12.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(child: Text("${faq.question}", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14.sp),)),
                Icon(Icons.arrow_forward_ios, size: 15.w,)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
