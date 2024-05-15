import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:ielts_app/Controllers/SpeakingController.dart';
import 'package:ielts_app/Widgets/SpeakingCard.dart';

import '../Constants/AppColors.dart';

class SpeakingView extends StatelessWidget {
  const SpeakingView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AppColors>(
      builder: (color) {
        return Scaffold(
          backgroundColor: Colors.white,
          body: GetBuilder<SpeakingController>(
            builder: (controller) {
              return
              controller.loading ? const Center(child: CircularProgressIndicator(),) :
              controller.lessons.isEmpty ? const Center(child: Text("No Lessons Found"),) :
               ListView.builder(
                 padding: EdgeInsets.all(8.w),
                  itemCount: controller.lessons.length,
                  itemBuilder: (context, index)
                      {
                        return SpeakingCard(index: index, lesson: controller.lessons[index]);
                      }
              );
            }
          ),
        );
      }
    );
  }
}
