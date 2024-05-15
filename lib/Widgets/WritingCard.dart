import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:ielts_app/Constants/AppAssets.dart';
import 'package:ielts_app/Constants/AppColors.dart';
import 'package:ielts_app/Controllers/ListeningController.dart';
import 'package:ielts_app/Controllers/SpeakingController.dart';
import 'package:ielts_app/Models/ListeningLesson.dart';
import 'package:ielts_app/Models/WritingModel.dart';
import 'package:ielts_app/Views/ListeningLessionDetailsView.dart';

import '../Controllers/WritingController.dart';
import '../Models/SpeakingModel.dart';
import '../Views/SpeakingLessionDetailsView.dart';
import '../Views/WritingLessionDetailsView.dart';

class WritingCard extends StatelessWidget {
  final int index;
  final Writing lesson;
  const WritingCard({Key? key, required this.index, required this.lesson}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 5.h),
      child: InkWell(
        onTap: (){
          Get.to(() => WritingLessonDetailsView(title: lesson.title.toString(), lesson: lesson,));
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
            padding: EdgeInsets.all(8.w),
            child: Row(
              children: [
                SvgPicture.asset(AppAssets.writingIconSvg, width: 40.w, color : AppColors.primaryColor,),
                SizedBox(width: 8.w,),
                Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("${lesson.title}", style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600),),
                        Text("${lesson.suggestion}", style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w400),),
                      ],
                    )
                ),
                // IconButton(
                //     onPressed: (){
                //       SpeakingController listen = Get.find();
                //       listen.toggleLessonFavorite(lesson);
                //
                //     },
                //     splashRadius: 20,
                //     icon: Icon(lesson.favorite == true ? Icons.favorite : Icons.favorite_outline, color: Colors.red,)
                // )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
