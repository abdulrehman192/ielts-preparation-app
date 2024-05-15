
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ielts_app/Constants/AppColors.dart';

class ItemCard extends StatelessWidget {
  final String imageText;
  final String title;
  final Color? imageBackgroundColor;
  final Function() onTap;
  const ItemCard({Key? key, required this.imageText, required this.title, this.imageBackgroundColor, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.symmetric(vertical: 5.h),
      child: InkWell(
        onTap: onTap,
        child: Ink(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.w),
              color: Colors.white,
              boxShadow:  [
                BoxShadow(
                    blurRadius: 1.0,
                    spreadRadius: 1.0,
                    color: Colors.grey.shade200
                )
              ]
          ),
          child: Container(
            width: 1.sw,
            height: 70.h,
            padding: EdgeInsets.symmetric(horizontal: 12.w),
            margin: EdgeInsets.symmetric(vertical: 6.h),

            child: Row(
              children: [
                CircleAvatar(
                  radius: 20.w,
                  backgroundColor: imageBackgroundColor ?? AppColors.primaryColor,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SizedBox(width: 4.w,),
                      CircleAvatar(
                        radius: 1.w,
                        backgroundColor: Colors.white,
                      ),
                      Expanded(child: Text(imageText, style:  TextStyle(fontFamily: "Gabriola", fontSize: 0.35.sw / (imageText.length + 5.5)  , color: Colors.white), textAlign: TextAlign.center,)),
                      CircleAvatar(
                        radius: 1.w,
                        backgroundColor: Colors.white,
                      ),
                      SizedBox(width: 4.w,),
                    ],
                  ),
                ),
                SizedBox(width: 12.w,),
                Expanded(
                    child: Text(title, style: TextStyle(fontSize: 14.w),)
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
