import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:ielts_app/Controllers/WordsController.dart';
import 'package:ielts_app/Widgets/InputFiled.dart';
import 'package:ielts_app/Widgets/WordCard.dart';

class ImportantWordsView extends StatelessWidget {
  const ImportantWordsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Important IELTS Vocabulary"),
      ),
      body: GetBuilder<WordsController>(
        builder: (controller)
        {
          return controller.loading ? const Center(child: CircularProgressIndicator(),):
          ListView.builder(
              itemCount: controller.importantWords.length,
              padding: EdgeInsets.all(8.w),
              itemBuilder: (context, index)
              {
                return WordCard(
                    word: controller.importantWords[index],
                    isImportant: true,
                    isSearch: false,
                );
              }
          );
        },
      ),
    );
  }
}
