import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:ielts_app/Constants/AppColors.dart';
import '../Controllers/WritingController.dart';
import '../Widgets/WritingCard.dart';

class WritingView extends StatelessWidget {
  final bool isDashboard;
  const WritingView({Key? key, required this.isDashboard}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AppColors>(
      builder: (color) {
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: isDashboard == false ? PreferredSize(child: const SizedBox.shrink(), preferredSize: Size.zero):
          AppBar(
            title: const Text("Writing Lessons"),
          )
          ,
          body: GetBuilder<WritingController>(
              builder: (controller) {
                return
                  controller.loading ? const Center(child: CircularProgressIndicator(),) :
                  controller.lessons.isEmpty ? const Center(child: Text("No Lessons Found"),) :
                  ListView.builder(
                      padding: EdgeInsets.all(8.w),
                      itemCount: controller.lessons.length,
                      itemBuilder: (context, index)
                      {
                        return WritingCard(index: index, lesson: controller.lessons[index]);
                      }
                  );
              }
          ),
        );
      }
    );
  }
}
