import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:ielts_app/Controllers/TipsController.dart';
import 'package:ielts_app/Widgets/FAQCard.dart';

class FAQView extends StatelessWidget {
  const FAQView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("General IELTS FAQ's"),
      ),
      body: GetBuilder<TipsAndFAQController>(
        builder: (controller)
        {
          return
          controller.faqs.isEmpty ? const Center(child: Text("No FAQ's Available"),) :
          ListView.builder(
              padding: EdgeInsets.all(8.w),
              itemCount: controller.faqs.length,
              itemBuilder: (context, index)
              {
                return FAQCard(faq: controller.faqs[index],);
              }
          );
        },
      ),
    );
  }
}
