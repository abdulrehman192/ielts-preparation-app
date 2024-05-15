import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:ielts_app/Controllers/ReadingController.dart';
import 'package:ielts_app/Widgets/EssayCard.dart';
import 'package:ielts_app/Widgets/SlangCard.dart';

import 'SearchEssayOrStoryView.dart';

class StoriesView extends StatelessWidget {
  const StoriesView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Stories List"),
        actions: [
          IconButton(
              onPressed: (){
                ReadingController con = Get.find();
                con.getSearchVerbs();
                Get.to(() => SearchEssayOrStoryView(title: "Story"));
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
              controller.stories.isEmpty ? const Center(child: Text("No Data Found"),):
            ListView.builder(
              itemCount: controller.stories.length,
              padding: EdgeInsets.all(8.w),
              itemBuilder: (context, index)
                  {
                     return  EssayCard(
                       essay: controller.stories[index],
                       isSearch: false,
                       isStory: true,
                       isEssay: false,
                       isArticle: false,
                     );
                  }
          );
        },
      ),
    );
  }
}
