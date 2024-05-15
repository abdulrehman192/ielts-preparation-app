import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:ielts_app/Controllers/ReadingController.dart';
import 'package:ielts_app/Views/SearchIrregularSlangView.dart';

import '../Widgets/IrregularVerbCard.dart';

class IrregularVerbsView extends StatelessWidget {
  const IrregularVerbsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Irregular Verbs"),
        actions: [
          IconButton(
              onPressed: (){
                ReadingController con = Get.find();
                con.getSearchVerbs();
                Get.to(() => SearchIrregularSlangView(title: "Irregular Verbs"));
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
              controller.irregularVerbs.isEmpty ? const Center(child: Text("No Data Found"),):
            ListView.builder(
              itemCount: controller.irregularVerbs.length,
              padding: EdgeInsets.all(8.w),
              itemBuilder: (context, index)
                  {
                     return IrregularVerbCard(
                         verb: controller.irregularVerbs[index],
                         isSearch: false
                     );
                  }
          );
        },
      ),
    );
  }
}
