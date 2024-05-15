import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class QuizItemCard extends StatelessWidget {
  final String title;
  const QuizItemCard({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 0.30.sw,
      height: 120.h,
      padding: EdgeInsets.all(5.w),
      margin: EdgeInsets.all(1.w),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.w),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade200,
            blurRadius: 1.0,
            spreadRadius: 1.0
          )
        ]
      ),
      child: Text(title, style: TextStyle(fontSize: 14.w, fontWeight: FontWeight.w600), textAlign: TextAlign.center,),
    );
  }
}
