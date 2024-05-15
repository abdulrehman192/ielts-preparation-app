import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:ielts_app/Controllers/ProverbIdiomController.dart';
import 'package:ielts_app/Views/SearchIdiomsAndProverbsView.dart';

import '../Widgets/ProverbIdiomCard.dart';

class ProverbsAndIdiomsView extends StatelessWidget {
  final String title;
  const ProverbsAndIdiomsView({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        actions: [
          IconButton(
              onPressed: (){
                ProverbIdiomController p = Get.find();
                p.type = title;
                p.getSearchItems();
                Get.to(() => const SearchIdiomsAndProverbsView());
              },
              icon: const Icon(Icons.search)
          )
        ],
      ),
      body: GetBuilder<ProverbIdiomController>(
        builder: (controller) {
          return controller.loading ? const Center(child: CircularProgressIndicator(),) :
          controller.items.isEmpty ?  Center(child: Text("No $title Found"),) :
            ListView.builder(
                controller: controller.scrollController,
                padding: EdgeInsets.all(8.w),
                itemCount: controller.loadingMore ? controller.items.length + 1 :controller.items.length,
                itemBuilder: (context, index)
                  {
                    if(index < controller.items.length)
                      {
                        return ProverbIdiomCard(item : controller.items[index], isSearch: false,);
                      }
                    else
                    {
                      return const Center(child: CircularProgressIndicator());
                    }
                  }
          );
        }
      ),
    );
  }
}
