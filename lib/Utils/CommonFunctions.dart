import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';

import '../Models/YouTubeVideoMetaData.dart';

class CommonFunctions
{
    static showSnackBar(String title, String message)
    {
        GetSnackBar snackBar = GetSnackBar(title: title, message: message, duration: const Duration(seconds: 2),);
        Get.showSnackbar(snackBar);
    }

    static showConfirmDialogue({required String title, required String message, required Function() onYes})
    {
      Get.defaultDialog(
        title: title,
        content: Text(message),
        actions: [
          ElevatedButton(
              onPressed: ()async{
                  await onYes();
                  Get.back();
              },
              child: const Text("Yes")
          ),
          ElevatedButton(
              onPressed: (){
                Get.back();
              },
              child: const Text("No")
          ),
        ]
      );
    }


    static copyToClipboard(String text) async
    {
        await Clipboard.setData(ClipboardData(text: text));
        showSnackBar("Copy", "Text copy to clipboard");
    }

    static rateApp() async
    {
      await launchUrl(Uri.parse("https://play.google.com/store/apps/details?id=com.streamlogic.ielts_app"), mode: LaunchMode.externalApplication);
    }

    static shareText(String text) async
    {
       await Share.share(text);
    }

    static shareFile({required File file, required String text}) async
    {
      await Share.shareXFiles([XFile(file.path)], text: text);
    }

    static Future<bool> isConnectedToInternet()async
    {
        bool  connected = false;
        try {
          final result = await InternetAddress.lookup('google.com');
                if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
                    connected = true;
                }
                else
                {
                    connected = false;
                }
        } on SocketException catch (e) {
            print(e);
            connected = false;
        }
        return connected;
    }

    static Future<YouTubeVideoMetaData> getVideoMetaData(String videoUrl) async {
      final YoutubeExplode yt = YoutubeExplode();
      final video = await yt.videos.get(videoUrl);
      print(" title : ${video.title}");
      final title = video.title;

      final channelName = video.channelId;
      final description = video.description;
      final viewCount = video.engagement.viewCount;
      final likeCount = video.engagement.likeCount;
      final dislikeCount = video.engagement.dislikeCount;
      final thumbnailUrl = video.thumbnails.highResUrl.toString();

      yt.close();
      return YouTubeVideoMetaData(
        title: title,
        channelName: channelName.value,
        description: description,
        viewCount: viewCount,
        likeCount: likeCount ?? 0,
        dislikeCount: dislikeCount ?? 0,
        thumbnailUrl: thumbnailUrl,
        duration: video.duration ?? Duration.zero,
        isLive: video.isLive
      );
    }

    static String formatHHMMSS(int seconds) {
      int hours = (seconds / 3600).truncate();
      seconds = (seconds % 3600).truncate();
      int minutes = (seconds / 60).truncate();

      String hoursStr = (hours).toString().padLeft(2, '0');
      String minutesStr = (minutes).toString().padLeft(2, '0');
      String secondsStr = (seconds % 60).toString().padLeft(2, '0');

      if (hours == 0) {
        return "$minutesStr:$secondsStr";
      }

      return "$hoursStr:$minutesStr:$secondsStr";
    }


    static String formatDate(DateTime dateTime)
    {
      return DateFormat("dd-MMM-yyyy").format(dateTime);
    }
}
