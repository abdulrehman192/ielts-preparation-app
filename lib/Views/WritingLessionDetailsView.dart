import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:ielts_app/Controllers/ListeningController.dart';
import 'package:ielts_app/Controllers/TextToSpeechController.dart';
import 'package:ielts_app/Models/ListeningLesson.dart';
import 'package:ielts_app/Models/SpeakingModel.dart';
import 'package:ielts_app/Models/WritingModel.dart';
import 'package:ielts_app/Views/ListeningQuizView.dart';
import 'package:ielts_app/Widgets/AudioPlayer.dart';

import '../Constants/AppColors.dart';

class WritingLessonDetailsView extends StatelessWidget {
  final String title;
  final Writing lesson;
  const WritingLessonDetailsView({Key? key, required this.title, required this.lesson}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: ()async{
        TextToSpeechController speech = Get.find();
        speech.stopSpeech();
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(title),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            padding: EdgeInsets.all(8.w),
            decoration: BoxDecoration(
              border: Border.all(color: AppColors.primaryColor, width: 5.w, style: BorderStyle.solid),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(lesson.suggestion.toString(), style: TextStyle(fontSize: 14.sp),),
                SizedBox(height: 8.h,),
                Center(child: Text("-----Sample Answer-----", style: TextStyle(color: Colors.grey.shade700, fontSize: 15.sp, fontWeight: FontWeight.bold),),),
                SizedBox(height: 8.h,),
                Text(lesson.data.toString(), style: TextStyle(fontSize: 14.sp),),
              ],
            ),
          ),
        )
      ),
    );
  }

}
