
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:ielts_app/Controllers/SpeakingController.dart';
import 'package:ielts_app/Controllers/TextToSpeechController.dart';
import 'package:ielts_app/Models/SpeakingModel.dart';
import 'package:ielts_app/Utils/CommonFunctions.dart';
import 'package:ielts_app/Views/AudiFilesView.dart';

import '../Constants/AppColors.dart';

class SpeakingLessonDetailsView extends StatelessWidget {
  final String title;
  final Speaking lesson;
  final int index;
  const SpeakingLessonDetailsView({Key? key, required this.title, required this.lesson, required this.index}) : super(key: key);

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
          actions: [
            IconButton(
                onPressed: (){
                  Get.to(() => const AudiFilesView());
                },
                splashRadius: 20,
                tooltip: "Recording Files",
                icon: const Icon(Icons.list)
            )
          ],
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("\nYou should say:\n", style: TextStyle(fontSize: 14.sp),),
              Text(lesson.suggestion.toString(), style: TextStyle(fontSize: 14.sp),),
              SizedBox(height: 8.h,),
              Center(child: Text("-----Sample Answer-----", style: TextStyle(color: Colors.grey.shade700, fontSize: 15.sp, fontWeight: FontWeight.bold),),),
              SizedBox(height: 8.h,),
              Text(lesson.data.toString(), style: TextStyle(fontSize: 14.sp),),
            ],
          ),
        ),
        bottomNavigationBar: Container(
          width: 1.sw,
          height: 105.h,
          padding: EdgeInsets.all(10.w),
          child: GetBuilder<SpeakingController>(
            builder: (speak) {
              return Column(
                mainAxisAlignment: speak.isRecording ? MainAxisAlignment.spaceEvenly : MainAxisAlignment.spaceBetween,
                children: [
                  Text(CommonFunctions.formatHHMMSS(speak.seconds), style: TextStyle(fontSize: 17.sp, fontWeight: FontWeight.bold, color: AppColors.primaryColor),),

                  speak.isRecording == false ?
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: (){
                          Get.to(() => const AudiFilesView());
                        },
                        child: CircleAvatar(
                          child: const Icon(Icons.list),
                        ),
                      ),
                      FloatingActionButton(
                          onPressed: (){
                            speak.fileName = "Lesson #${index + 1}";
                            speak.startRecording();
                          },
                        child: Icon(Icons.mic),
                      ),
                      SizedBox()
                    ],
                  ):
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      IconButton(
                          onPressed: ()async{
                            await speak.stopRecording();
                            speak.seconds = 0;
                            speak.update();
                            await speak.deleteFile(speak.savedFilePath);
                          },
                          splashRadius: 20,
                          icon: const Icon(Icons.close)
                      ),
                      IconButton(
                          onPressed: ()async{
                            await speak.stopRecording();
                            speak.seconds = 0;
                            speak.update();
                            CommonFunctions.showSnackBar("File Saved", "Your recording successfully saved");
                          },
                          splashRadius: 20,
                          icon: const Icon(Icons.done)
                      ),
                      IconButton(
                          onPressed: (){
                            speak.pauseOrResumeRecording();
                          },
                          splashRadius: 20,
                          icon:  Icon(speak.isPaused ? Icons.play_circle : Icons.pause_circle)
                      ),

                    ],
                  )
                ],
              );
            }
          ),
        ),
      ),
    );
  }

}
