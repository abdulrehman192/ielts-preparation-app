import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:ielts_app/Widgets/TipCard.dart';

import '../Controllers/TipsController.dart';
import '../Models/TipModel.dart';

class TipsView extends StatelessWidget {
  const TipsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("IELTS Tips"),
      ),
      body: GetBuilder<TipsAndFAQController>(
        builder: (controller)
        {
          return
            controller.tips.isEmpty ? const Center(child: Text("No Tips Available"),) :
            ListView.builder(
              padding: EdgeInsets.all(8.w),
              itemCount: controller.tips.length,
              itemBuilder: (context, index)
                  {
                    return TipCard(tip: controller.tips[index], index: index);
                  }
          );
        },
      ),
    );
  }
}
