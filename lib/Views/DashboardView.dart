import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:ielts_app/Constants/AppAssets.dart';
import 'package:ielts_app/Controllers/DashboardController.dart';
import 'package:ielts_app/Controllers/NotificationController.dart';
import 'package:ielts_app/Controllers/TestController.dart';
import 'package:ielts_app/Utils/CommonFunctions.dart';
import 'package:url_launcher/url_launcher.dart';

import '../Constants/AppColors.dart';
import '../Controllers/ProverbIdiomController.dart';
import '../Controllers/ReadingController.dart';
import '../Controllers/TipsController.dart';
import '../Controllers/WordsController.dart';

class DashboardView extends StatefulWidget {
  const DashboardView({Key? key}) : super(key: key);

  @override
  State<DashboardView> createState() => _DashboardViewState();
}

class _DashboardViewState extends State<DashboardView> with SingleTickerProviderStateMixin{



  @override
  void initState() {
    Get.put(WordsController(), permanent: true);
    Get.put(ProverbIdiomController(), permanent: true);
    Get.put(ReadingController(), permanent: true);
    Get.put(TipsAndFAQController(), permanent: true);
    Get.put(TestController(), permanent: true);
    DashboardController controller = Get.find();
    controller.tabController = TabController(length: 7, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Get.put(NotificationController(), permanent: true);

    return GetBuilder<AppColors>(
      builder: (color) {
        return GetBuilder<DashboardController>(
          builder: (controller) {

            return Scaffold(
              backgroundColor: Colors.white,
              appBar: AppBar(
                title: const Text("IELTS Preparation"),
                actions: [
                  GetBuilder<AppColors>(
                    builder: (color) {
                      return IconButton(
                          onPressed: (){
                            color.toggleThemeColor();
                          },
                          splashRadius: 20,
                          icon: const Icon(Icons.brightness_4)
                      );
                    }
                  ),
                  PopupMenuButton(
                      icon: const Icon(Icons.more_vert),
                      splashRadius: 20,
                      onSelected: (val)async
                      {
                        if(val == 'rate')
                          {
                            CommonFunctions.rateApp();
                          }
                        else if(val == 'share')
                          {
                            CommonFunctions.shareText("https://play.google.com/store/apps/details?id=com.streamlogic.ielts_app");
                          }

                      },
                      itemBuilder: (context)
                          {
                            return [
                              PopupMenuItem(
                                  value: 'rate',
                                  child: _menuItem(icon: 'R', title: 'Help Us! Rate 5 Stars')
                              ),
                              PopupMenuItem(
                                  value: 'share',
                                  child: _menuItem(icon: 'S', title: 'Share App With Friends')
                              ),

                            ];
                          }
                  )
                ],
                bottom: TabBar(
                  isScrollable: true,
                  controller: controller.tabController,
                  tabs: const [
                    Tab(text: "DASHBOARD",),
                    Tab(text: "VOCABULARY",),
                    Tab(text: "LISTENING",),
                    Tab(text: "READING",),
                    Tab(text: "WRITING",),
                    Tab(text: "SPEAKING",),
                    Tab(text: "QUIZ",),
                  ],
                ),
              ),
              drawer:  Drawer(
                backgroundColor: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      SizedBox(height: 30.h,),
                      Container(
                        // width: 150.w,
                        height: 100.h,
                        padding: EdgeInsets.all(12.w),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.w),
                          color: AppColors.primaryColor
                        ),
                        child: Text("IELTS Preparations", style: TextStyle(fontSize: 28.sp, fontWeight: FontWeight.w600, color: Colors.white), textAlign: TextAlign.center,),
                      ),
                      SizedBox(height: 10.h,),
                      // _drawerButton(
                      //     icon: AppAssets.upgradeIcon,
                      //     text: "Upgrade Version",
                      //     onTap: (){
                      //
                      //     }
                      // ),
                      _drawerButton(
                          icon: AppAssets.dictionaryIcon,
                          text: "Online Dictionary",
                          onTap: ()async{
                            await launchUrl(Uri.parse("https://dictionary.cambridge.org/dictionary/"), mode: LaunchMode.externalApplication);
                          }
                      ),


                      // _drawerButton(
                      //     icon: AppAssets.feedbackIcon,
                      //     text: "Send Feedback",
                      //     onTap: (){
                      //
                      //     }
                      // ),

                      _drawerButton(
                          icon: AppAssets.rateUsIcon,
                          text: "Help Us! Rate 5 Star",
                          onTap: ()async{
                            await CommonFunctions.rateApp();
                          }
                      ),
                      _drawerButton(
                          icon: AppAssets.shareIcon,
                          text: "Share App",
                          onTap: ()async{
                           await CommonFunctions.shareText("https://play.google.com/store/apps/details?id=com.streamlogic.ielts_app");
                          }
                      ),

                      _drawerButton(
                          icon: AppAssets.appsIcon,
                          text: "Other Apps",
                          onTap: ()async{
                            await launchUrl(Uri.parse("https://play.google.com/store/apps/developer?id=StreamLogicPk"), mode: LaunchMode.externalApplication);
                          }
                      ),

                    ],
                  ),
                ),
              ),
              body: GetBuilder<DashboardController>(
                builder: (controller)
                {
                  return TabBarView(
                      controller: controller.tabController,
                      children: controller.pages
                  );
                },
              ),
            );
          }
        );
      }
    );
  }
  Widget _menuItem({required String icon, required String title})
  {
    return Row(
      children: [
        Container(
          width: 25.w,
          height: 25.w,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5.w),
            color: Colors.red
          ),
          child: Text(icon, style: const TextStyle(color: Colors.white),),
        ),
        SizedBox(width: 8.w,),
        Text(title, )
      ],
    );
  }


  Widget _drawerButton({required String icon, required String text, required Function() onTap})
  {
    return ListTile(
      leading: SvgPicture.asset(icon, width: 25.w, height: 25.w,),
      title: Text(text, style: TextStyle(fontSize: 14.sp),),
      onTap: onTap,
    );
  }
}
