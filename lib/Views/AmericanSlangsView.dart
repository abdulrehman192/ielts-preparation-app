import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:ielts_app/Controllers/ReadingController.dart';
import 'package:ielts_app/Widgets/EssayCard.dart';
import 'package:ielts_app/Widgets/SlangCard.dart';

import 'SearchIrregularSlangView.dart';

class AmericanSlangView extends StatelessWidget {
  const AmericanSlangView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("American Slang"),
        actions: [
          IconButton(
              onPressed: (){
                ReadingController con = Get.find();
                con.getSearchVerbs();
                Get.to(() => SearchIrregularSlangView(title: "Slang"));
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
              controller.slangs.isEmpty ? const Center(child: Text("No Data Found"),):
            ListView.builder(
              itemCount: controller.slangs.length,
              padding: EdgeInsets.all(8.w),
              itemBuilder: (context, index)
                  {
                     return SlangCard(
                         slang: controller.slangs[index],
                         isSearch: false
                     );
                  }
          );
        },
      ),
    );
  }
}
