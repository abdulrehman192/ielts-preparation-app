import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:ielts_app/Constants/AppColors.dart';
import 'package:ielts_app/Views/AmericanSlangsView.dart';
import 'package:ielts_app/Views/ArticleView.dart';
import 'package:ielts_app/Views/EssaysView.dart';
import 'package:ielts_app/Views/IrregularVerbsView.dart';
import 'package:ielts_app/Views/StoriesView.dart';

import '../Widgets/ItemCard.dart';

class ReadingView extends StatelessWidget {
  const ReadingView({Key? key}) : super(key: key);

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
                imageText: "E",
                title: "Essays",
                onTap: (){
                  Get.to(() => const EssaysView());
                },
              ),
              ItemCard(
                imageText: "S",
                title: "Stories",
                onTap: (){
                  Get.to(() => const StoriesView());
                },
              ),
              ItemCard(
                imageText: "AS",
                title: "American Slangs",
                onTap: (){
                  Get.to(() => const AmericanSlangView());
                },
              ),
              ItemCard(
                imageText: "IV",
                title: "Irregular Verbs",
                onTap: (){
                  Get.to(() => const IrregularVerbsView());
                },
              ),
              ItemCard(
                imageText: "AP",
                title: "Articles & Publications",
                onTap: (){
                  Get.to(() => const ArticleView());
                },
              ),
            ],
          ),
        );
      }
    );
  }
}
