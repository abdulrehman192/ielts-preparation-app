import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:ielts_app/Constants/AppColors.dart';
import 'package:ielts_app/Widgets/QuizItemCard.dart';

class QuizView extends StatelessWidget {
  const QuizView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AppColors>(
      builder: (color) {
        return Scaffold(
          backgroundColor: Colors.white,
          body: ListView(
            padding: EdgeInsets.all(15.w),
            children: [
              Text("Confusing Word Quizzes", style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20.w),),
              SizedBox(height: 10.h,),
              SizedBox(
                height: 130.h,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: 10,
                  separatorBuilder: (context, index) => SizedBox(width: 6.w,),
                  itemBuilder: (context, index) {
                    return QuizItemCard(
                      title: "Confusing Word Quiz ${index + 1}",
                    );
                  },
                ),
              ),
              SizedBox(height: 10.h,),
              Text("Synonyms Quizzes", style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20.w),),
              SizedBox(height: 10.h,),
              SizedBox(
                height: 130.h,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: 10,
                  separatorBuilder: (context, index) => SizedBox(width: 6.w,),
                  itemBuilder: (context, index) {
                    return QuizItemCard(
                      title: "Synonym Test ${index + 1}",
                    );
                  },
                ),
              ),
              SizedBox(height: 10.h,),
              Text("Spelling Quizzes", style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20.w),),
              SizedBox(height: 10.h,),
              SizedBox(
                height: 130.h,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: 10,
                  separatorBuilder: (context, index) => SizedBox(width: 6.w,),
                  itemBuilder: (context, index) {
                    return QuizItemCard(
                      title: "Spelling Quiz ${index + 1}",
                    );
                  },
                ),
              ),
              SizedBox(height: 10.h,),
            ],
          ),
        );
      }
    );
  }
}
