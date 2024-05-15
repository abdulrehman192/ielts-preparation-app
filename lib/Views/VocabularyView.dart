import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:ielts_app/Constants/AppColors.dart';
import 'package:ielts_app/Controllers/ProverbIdiomController.dart';
import 'package:ielts_app/Views/5KWordsView.dart';
import 'package:ielts_app/Views/ImportantWordsView.dart';
import 'package:ielts_app/Widgets/ItemCard.dart';

import '../Controllers/WordsController.dart';
import 'ProverbsView.dart';

class VocabularyView extends StatelessWidget {
  const VocabularyView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AppColors>(
      builder: (color) {
        return Scaffold(
          backgroundColor: Colors.white,
          body: ListView(
            padding: EdgeInsets.all(15.w),
            children: [
              ItemCard(
                imageText: "50K",
                title: "5000 Words",
                onTap: (){
                  WordsController word = Get.find();
                  word.letter = "a";
                  Get.to(() => const WordsView(title: "5000 IELTS Words",));
                },
              ),
              ItemCard(
                imageText: "IMP Words",
                title: "Important IELTS Vocabulary",
                onTap: (){
                  Get.to(() => const ImportantWordsView());
                },
              ),
              ItemCard(
                imageText: "P",
                title: "Proverbs",
                onTap: (){
                  ProverbIdiomController pi = Get.find();
                  pi.type = "Proverbs";
                  pi.getItems();
                  Get.to(() => const ProverbsAndIdiomsView(title: "Proverbs",));
                },
              ),
              ItemCard(
                imageText: "I",
                title: "Idioms",
                onTap: (){
                  ProverbIdiomController pi = Get.find();
                  pi.type = "Idioms";
                  pi.getItems();
                  Get.to(() => const ProverbsAndIdiomsView(title: "Idioms",));
                },
              ),
            ],
          ),
        );
      }
    );
  }
}
