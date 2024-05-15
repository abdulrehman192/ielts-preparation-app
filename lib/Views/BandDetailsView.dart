import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ielts_app/Constants/AppAssets.dart';

import '../Models/BandModel.dart';

class BandDetailsView extends StatelessWidget {
  final Band band;
  const BandDetailsView({super.key, required this.band});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Band Scores"),
      ),
      body: ListView(
        padding: EdgeInsets.all(8.w),
        children: [
          Row(
            children: [
              SvgPicture.asset(AppAssets.awardIcon, color: Colors.amber.shade400,),
              SizedBox(width: 5.w,),
              Text("Pronunciation", style: TextStyle(fontSize: 17.sp, fontWeight: FontWeight.bold),)
            ],
          ),
          SizedBox(height: 10.w,),
          Text("${band.pronunciation}", style: TextStyle(fontSize: 14.sp),),
          SizedBox(height: 10.h,),
          Row(
            children: [
              SvgPicture.asset(AppAssets.awardIcon, color: Colors.amber.shade400,),
              SizedBox(width: 5.w,),
              Text("Grammatical range and accuracy", style: TextStyle(fontSize: 17.sp, fontWeight: FontWeight.bold),)
            ],
          ),
          SizedBox(height: 10.w,),
          Text("${band.grammaticalRange}", style: TextStyle(fontSize: 14.sp),),
          SizedBox(height: 10.h,),
          Row(
            children: [
              SvgPicture.asset(AppAssets.awardIcon, color: Colors.amber.shade400,),
              SizedBox(width: 5.w,),
              Text("Lexical resource", style: TextStyle(fontSize: 17.sp, fontWeight: FontWeight.bold),)
            ],
          ),
          SizedBox(height: 8.w,),
          Text("${band.lexicalResource}", style: TextStyle(fontSize: 14.sp),),
          SizedBox(height: 10.h,),
          Row(
            children: [
              SvgPicture.asset(AppAssets.awardIcon, color: Colors.amber.shade400,),
              SizedBox(width: 5.w,),
              Text("Fluency and coherence", style: TextStyle(fontSize: 17.sp, fontWeight: FontWeight.bold),)
            ],
          ),
          SizedBox(height: 8.w,),
          Text("${band.fluencyAndCoherence}", style: TextStyle(fontSize: 14.sp),),
          SizedBox(height: 10.h,),
        ],
      ),
    );
  }
}
