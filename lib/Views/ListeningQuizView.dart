import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:ielts_app/Controllers/ListeningController.dart';
import 'package:ielts_app/Models/ListeningLesson.dart';
import 'package:ielts_app/Utils/CommonFunctions.dart';
import 'package:ielts_app/Widgets/QuestionCard.dart';

class ListeningQuizView extends StatelessWidget {
  final String title;
  final ListeningLesson lesson;
  const ListeningQuizView({Key? key, required this.title, required this.lesson}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("$title Quiz"),
      ),
      body: GetBuilder<ListeningController>(
        builder: (controller) {
          return ListView.builder(
              itemCount: controller.answeredQuestions.length,
              itemBuilder: (context, index)
                  {
                    return QuestionCard(
                      index: index,
                      question: controller.answeredQuestions[index],
                    );
                  }
          );
        }
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          ListeningController listen = Get.find();
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
                                  text: '${listen.getResult(lesson)}/${listen.answeredQuestions.length} Questions',
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
        child: const Icon(Icons.check_circle),
      ),

    );
  }
}
