import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ielts_app/Models/FAQModel.dart';

class FAQDetailsView extends StatelessWidget {
  final  FAQ faq;
  const FAQDetailsView({super.key, required this.faq});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("FAQ's Details"),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(8.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("${faq.question}", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15.sp),),
            SizedBox(height: 10.h,),
            Center(
              child: Text("-----Answer-----", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey.shade700, fontSize: 14.sp),),

            ),
            SizedBox(height: 10.h,),
            Text("${faq.answer}", style: TextStyle(fontSize: 14.sp),)
          ],
        ),
      ),
    );
  }
}
