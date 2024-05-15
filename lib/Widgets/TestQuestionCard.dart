import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:ielts_app/Constants/AppColors.dart';
import 'package:ielts_app/Controllers/TestController.dart';
import 'package:ielts_app/Models/ListeningQuestion.dart';
import 'package:ielts_app/Models/Test.dart';

class TestQuestionCard extends StatelessWidget {
  final ListeningQuestion question;
  final int index;
  final Test test;
  const TestQuestionCard({Key? key, required this.question, required this.index, required this.test}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<TestController>(
      builder: (controller) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 1.sw,
              height: 80.h,
              padding: EdgeInsets.all(8.w),
              alignment: Alignment.centerLeft,

              decoration: BoxDecoration(
                  color: Colors.white,
                border : Border(
                  bottom: BorderSide(
                    color: Colors.grey,
                    width: 1.0,
                  ),
                )
              ),
              child: Text("${index + 1}. ${question.question}", style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16.sp, color: AppColors.primaryColor),),

            ),
            _optionCard(
                text: "${question.option1}",
                onSelect: (val)
                {

                },
              selectedValue: question.answer.toString()
            ),
            _optionCard(
                text: "${question.option2}",
                onSelect: (val)
                {

                },
                selectedValue: question.answer.toString()
            ),
            _optionCard(
                text: "${question.option3}",
                onSelect: (val)
                {

                },
                selectedValue: question.answer.toString()
            ),
            _optionCard(
                text: "${question.option4}",
                onSelect: (val)
                {

                },
                selectedValue: question.answer.toString()
            ),
          ],
        );
      }
    );
  }

  Widget _optionCard({required String text, required Function(String) onSelect, required String selectedValue})
  {
    return GetBuilder<TestController>(
      builder: (controller) {
        return Container(
          width: 1.sw,
          padding: EdgeInsets.all(5.w),
          decoration: BoxDecoration(
            color: controller.getAnswer(test, index) == text && controller.highlightAnswers ? Colors.green.shade200: Colors.grey.shade300,
            border : Border(
              bottom: BorderSide(
                color:  Colors.grey,
                width: 1.0,
              ),
            ),
          ),
          child: Row(
            children: [
              Radio(
                  fillColor: MaterialStatePropertyAll(AppColors.primaryColor),
                  value: text,
                  groupValue: selectedValue,
                  splashRadius: 20,
                  onChanged: (val){
                    controller.toggleAnswer(index, val.toString());
                    if(val == true)
                      {
                        onSelect(text);
                      }
                  }
              ),
              Expanded(child: Text(text, style: TextStyle(fontWeight: FontWeight.w500, fontSize: 12.sp),))
            ],
          ),
        );
      }
    );
  }
}
