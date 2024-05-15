import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ielts_app/Constants/AppColors.dart';
import 'package:ielts_app/Models/EssayModel.dart';

class StoryOrEssayView extends StatelessWidget {
  final Essay essay;
  final bool isArticle;
  const StoryOrEssayView({Key? key, required this.essay, required this.isArticle}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(essay.title.toString()),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(8.w),
        child:  Container(
          padding: EdgeInsets.all(8.w),
          decoration: BoxDecoration(
            border: Border.all(color: AppColors.primaryColor, width: 5.w, style: BorderStyle.solid),
          ),
          child: Text(essay.data.toString(), style: TextStyle(fontSize: 15.sp), textAlign: TextAlign.start,),
        )
      ),
    );
  }
}
