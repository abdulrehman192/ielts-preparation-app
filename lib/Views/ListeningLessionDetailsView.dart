import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:ielts_app/Controllers/ListeningController.dart';
import 'package:ielts_app/Controllers/TextToSpeechController.dart';
import 'package:ielts_app/Models/ListeningLesson.dart';
import 'package:ielts_app/Views/ListeningQuizView.dart';
import 'package:ielts_app/Widgets/AudioPlayer.dart';

import '../Constants/AppColors.dart';

class ListeningLessonDetailsView extends StatelessWidget {
  final String title;
  final ListeningLesson lesson;
  const ListeningLessonDetailsView({Key? key, required this.title, required this.lesson}) : super(key: key);

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
        body: GetBuilder<TextToSpeechController>(
          builder: (controller) {
            return SingleChildScrollView(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  AudioPlayerWidget(text: lesson.data.toString(),),
                  SizedBox(height: 12.h,),
                  Text("${lesson.data}", style: TextStyle(fontSize: 14.sp),),
                  SizedBox(height: 30.h,),
                  SizedBox(height: 10.h,),
                ],
              ),
            );
          }
        ),
        bottomNavigationBar:  GetBuilder<TextToSpeechController>(
          builder: (controller) {
            return Padding(
              padding:  EdgeInsets.symmetric(vertical: 8.0, horizontal: 5.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _outlineButton(
                    text: "US",
                    onTap: (){
                      controller.textToSpeechUSListening(lesson.data.toString());
                    },
                  ),
                  _outlineButton(
                    text: "UK",
                    onTap: (){
                      controller.textToSpeechUKListening(lesson.data.toString());
                    },
                  )
                ],
              ),
            );
          }
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: (){
            ListeningController listen = Get.find();
            listen.addToAnsweredQuestions(lesson,);
            Get.to(() =>  ListeningQuizView(title: title, lesson: lesson,));
          },
          child: const Icon(Icons.copy),
        ),
      ),
    );
  }
  Widget _outlineButton({ required String text, required Function() onTap})
  {
    return SizedBox(
      width: 0.45.sw,
      height: 45.h,
      child: OutlinedButton(
          onPressed: onTap,
          style: ButtonStyle(
              side: MaterialStatePropertyAll(BorderSide(color: AppColors.primaryColor))
          ),
          child:Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(Icons.volume_up, color: Colors.red, size: 25.w,),
              Text(text, style: TextStyle(color: Colors.red, fontSize: 22.sp),),
              const SizedBox()
            ],
          )
      ),
    );
  }
}
