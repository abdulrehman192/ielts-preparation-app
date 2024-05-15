import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:ielts_app/Constants/AppColors.dart';
import 'package:ielts_app/Views/TestDetailsView.dart';

import '../Controllers/TestController.dart';
import '../Models/Test.dart';

class TestCard extends StatelessWidget {
  final int index;
  final Test test;
  const TestCard({super.key, required this.index, required this.test});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.symmetric(vertical: 5.h),
        child: InkWell(
          onTap: (){
            TestController t = Get.find();
            t.addToAnsweredQuestions(test);
            Get.to(()=> TestDetailsView(title: "IELTS Practise $index", test: test,),);
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
              width: 1.sw,
              padding: EdgeInsets.all(8.w),
              child: Row(
                children: [
                  Container(
                    width: 40.w,
                    height: 40.w,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5.w),
                      color: AppColors.primaryColor
                    ),
                    child: Text("$index", style: TextStyle(fontSize: 19.sp, fontWeight: FontWeight.bold, color: Colors.white),),
                  ),
                  SizedBox(width: 8.w,),
                  Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("IELTS Practise $index", style: TextStyle(fontSize: 18.sp, color: AppColors.primaryColor),),
                          Row(
                            children: [
                              Text("Score: ", style: TextStyle(fontSize: 16.sp, color: Colors.grey.shade700),),
                              Text("${test.score}/${test.questions!.length}", style: TextStyle(fontSize: 16.sp, color: AppColors.primaryColor))
                            ],
                          )
                        ],
                      )
                  )
                ],
              ),
            ),
          ),
        ),
    );
  }
}
