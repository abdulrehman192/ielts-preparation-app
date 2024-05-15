import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:ielts_app/Models/BandModel.dart';
import 'package:ielts_app/Views/BandDetailsView.dart';

class BandCard extends StatelessWidget {
  final Band band;
  const BandCard({super.key, required this.band});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.symmetric(vertical: 5.h),
        child: InkWell(
          onTap: (){
            Get.to(() => BandDetailsView(band: band));
          },
          child: Ink(
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8.w),
                boxShadow: [
                  BoxShadow(
                      blurRadius: 1.0,
                      spreadRadius: 1.0,
                      color: Colors.grey.shade200
                  )
                ]
            ),
            child: Container(
              width: 1.sw,
              padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 15.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("${band.band}", style: TextStyle(fontWeight: FontWeight.bold),),
                  Icon(Icons.arrow_forward_ios, size: 15.w,)
                ],
              ),
            ),
          ),
        ),
    );
  }
}
