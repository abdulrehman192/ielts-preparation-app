import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:ielts_app/Constants/AppColors.dart';
import 'package:ielts_app/Controllers/TextToSpeechController.dart';

class AudioPlayerWidget extends StatelessWidget {
  final String text;
  const AudioPlayerWidget({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<TextToSpeechController>(
      builder: (controller) {
        return GetBuilder<AppColors>(
          builder: (color) {
            return Container(
              width: 1.sw,
              // height: 100.h,
              color: color.isPurple ? Colors.purple.shade200 :Colors.red.shade200,
              padding: EdgeInsets.all(10.w),
              child: Column(
                children: [
                  Slider(
                      thumbColor: Colors.white,
                      activeColor: Colors.white,
                      inactiveColor: color.isPurple ? Colors.purple : Colors.red,
                      value: controller.played > 1 ? 1 : controller.played,
                      onChanged: (val)
                      {

                      }
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: (){
                          controller.pauseOrResume(text);
                        },
                        child: CircleAvatar(
                          backgroundColor: Colors.white,
                          child: Icon(controller.play ? Icons.pause : Icons.play_arrow, size: 28.w, color: Colors.black.withOpacity(0.8),),
                        ),
                      ),
                      SizedBox(width: 12.w,),
                      GestureDetector(
                        onTap: (){
                          controller.stopSpeech();
                        },
                        child: CircleAvatar(
                          backgroundColor: color.isPurple ? Colors.purple.shade400 : Colors.red.shade400,
                          child: Icon(Icons.stop, size: 25.w, color: Colors.white.withOpacity(0.8),),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            );
          }
        );
      }
    );
  }
}
