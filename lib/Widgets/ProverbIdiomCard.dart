import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:ielts_app/Constants/AppAssets.dart';
import 'package:ielts_app/Constants/AppColors.dart';
import 'package:ielts_app/Controllers/ProverbIdiomController.dart';
import 'package:ielts_app/Models/ProverIdiomModel.dart';

import '../Controllers/TextToSpeechController.dart';

class ProverbIdiomCard extends StatelessWidget {
  final ProverbIdiom item;
  final bool isSearch;
  const ProverbIdiomCard({Key? key, required this.item, required this.isSearch}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.symmetric(vertical: 5.h),
      child: InkWell(
        onTap: (){
          _showBottomSheet(context);
        },
        child: Ink(
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8.w),
              boxShadow: [
                BoxShadow(
                    blurRadius: 1.0,
                    spreadRadius: 1.0,
                    color: Colors.grey.shade200
                )
              ]
          ),
          child: Container(
            width: 1.sw,
            padding: EdgeInsets.all(8.w),
            child: Row(
              children: [
                GetBuilder<TextToSpeechController>(
                    builder: (speech) {
                      return IconButton(
                          onPressed: ()async{
                            await speech.textToSpeechUS(item.title.toString());
                          },
                          splashRadius: 20,
                          icon:  Icon(Icons.volume_up, color: AppColors.primaryColor,)
                      );
                    }
                ),
                SizedBox(
                  width: 3.w,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("${item.title}", style: TextStyle(fontSize: 16.sp, color: AppColors.primaryColor),),
                      Text("${item.description}", style: TextStyle(fontSize: 14.sp,),),
                    ],
                  ),
                ),
                IconButton(
                    onPressed: (){
                      ProverbIdiomController w = Get.find();
                      w.toggleFavorite(item, isSearch: isSearch);
                    },
                    splashRadius: 20,
                    icon:  Icon(item.favorite == true ? Icons.favorite : Icons.favorite_outline, color: Colors.red,)
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _showBottomSheet(BuildContext context)
  {
    showBottomSheet(
        context: context,
        builder: (context)
        {
          return Container(
            width: 1.sw,
            padding: EdgeInsets.all(8.w),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Align(
                  alignment: Alignment.centerRight,
                  child: GestureDetector(
                    onTap: ()async{
                      TextToSpeechController speech = Get.find();
                      await speech.stopSpeech();
                      Get.back();
                    },
                    child: Container(
                      width: 30.w,
                      height: 30.h,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5.w),
                          color: Colors.purple.shade50
                      ),
                      child: const Icon(Icons.cancel, color: Colors.grey,),
                    ),
                  ),
                ),
                Text("${item.type == "Proverbs" ? "Proverb" : "Idiom"}:", style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w700),),
                Text("${item.title}", style: TextStyle(fontSize: 14.sp, ),),
                SizedBox(height: 10.h,),
                Text("Definition:", style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w700),),
                Text("${item.description}", style: TextStyle(fontSize: 14.sp, ),),
                SizedBox(height: 10.h,),
              ],
            ),
          );
        }
    );
  }
}
