import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:ielts_app/Controllers/ReadingController.dart';
import 'package:ielts_app/Views/SearchEssayOrStoryView.dart';
import 'package:ielts_app/Widgets/EssayCard.dart';
import 'package:ielts_app/Widgets/SlangCard.dart';

class ArticleView extends StatelessWidget {
  const ArticleView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Articles List"),
        actions: [
          IconButton(
              onPressed: (){
                ReadingController con = Get.find();
                con.getSearchVerbs();
                con.getSearchArticles();
                con.getSearchStories();
                con.getSearchEssays();
                Get.to(() => SearchEssayOrStoryView(title: "Article"));
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
              controller.articles.isEmpty ? const Center(child: Text("No Data Found"),):
            ListView.builder(
              itemCount: controller.articles.length,
              padding: EdgeInsets.all(8.w),
              itemBuilder: (context, index)
                  {
                     return  EssayCard(
                       essay: controller.articles[index],
                       isSearch: false,
                       isStory: false,
                       isEssay: false,
                       isArticle: true,
                     );
                  }
          );
        },
      ),
    );
  }
}
