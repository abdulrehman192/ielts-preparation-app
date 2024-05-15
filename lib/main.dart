import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:ielts_app/Controllers/CalculatorController.dart';
import 'package:ielts_app/Controllers/DashboardController.dart';
import 'package:ielts_app/Controllers/ListeningController.dart';
import 'package:ielts_app/Controllers/NotificationController.dart';
import 'package:ielts_app/Controllers/ReadingController.dart';
import 'package:ielts_app/Controllers/ProverbIdiomController.dart';
import 'package:ielts_app/Controllers/SpeakingController.dart';
import 'package:ielts_app/Controllers/TestController.dart';
import 'package:ielts_app/Controllers/TipsController.dart';
import 'package:ielts_app/Controllers/WordsController.dart';
import 'package:ielts_app/Controllers/WritingController.dart';
import 'package:ielts_app/Views/SplashView.dart';
import 'Constants/AppColors.dart';
import 'Controllers/TextToSpeechController.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();

  Get.put(NotificationController(), permanent: true);
  Get.put(AppColors(), permanent: true);

  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      systemNavigationBarColor: Colors.transparent,
      systemNavigationBarIconBrightness: Brightness.dark
    )
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(300, 670),
      splitScreenMode: true,
      minTextAdapt: true,
      builder: (context, child) {
        return GetBuilder<AppColors>(
          builder: (color) {
            AppColors.primaryColor = color.isPurple ? Colors.purple : Colors.red;
            return GetMaterialApp(
              title: 'IELTS Preparation',
              debugShowCheckedModeBanner: false,
              initialBinding: InitialBindings(),
              theme: ThemeData(
                primarySwatch: color.isPurple ? Colors.purple : Colors.red,
              ),
              home: const SplashView(),
              builder: (context, child) {
                return MediaQuery(
                  data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
                  child: child!,
                );
              },
            );
          }
        );
      }
    );
  }
}


class InitialBindings implements Bindings
{
  @override
  void dependencies() {
    Get.lazyPut(() => DashboardController(), fenix: true);
    Get.lazyPut(() => WordsController(), fenix: true);
    Get.lazyPut(() => TextToSpeechController(), fenix: true);
    Get.lazyPut(() => ProverbIdiomController(), fenix: true);
    Get.lazyPut(() => ReadingController(), fenix: true);
    Get.lazyPut(() => ListeningController(), fenix: true);
    Get.lazyPut(() => NotificationController(), fenix: true);
    Get.lazyPut(() => SpeakingController(), fenix: true);
    Get.lazyPut(() => WritingController(), fenix: true);
    Get.lazyPut(() => TipsAndFAQController(), fenix: true);
    Get.lazyPut(() => CalculatorController(), fenix: true);
    Get.lazyPut(() => AppColors(), fenix: true);
    Get.lazyPut(() => TestController(), fenix: true);
  }

}