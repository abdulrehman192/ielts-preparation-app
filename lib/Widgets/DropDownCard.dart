import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DropDownCard extends StatelessWidget {
  final String selectedValue;
  final List<String> items;
  final Function(String?) onChanged;
  final String label;
  const DropDownCard({super.key, required this.selectedValue, required this.items, required this.onChanged, required this.label});

  @override
  Widget build(BuildContext context) {
    return
      Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 5.h,),
          Text(label, style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey.shade700),),
          SizedBox(height: 8.h,),
          GestureDetector(
            onTapDown: (details)async{
              print(details.globalPosition.dy);
              await showMenu(
                context: context,
                position: RelativeRect.fromLTRB(30, details.globalPosition.dy, 20, 100),
                constraints: BoxConstraints(
                  minWidth: 0.88.sw
                ),
                items: items.map((e) {
                  return PopupMenuItem<String>(
                    value: e.toLowerCase(),
                    onTap: (){
                      onChanged(e);
                    },
                    child: Text(e),

                  );
                }
                ).toList(),
                elevation: 8.0,
              );
            },
            child: Container(
            width: 1.sw,
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 15.h),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8.w),
              boxShadow: [
                BoxShadow(
                  blurRadius: 2.0,
                  spreadRadius: 2.0,
                  color: Colors.grey.shade200
                )
              ]
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(selectedValue, style: TextStyle(fontWeight: FontWeight.bold),),
                const Icon(Icons.keyboard_arrow_down)
              ],
            )
    ),
          ),
          SizedBox(height: 5.h,),
        ],
      );
  }
}
