
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:get/get.dart';

class TextToSpeechController extends GetxController
{
  final FlutterTts  _ttsUS = FlutterTts();
  final FlutterTts  _ttsUK = FlutterTts();
  bool play = false;
  double played = 0;
  Timer _timer = Timer(const Duration(milliseconds: 200), () { });

  _initializeSpeech() async
  {
    await _ttsUS.setVolume(1.0);
    await _ttsUS.setSpeechRate(0.5);
    await _ttsUS.setPitch(0.5);
    await _ttsUS.setLanguage("en-US");
    await _ttsUK.setLanguage("en-GB");
    await _ttsUS.setSilence(1);
    Map<String, String> voice = {"name": "en-us-x-sfg-local", "locale": "en-US"};
    await _ttsUS.setVoice(voice);
    update();

  }

  @override
  onInit()
  {
    super.onInit();
    _initializeSpeech();
  }


  textToSpeechUS(String text) async
  {
    try
    {
      await _ttsUS.setLanguage("en-US");
      await _ttsUS.setPitch(1.0);
      if(text.isNotEmpty)
      {
        await stopSpeech();
        await _ttsUS.speak(text);
        // await ttsUS.stop();
        update();
      }
    }
    catch(_)
    {
      Get.defaultDialog(
          title: "No Internet",
          content: const Text("Speech Required Internet"),
          actions: [
            ElevatedButton(
                onPressed: (){
                  Get.back();
                },
                child: const Text("OK")
            )
          ]
      );
    }
  }

  textToSpeechUK(String text)async
  {
    try
    {
      await _ttsUK.setLanguage("en-GB");
      await _ttsUS.setPitch(0.5);

      if(text.isNotEmpty)
      {
        await stopSpeech();
        await _ttsUK.speak(text);
        // await ttsUK.stop();
        update();
      }
    }
    catch(_)
    {
      Get.defaultDialog(
          title: "No Internet",
          content: const Text("Speech Required Internet"),
          actions: [
            ElevatedButton(
                onPressed: (){
                  Get.back();
                },
                child: const Text("OK")
            )
          ]
      );
    }
  }

  stopSpeech()async
  {
    await _ttsUS.stop();
    await _ttsUK.stop();
    played = 0;
    play = false;
    _timer.cancel();
    update();
  }


  pauseOrResume(String text)async
  {
    if(play && played > 0)
      {
        await _ttsUS.pause();
        await _ttsUK.pause();
        play = false;
        _timer.cancel();
        update();
      }
    else if(!play && played > 0)
    {
      textToSpeechUSListening(text);
      play = false;
      update();
    }
    else
      {
        textToSpeechUSListening(text);
      }
  }

  textToSpeechUSListening(String text) async
  {
    try
    {
      play = true;
      played = 0;
      update();
      int p = 0;

      int total = text.split(" ").length;
      await _ttsUS.setLanguage("en-US");
      await _ttsUS.setSpeechRate(0.5);
      await _ttsUS.setPitch(1.0);
      if(text.isNotEmpty)
      {
        await stopSpeech();
        await _ttsUS.speak(text).whenComplete(() {
          played = total.toDouble();
          _timer.cancel();
          update();
        });
        play = true;
        _timer = Timer.periodic(const Duration(milliseconds: 350), (timer) {
          p++;
          played = p / total;
          print(played);
          if(played == total)
            {
              timer.cancel();
            }
          if(played > total)
            {
              played = total.toDouble();
            }
          update();
        });
        update();
      }
    }
    catch(_)
    {
      Get.defaultDialog(
          title: "No Internet",
          content: const Text("Speech Required Internet"),
          actions: [
            ElevatedButton(
                onPressed: (){
                  Get.back();
                },
                child: const Text("OK")
            )
          ]
      );
    }
  }


  textToSpeechUKListening(String text) async
  {
    try
    {
      play = true;
      played = 0;
      update();
      int p = 0;

      int total = text.split(" ").length;
      await _ttsUK.setLanguage("en-GB");
      await _ttsUK.setSpeechRate(0.4);
      await _ttsUK.setPitch(0.5);
      if(text.isNotEmpty)
      {
        await stopSpeech();
        await _ttsUK.speak(text).whenComplete(() {
          played = total.toDouble();
          _timer.cancel();
          update();
        });
        play = true;
        _timer = Timer.periodic(const Duration(milliseconds: 530), (timer) {
          p++;
          played = p / total;
          print(played);
          if(played == total)
          {
            timer.cancel();
          }
          if(played > total)
          {
            played = total.toDouble();
          }
          update();
        });
        update();
      }
    }
    catch(_)
    {
      Get.defaultDialog(
          title: "No Internet",
          content: const Text("Speech Required Internet"),
          actions: [
            ElevatedButton(
                onPressed: (){
                  Get.back();
                },
                child: const Text("OK")
            )
          ]
      );
    }
  }

  @override
  void dispose() {
    super.dispose();
    stopSpeech();
  }

}