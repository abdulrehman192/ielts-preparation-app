import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:ielts_app/Constants/AppColors.dart';
import 'package:ielts_app/Controllers/TextToSpeechController.dart';
import 'package:ielts_app/Controllers/WordsController.dart';
import 'package:ielts_app/Models/WordModel.dart';
import 'package:ielts_app/Utils/CommonFunctions.dart';

class WordCard extends StatelessWidget {
  final Word word;
  final bool isSearch;
  final bool isImportant;
  const WordCard({Key? key, required this.word, required this.isSearch, required this.isImportant,}) : super(key: key);

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
            // height: 100.h,
            margin: EdgeInsets.symmetric(vertical: 6.h),
            padding: EdgeInsets.all(8.w),
            child: Row(
              children: [
                GetBuilder<TextToSpeechController>(
                  builder: (speech) {
                    return IconButton(
                        onPressed: ()async{
                          await speech.textToSpeechUS(word.word.toString());
                        },
                        splashRadius: 20,
                        icon:  Icon(Icons.volume_up, color: AppColors.primaryColor,)
                    );
                  }
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text("${word.word}", style: TextStyle(color: AppColors.primaryColor, fontWeight: FontWeight.w600, fontSize: 20.sp),),
                          SizedBox(width: 8.w,),
                          Text("(${word.type})", style: const TextStyle(fontWeight: FontWeight.w500),),
                        ],
                      ),
                      Text("${word.description}", overflow: TextOverflow.ellipsis, maxLines: 4,)
                    ],
                  ),
                ),
                IconButton(
                    onPressed: (){
                      WordsController w = Get.find();
                      w.toggleFavorite(word, isImportant: isImportant, isSearch: isSearch);
                    },
                    splashRadius: 20,
                    icon:  Icon(word.favorite == true ? Icons.favorite : Icons.favorite_outline, color: Colors.red,)
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
        elevation: 10.0,
        builder: (context)
        {
          return Container(
            width: 1.sw,
            // height: 0.80.sh,
            padding: EdgeInsets.all(8.w),
            color: Colors.white,
            child: SingleChildScrollView(
              child: GetBuilder<TextToSpeechController>(
                builder: (speech) {
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Align(
                        alignment: Alignment.centerRight,
                        child: GestureDetector(
                          onTap: ()async{
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
                      SizedBox(height: 5.h,),
                      Text("${word.word} (${word.type})", style: TextStyle(color: AppColors.primaryColor, fontWeight: FontWeight.w600, fontSize: 24.sp),),
                      SizedBox(height: 8.h,),
                      Icon(Icons.g_translate, color: AppColors.primaryColor,),
                      SizedBox(height: 8.h,),
                      Text("---------------------------------", style: TextStyle(color: AppColors.primaryColor, fontWeight: FontWeight.w600, fontSize: 24.sp),),
                      Align(
                        alignment: Alignment.centerLeft,
                          child: Text("Definition:", style: TextStyle(fontSize: 18.sp, ),),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(child: Text("${word.description}", style: TextStyle(fontSize: 18.sp, ),)),
                          const Icon(Icons.g_translate,)

                        ],
                      ),
                      SizedBox(height: 8.h,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _outlineButton(
                              text: "US",
                              onTap: ()async{
                                await speech.textToSpeechUS(word.word.toString());
                                Future.delayed(const Duration(milliseconds: 1200), ()async{
                                  await speech.textToSpeechUS(word.description.toString());
                                });
                              }
                          ),
                          _outlineButton(
                              text: "UK",
                              onTap: ()async{
                                await speech.textToSpeechUK(word.word.toString());
                                Future.delayed(const Duration(milliseconds: 1200), ()async{
                                  await speech.textToSpeechUK(word.description.toString());
                                });
                              }
                          ),
                        ],
                      ),
                      SizedBox(height: 8.h,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: 0.45.sw,
                            height: 45.h,
                            child: ElevatedButton(
                              onPressed: ()async{
                                String text = "${word.word}\n\nType:${word.type}\n\nDefinition: ${word.description}";
                                await CommonFunctions.shareText(text);
                              },
                              style: const ButtonStyle(
                                backgroundColor: MaterialStatePropertyAll(Colors.red)
                              ),
                              child: Text("Share", style: TextStyle(fontSize: 22.sp),),
                            ),
                          ) ,
                          SizedBox(
                            width: 0.45.sw,
                            height: 45.h,
                            child: ElevatedButton(
                              onPressed: ()async{
                                await CommonFunctions.copyToClipboard(word.word.toString());
                              },
                              child: Text("Copy", style: TextStyle(fontSize: 22.sp),),
                            ),
                          ) ,
                        ],
                      )
                    ],
                  );
                }
              ),
            ),
          );
        }
    );
  }

  Widget _outlineButton({ required String text, required Function() onTap})
  {
    return SizedBox(
      width: 0.45.sw,
      height: 45.h,
      child: OutlinedButton(
          onPressed: onTap,
          style: ButtonStyle(
            side: MaterialStatePropertyAll(BorderSide(color: AppColors.primaryColor))
          ),
          child:Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(Icons.volume_up, color: Colors.red, size: 25.w,),
              Text(text, style: TextStyle(color: Colors.red, fontSize: 22.sp),),
              const SizedBox()
            ],
          )
      ),
    );
  }
}
