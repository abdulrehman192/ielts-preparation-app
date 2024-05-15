import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ielts_app/Models/AmericanSlang.dart';

import '../Constants/AppColors.dart';

class SlangDetailsView extends StatelessWidget {
  final AmericanSlang slang;
  const SlangDetailsView({Key? key, required this.slang}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Slang Details"),
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
                  text: 'Slang: ',
                  style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black, fontSize: 16.sp),
                  children: <TextSpan>[
                    TextSpan(
                      text: '${slang.title}',
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
                        text: '${slang.description}',
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
                  text: 'Example: ',
                  style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black, fontSize: 16.sp),
                  children: <TextSpan>[
                    TextSpan(
                        text: '${slang.example}',
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
                  text: 'Etymology: ',
                  style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black, fontSize: 16.sp),
                  children: <TextSpan>[
                    TextSpan(
                        text: '${slang.etymology}',
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
                  text: 'Synonyms: ',
                  style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black, fontSize: 16.sp),
                  children: <TextSpan>[
                    TextSpan(
                        text: '${slang.synonyms}',
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
                  text: 'Antonyms: ',
                  style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black, fontSize: 16.sp),
                  children: <TextSpan>[
                    TextSpan(
                        text: '${slang.antonyms}',
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
