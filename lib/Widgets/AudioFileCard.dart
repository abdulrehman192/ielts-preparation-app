import 'dart:io';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:ielts_app/Constants/AppColors.dart';
import 'package:ielts_app/Controllers/SpeakingController.dart';
import 'package:ielts_app/Models/AudioFile.dart';
import 'package:ielts_app/Utils/CommonFunctions.dart';

class AudioFileCard extends StatelessWidget {
  final AudioFile audioFile;
  final int index;
  const AudioFileCard({super.key, required this.audioFile, required this.index});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.symmetric(vertical : 5.w),
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
            child: GetBuilder<SpeakingController>(
              builder: (controller) {
                return Row(
                  children: [
                    Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("${audioFile.fileName}"),
                            SizedBox(height: 5.h,),
                            Text("Duration : ${CommonFunctions.formatHHMMSS(audioFile.seconds ?? 0)}"),
                          ],
                        )
                    ),
                    SizedBox(width: 1.w,),
                    GestureDetector(
                      onTap: ()async{
                        if(controller.player.state == PlayerState.completed || controller.player.state == PlayerState.stopped || index != controller.playingIndex)
                        {
                          await controller.playAudio(audioFile.path.toString(), index, audioFile.seconds ?? 0);
                        }
                        else if(controller.player.state == PlayerState.paused || controller.player.state == PlayerState.playing)
                        {
                          await controller.togglePauseOrResume(audioFile.seconds ?? 0);
                        }
                      },
                      child: CircleAvatar(
                        child: Icon(index == controller.playingIndex && controller.isPlaying ? Icons.pause_circle : Icons.play_circle),
                      ),
                    ),
                    SizedBox(width: 1.w,),
                    Column(
                      children: [
                        IconButton(
                            onPressed: ()async{
                              File file = File(audioFile.path.toString());
                              if(file.existsSync())
                              {
                                await CommonFunctions.shareFile(file: file, text: "${audioFile.fileName}.mp3");
                              }
                            },
                            splashRadius: 20,
                            icon: Icon(Icons.share, color: AppColors.primaryColor,)
                        ),
                        IconButton(
                            onPressed: (){
                              CommonFunctions.showConfirmDialogue(
                                  title: "Delete File",
                                  message: "Do you want to delete this recording file?",
                                  onYes: () async
                                  {
                                    controller.deleteFile(audioFile.path.toString());
                                  }
                              );
                            },
                            splashRadius: 20,
                            icon: Icon(Icons.delete_forever, color: Colors.red,)
                        )
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
