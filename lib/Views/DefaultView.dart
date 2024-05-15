import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:ielts_app/Constants/AppAssets.dart';
import 'package:ielts_app/Controllers/DashboardController.dart';
import 'package:ielts_app/Controllers/WordsController.dart';
import 'package:ielts_app/Views/5KWordsView.dart';
import 'package:ielts_app/Views/CalculatorView.dart';
import 'package:ielts_app/Views/EssaysView.dart';
import 'package:ielts_app/Views/TestView.dart';
import 'package:ielts_app/Views/WritingView.dart';
import 'package:ielts_app/Widgets/DashboardCard.dart';
import 'BandsView.dart';
import 'FAQView.dart';
import 'TipsView.dart';

class DefaultView extends StatelessWidget {
  const DefaultView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: GridView.count(
        padding: EdgeInsets.all(10.w),
        crossAxisCount: 2,
        mainAxisSpacing: 8.w,
        crossAxisSpacing: 8.w,
        children:  [

          DashboardCard(
            imageUrl: AppAssets.testIcon,
            title: "IELTS Test",
            onTap: (){
              DashboardController controller = Get.find();
              controller.tabController.index = 6;
              // Get.to(() => IELTSTestView());
            },
          ),
          DashboardCard(
            imageUrl: AppAssets.wordIcon,
            title: "5000 IELTS Words",
            onTap: (){
              WordsController word = Get.find();
              word.letter = "a";
              Get.to(() => const WordsView(title: '5000 IELTS Words',));
            },
          ),
          DashboardCard(
            imageUrl: AppAssets.ieltsIcon,
            title: "Cambridge Writing",
            onTap: (){
              Get.to(() => const WritingView(isDashboard: true));
            },
          ),
          DashboardCard(
            imageUrl: AppAssets.writing2Icon,
            title: "Essays",
            onTap: (){
              Get.to(() => const EssaysView());
            },
          ),
          DashboardCard(
            imageUrl: AppAssets.bandsIcon,
            title: "Bands",
            onTap: (){
              Get.to(() => const BandsView());
            },
          ),
          DashboardCard(
            imageUrl: AppAssets.tipsIcon,
            title: "Tips & Tricks",
            onTap: (){
              Get.to(() => const TipsView());
            },
          ),
          DashboardCard(
            imageUrl: AppAssets.calculatorIcon,
            title: "Calculator",
            onTap: (){
              Get.to(() => const CalculatorView());
            },
          ),
          DashboardCard(
            imageUrl: AppAssets.faqIcon,
            title: "FAQ's",
            onTap: (){
              Get.to(() => const FAQView());
            },
          ),
        ],
      ),
    );
  }
}
