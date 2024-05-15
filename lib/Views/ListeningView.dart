import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:ielts_app/Constants/AppColors.dart';
import 'package:ielts_app/Views/ListeningLessonsView.dart';
import 'package:ielts_app/Views/ListeningTalkShowsView.dart';

import '../Widgets/ItemCard.dart';

class ListeningView extends StatelessWidget {
  const ListeningView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AppColors>(
      builder: (color) {
        return Scaffold(
          backgroundColor: Colors.white,
          body: ListView(
            padding: EdgeInsets.all(15.w),
            children:  [
              ItemCard(
                  imageText: "B",
                  title: "Beginners",
                  onTap: (){
                    Get.to(() => ListeningLessonsView(title: "Beginner Level"));
                  },
              ),
              ItemCard(
                  imageText: "I",
                  title: "Intermediate",
                onTap: (){
                  Get.to(() => ListeningLessonsView(title: "Intermediate Level"));
                },
              ),
              ItemCard(
                  imageText: "A",
                  title: "Advanced",
                onTap: (){
                  Get.to(() => ListeningLessonsView(title: "Advanced Level"));
                },
              ),
              ItemCard(
                  imageText: "C",
                  title: "English TV Talk Shows",

                  onTap: (){
                    Get.to(() => ListeningTalkShowsView());
                  },
              ),

            ],
          ),
        );
      }
    );
  }
}
