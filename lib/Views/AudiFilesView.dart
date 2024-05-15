import 'dart:io';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:ielts_app/Constants/AppColors.dart';
import 'package:ielts_app/Controllers/SpeakingController.dart';
import 'package:ielts_app/Utils/CommonFunctions.dart';
import 'package:ielts_app/Widgets/AudioFileCard.dart';

class AudiFilesView extends StatelessWidget {
  const AudiFilesView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Record Files List"),
      ),
      body: GetBuilder<SpeakingController>(
        builder: (controller)
        {
          return controller.audioFiles.isEmpty ? const Center(child: Text("No Recording Files to show"),) :
            ListView.builder(
                padding: EdgeInsets.all(8.w),
                itemCount: controller.audioFiles.length,
                itemBuilder: (context, index)
                    {
                      return AudioFileCard(audioFile: controller.audioFiles[index], index: index,);
                    }
            );
        },
      ),
    );
  }
}
