import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:ielts_app/Constants/AppAssets.dart';
import 'package:ielts_app/Constants/AppColors.dart';
import 'package:ielts_app/Controllers/ReadingController.dart';
import 'package:ielts_app/Controllers/ProverbIdiomController.dart';
import 'package:ielts_app/Controllers/TextToSpeechController.dart';
import 'package:ielts_app/Controllers/WordsController.dart';
import 'package:ielts_app/Services/SQLiteService.dart';

import 'DashboardView.dart';

class SplashView extends StatefulWidget {
  const SplashView({Key? key}) : super(key: key);

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {


  _copyDatabase()
  {
    final db = SqliteService.instance;

    Future.delayed(const Duration(seconds: 1), (){
      Get.offAll(()=> const DashboardView());
        db.copyDatabase();
    });

  }
  @override
  void initState() {
    super.initState();
    _copyDatabase();
  }

  @override
  Widget build(BuildContext context) {
    Get.put(TextToSpeechController(), permanent: true);
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          children: [
            const Spacer(),
            Text("IELTS Preparation", style: TextStyle(fontSize: 24.w, fontWeight: FontWeight.w600, color: AppColors.primaryColor),),
            SizedBox(height: 12.h,),
            Image.asset(AppAssets.splashImage, width: 0.70.sw,),
            SizedBox(height: 20.h,),
            SizedBox(
              width: 0.80.sw,
              child:  const LinearProgressIndicator(
                backgroundColor: Colors.black,
                minHeight: 5.0,
              )
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
