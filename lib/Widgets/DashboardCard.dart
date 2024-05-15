
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DashboardCard extends StatelessWidget {
  final String imageUrl;
  final String title;
  final Function() onTap;
  const DashboardCard({Key? key, required this.imageUrl, required this.title, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Ink(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.w),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                  color: Colors.grey.shade200,
                  blurRadius: 1,
                  spreadRadius: 1
              )
            ]
        ),
        child: Container(
          width: 0.45.sw,
          height: 0.45.sw,
          alignment: Alignment.center,
          padding: EdgeInsets.all(12.w),
          // decoration: BoxDecoration(
          //   borderRadius: BorderRadius.circular(8.w),
          //   color: Colors.transparent
          // ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Image.asset(imageUrl, height: 0.20.sw,),
              Text(title, style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18.w,), textAlign: TextAlign.center,)
            ],
          ),
        ),
      ),
    );
  }
}
