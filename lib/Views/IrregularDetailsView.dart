import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ielts_app/Models/IrregularVerb.dart';

import '../Constants/AppColors.dart';

class IrregularDetailsView extends StatelessWidget {
  final IrregularVerb verb;
  const IrregularDetailsView({Key? key, required this.verb}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Irregular Verb Details"),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(8.w),
        child: Container(
          padding: EdgeInsets.all(8.w),
          decoration: BoxDecoration(
            border: Border.all(color: AppColors.primaryColor, width: 5.w, style: BorderStyle.solid),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RichText(
                text: TextSpan(
                  text: 'Verb: ',
                  style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black, fontSize: 16.sp),
                  children: <TextSpan>[
                    TextSpan(
                        text: '${verb.verb}',
                        style: TextStyle(fontWeight: FontWeight.normal, )
                    ),
                  ],
                ),
              ),
              SizedBox(height: 3.h,),
              Center(child: Text("-----", style: TextStyle(fontSize: 16.sp),),),
              SizedBox(height: 3.h,),
              RichText(
                text: TextSpan(
                  text: 'Past Simple: ',
                  style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black, fontSize: 16.sp),
                  children: <TextSpan>[
                    TextSpan(
                        text: '${verb.pastSimple}',
                        style: TextStyle(fontWeight: FontWeight.normal, )
                    ),
                  ],
                ),
              ),
              SizedBox(height: 3.h,),
              Center(child: Text("-----", style: TextStyle(fontSize: 16.sp),),),
              SizedBox(height: 3.h,),
              RichText(
                text: TextSpan(
                  text: 'Past Part: ',
                  style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black, fontSize: 16.sp),
                  children: <TextSpan>[
                    TextSpan(
                        text: '${verb.pastPart}',
                        style: TextStyle(fontWeight: FontWeight.normal, )
                    ),
                  ],
                ),
              ),
              SizedBox(height: 3.h,),
              Center(child: Text("-----", style: TextStyle(fontSize: 16.sp),),),
              SizedBox(height: 3.h,),
              RichText(
                text: TextSpan(
                  text: '3rd Person: ',
                  style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black, fontSize: 16.sp),
                  children: <TextSpan>[
                    TextSpan(
                        text: '${verb.thirdPerson}',
                        style: TextStyle(fontWeight: FontWeight.normal, )
                    ),
                  ],
                ),
              ),
              SizedBox(height: 3.h,),
              Center(child: Text("-----", style: TextStyle(fontSize: 16.sp),),),
              SizedBox(height: 3.h,),
              RichText(
                text: TextSpan(
                  text: 'Gerund: ',
                  style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black, fontSize: 16.sp),
                  children: <TextSpan>[
                    TextSpan(
                        text: '${verb.gerund}',
                        style: TextStyle(fontWeight: FontWeight.normal, )
                    ),
                  ],
                ),
              ),
              SizedBox(height: 3.h,),
              Center(child: Text("-----", style: TextStyle(fontSize: 16.sp),),),
              SizedBox(height: 3.h,),
              RichText(
                text: TextSpan(
                  text: 'Definition: ',
                  style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black, fontSize: 16.sp),
                  children: <TextSpan>[
                    TextSpan(
                        text: '${verb.definition}',
                        style: TextStyle(fontWeight: FontWeight.normal, )
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
