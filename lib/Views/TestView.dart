import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:ielts_app/Controllers/TestController.dart';
import 'package:ielts_app/Widgets/TestCard.dart';

import '../Constants/AppColors.dart';

class IELTSTestView extends StatefulWidget {
  const IELTSTestView({super.key});

  @override
  State<IELTSTestView> createState() => _IELTSTestViewState();
}

class _IELTSTestViewState extends State<IELTSTestView> with SingleTickerProviderStateMixin {
  late TabController tabController;


  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 3, vsync: this);
  }
  @override
  Widget build(BuildContext context) {
    return GetBuilder<AppColors>(
      builder: (color) {
        return Scaffold(

          body: GetBuilder<TestController>(
            builder: (controller) {
              return Column(
                children: [
                  Material(
                    color: AppColors.primaryColor,
                    child: TabBar(

                      controller: tabController,
                      tabs: [
                        Tab(text: "Part 1",),
                        Tab(text: "Part 2",),
                        Tab(text: "Part 3",),
                      ],
                    ),
                  ),
                  Expanded(
                    child: TabBarView(
                      controller: tabController,
                      children: [
                        controller.test1.isEmpty ? const Center(child: Text("No Test Available"),) :
                        ListView.builder(
                            itemCount: controller.test1.length,
                            padding: EdgeInsets.all(8.w),
                            itemBuilder: (context, index)
                                {
                                  return TestCard(index: index + 1, test : controller.test1[index]);
                                }
                        ),
                        controller.test2.isEmpty ? const Center(child: Text("No Test Available"),) :
                        ListView.builder(
                            itemCount: controller.test2.length,
                            padding: EdgeInsets.all(8.w),
                            itemBuilder: (context, index)
                            {
                              return TestCard(index: index + 1 + (controller.test1.length), test : controller.test2[index]);
                            }
                        ),
                        controller.test3.isEmpty ? const Center(child: Text("No Test Available"),) :
                        ListView.builder(
                            itemCount: controller.test3.length,
                            padding: EdgeInsets.all(8.w),
                            itemBuilder: (context, index)
                            {
                              return TestCard(index: index + 1 + controller.test2.length + controller.test1.length, test : controller.test3[index]);
                            }
                        ),
                      ],
                    ),
                  ),
                ],
              );
            }
          ),
        );
      }
    );
  }
}
