import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:ielts_app/Controllers/CalculatorController.dart';
import 'package:ielts_app/Widgets/DropDownCard.dart';

class CalculatorView extends StatelessWidget {
  const CalculatorView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("IELTS Band Calculator"),
      ),
      body: GetBuilder<CalculatorController>(
        builder: (controller)
        {
          return ListView(
            padding: EdgeInsets.all(8.w),
            children: [
              DropDownCard(
                  label: "Select Listening Band",
                  selectedValue: controller.listeningBandValue,
                  items: controller.listeningItems,
                  onChanged: (val)
                    {
                      if(val != null)
                        {
                          controller.listeningBandValue = val;
                        }
                    },
              ),
              DropDownCard(
                  label: "Select Reading Band",
                  selectedValue: controller.readingBandValue,
                  items: controller.readingItems,
                  onChanged: (val)
                    {
                      if(val != null)
                        {
                          controller.readingBandValue = val;
                        }
                    },
              ),
              DropDownCard(
                  label: "Select Writing Band",
                  selectedValue: controller.writingBandValue,
                  items: controller.writingItems,
                  onChanged: (val)
                    {
                      if(val != null)
                        {
                          controller.writingBandValue = val;
                        }
                    },
              ),
              DropDownCard(
                  label: "Select Speaking Band",
                  selectedValue: controller.speakingBandValue,
                  items: controller.speakingItems,
                  onChanged: (val)
                    {
                      if(val != null)
                        {
                          controller.speakingBandValue = val;
                        }
                    },
              ),
              SizedBox(height: 5.h,),
              ElevatedButton(
                  onPressed: (){
                    controller.calculateBands();
                  },
                  child: const Text("Calculate BANDS")
              ),
              SizedBox(height: 10.h,),
              controller.result == 0 ? const SizedBox()  :
              Center(child: Text("Your Band is : ${controller.result.toStringAsFixed(1)}", style: TextStyle(fontSize: 17.sp,fontWeight: FontWeight.bold),))
            ],
          );
        },
      ),
    );
  }
}
