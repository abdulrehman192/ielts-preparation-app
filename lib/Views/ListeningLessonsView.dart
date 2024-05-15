import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:ielts_app/Controllers/ListeningController.dart';
import 'package:ielts_app/Models/ListeningLesson.dart';

import '../Widgets/ListeningCard.dart';

class ListeningLessonsView extends StatelessWidget {
  final String title;
  const ListeningLessonsView({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: GetBuilder<ListeningController>(
        builder: (controller)
        {
          List<ListeningLesson> lessons = [];
          if(title.contains("Beginner"))
            {
              lessons = controller.beginnerLessons;
            }
          if(title.contains("Intermediate"))
          {
            lessons = controller.intermediateLessons;
          }
          if(title.contains("Advanced"))
          {
            lessons = controller.advancedLessons;
          }
          if(title.contains("Conversations"))
          {
            lessons = controller.conversationsLessons;
          }
          if(lessons.isEmpty)
            {
              return Center(child: Text("No Data Found"),);
            }
          return ListView.builder(
              padding: EdgeInsets.all(8.w),
              itemCount: lessons.length,
              itemBuilder: (context, index)
                  {
                    return ListeningCard(index:  index,lesson: lessons[index],);
                  }
          );
        },
      ),
    );
  }
}
