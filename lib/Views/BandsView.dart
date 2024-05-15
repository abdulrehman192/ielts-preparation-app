import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:ielts_app/Controllers/CalculatorController.dart';
import 'package:ielts_app/Widgets/BandCard.dart';

class BandsView extends StatelessWidget {
  const BandsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Band Scores"),
      ),
      body: GetBuilder<CalculatorController>(
        builder: (controller) {
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("You'll receive a score between 1 to 9 for speaking section of your test. You can score whole (e.g. 5.0, 6.0, 7.0) or half (e.g. 5.5, 6.5, 7.5) band in your test.\n\nHow are IELTS speaking scores calculated? This is an important question for any IELTS candidate because many mistakes can be avoided by knowing what examiner is looking for and how your speaking is graded. The following information give you outline of the grading criteria, how band score calculated and how examiners typically grade the speaking.", style: TextStyle(fontSize: 14.sp, ),),
              ),
              Expanded(
                child: ListView.builder(
                  padding: EdgeInsets.all(8.w),
                  itemCount: controller.bands.length,
                  itemBuilder: (context, index)
                  {
                    return BandCard(band: controller.bands[index]);
                  },
                ),
              ),
            ],
          );
        }
      ),
    );
  }
}
