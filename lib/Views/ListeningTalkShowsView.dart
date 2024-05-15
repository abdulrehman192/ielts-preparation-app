import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:ielts_app/Utils/CommonFunctions.dart';
import 'package:ielts_app/Widgets/YouTubeVideoPlayerWidget.dart';

import '../Controllers/ListeningController.dart';

class ListeningTalkShowsView extends StatelessWidget {
  const ListeningTalkShowsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(
      builder: (context, orientation) {
        bool isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;
        return Scaffold(
          appBar: isPortrait ?
          AppBar(
            title: const Text("English TV Talk Shows"),
          ):
          PreferredSize(child: SizedBox(), preferredSize: Size(0,10.h),)
          ,
          body: GetBuilder<ListeningController>(
            builder: (controller)
            {
              return controller.videoUrls.isEmpty ? const Center(child: Text("No Talk Shows Available"),) :
                FutureBuilder(
                future: CommonFunctions.isConnectedToInternet(),
                builder: (context, AsyncSnapshot<bool> snapshot)
                {
                  if(!snapshot.hasData)
                    {
                      return Center(child: CircularProgressIndicator(),);
                    }
                  bool connected = snapshot.data ?? false;
                  if(connected)
                    {
                      return ListView.builder(
                        itemCount: controller.videoUrls.length,
                          itemBuilder: (context, index)
                              {
                                return YouTubeVideoPlayerWidget(video: controller.videoUrls[index]);
                              }
                      );
                    }
                  else{
                    return Center(
                      child: Text("No Internet Connection"),
                    );
                  }
                },
              );
            },
          ),
        );
      }
    );
  }
}
