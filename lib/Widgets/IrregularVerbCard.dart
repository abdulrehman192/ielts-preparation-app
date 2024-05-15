import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:ielts_app/Constants/AppAssets.dart';
import 'package:ielts_app/Controllers/ProverbIdiomController.dart';
import 'package:ielts_app/Controllers/ReadingController.dart';
import 'package:ielts_app/Models/WordModel.dart';
import 'package:ielts_app/Views/IrregularDetailsView.dart';

import '../Models/IrregularVerb.dart';

class IrregularVerbCard extends StatelessWidget {
  final IrregularVerb verb;
  final bool isSearch;
  const IrregularVerbCard({Key? key, required this.verb, required this.isSearch}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.symmetric(vertical: 5.h),
      child: InkWell(
        onTap: (){
          Get.to(() => IrregularDetailsView(verb: verb,));
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
                    SvgPicture.asset(AppAssets.bookReadingIcon, width: 40.w,semanticsLabel: 'A sample SVG',),
                    SizedBox(width: 8.w,),
                    Expanded(child: Text("${verb.verb}" , style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15.sp),)),
                    IconButton(
                        onPressed: ()async{
                          ReadingController con = Get.find();
                          con.toggleVerbFavorite(verb, isSearch: isSearch, );
                        },
                        splashRadius: 20,
                        icon:  Icon(verb.favorite == true ? Icons.favorite : Icons.favorite_outline, color: Colors.red,)
                    )
                ],
              ),
          ),
        ),
      ),
    );
  }
}
