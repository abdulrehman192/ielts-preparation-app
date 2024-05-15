import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:ielts_app/Views/StoryOrEssayView.dart';

import '../Constants/AppAssets.dart';
import '../Controllers/ReadingController.dart';
import '../Models/EssayModel.dart';

class EssayCard extends StatelessWidget {
  final Essay essay;
  final bool isStory;
  final bool isEssay;
  final bool isArticle;
  final bool isSearch;
  const EssayCard({Key? key, required this.essay, required this.isStory, required this.isSearch, required this.isEssay, required this.isArticle}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.symmetric(vertical: 5.h),
      child: InkWell(
        onTap: (){
          Get.to(() => StoryOrEssayView(essay: essay, isArticle: isArticle,));
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
            padding: EdgeInsets.all(8.w),
            width: 1.sw,
            child: Row(
              children: [
                SvgPicture.asset(AppAssets.bookReadingIcon, width: 40.w,),
                SizedBox(width: 8.w,),
                Expanded(child: Text("${essay.title}" , style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15.sp),)),
                IconButton(
                    onPressed: ()async{
                      ReadingController con = Get.find();
                      con.toggleEssayOrStoryFavorite(essay, isSearch: isSearch, isStory: isStory, isEssay: isEssay, isArticle: isArticle);
                    },
                    splashRadius: 20,
                    icon:  Icon(essay.favorite == true ? Icons.favorite : Icons.favorite_outline, color: Colors.red,)
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
