import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:ielts_app/Controllers/TestController.dart';
import 'package:ielts_app/Models/ListeningQuestion.dart';
import 'package:ielts_app/Widgets/QuestionCard.dart';

import '../Models/Test.dart';
import '../Utils/CommonFunctions.dart';
import '../Widgets/TestQuestionCard.dart';

class TestDetailsView extends StatelessWidget {
  final String title;
  final Test test;
  const TestDetailsView({super.key, required this.title, required this.test});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title),
            Text("Questions: ${test.questions!.length}", style: TextStyle(fontSize: 10.sp, color: Colors.white70),),

          ],
        ),
        actions: [
          // IconButton(
          //     onPressed: (){
          //
          //     },
          //     splashRadius: 20,
          //     icon: const Icon(Icons.playlist_add_check)
          // )
        ],
      ),
      body: GetBuilder<TestController>(
        builder: (controller) {
          return ListView.builder(
            padding: EdgeInsets.all(8.w),
            itemBuilder: (context, index){
              return TestQuestionCard(question: controller.answeredQuestions[index], index: index, test : test);
            },
            itemCount: controller.answeredQuestions.length,
          );
        }
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: ()async{
          TestController listen = Get.find();
          if(listen.isAllQuestionsAnswered())
          {

            Get.defaultDialog(
                title: "Test Result",
                content: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: RichText(
                        text: TextSpan(
                          text: 'Your Scores: ',
                          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black, fontSize: 16.sp),
                          children: <TextSpan>[
                            TextSpan(
                                text: '${listen.getResult(test)}/${listen.answeredQuestions.length} Questions',
                                style: TextStyle(fontWeight: FontWeight.normal, )
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 20.h,),
                    TextButton(
                        onPressed: (){
                          listen.tryAgain();
                          Get.back();
                        },
                        child: const Text("TRY AGAIN")
                    ),
                    TextButton(
                        onPressed: (){
                          Get.back();
                        },
                        child: const Text("CANCEL")
                    ),
                  ],
                )
            );
          }
          else
          {
            CommonFunctions.showSnackBar("Not Answered", "Please answered all questions to view results");
          }
        },
        child: const Icon(Icons.copy),
      ),
    );
  }
}
