import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:ielts_app/Controllers/ReadingController.dart';
import 'package:ielts_app/Views/SearchEssayOrStoryView.dart';
import 'package:ielts_app/Widgets/EssayCard.dart';
import 'package:ielts_app/Widgets/SlangCard.dart';

class EssaysView extends StatelessWidget {
  const EssaysView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Essays List"),
        actions: [
          IconButton(
              onPressed: (){
                ReadingController con = Get.find();
                con.getSearchVerbs();
                Get.to(() => SearchEssayOrStoryView(title: "Essay"));
              },
              splashRadius: 20,
              icon: const Icon(Icons.search)
          )
        ],
      ),
      body: GetBuilder<ReadingController>(
        builder: (controller)
        {
          return controller.loading ? const Center(child: CircularProgressIndicator(),):
              controller.essays.isEmpty ? const Center(child: Text("No Data Found"),):
            ListView.builder(
              itemCount: controller.essays.length,
              padding: EdgeInsets.all(8.w),
              itemBuilder: (context, index)
                  {
                     return  EssayCard(
                       essay: controller.essays[index],
                       isSearch: false,
                       isStory: false,
                       isEssay: true,
                       isArticle: false,
                     );
                  }
          );
        },
      ),
    );
  }
}
