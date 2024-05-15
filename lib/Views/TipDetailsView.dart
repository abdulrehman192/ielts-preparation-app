import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../Models/TipModel.dart';

class TipDetailsView extends StatelessWidget {
  final Tip tip;
  const TipDetailsView({super.key, required this.tip});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Tip Details"),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(8.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("${tip.subTitle}", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15.sp),),
            SizedBox(height: 10.h,),
            Text("${tip.description}", style: TextStyle(fontSize: 14.sp),),
          ],
        ),
      ),
    );
  }
}
