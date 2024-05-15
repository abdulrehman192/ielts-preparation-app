import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ielts_app/Models/YouTubeVideo.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';


class YouTubeVideoPlayerWidget extends StatefulWidget {
  final YouTubeVideo video;

  YouTubeVideoPlayerWidget({required this.video});

  @override
  _YouTubeVideoPlayerWidgetState createState() => _YouTubeVideoPlayerWidgetState();
}

class _YouTubeVideoPlayerWidgetState extends State<YouTubeVideoPlayerWidget> {
  late YoutubePlayerController _controller;
  String? videoId;
  @override
  void initState() {
    super.initState();
    videoId = YoutubePlayer.convertUrlToId(widget.video.videoUrl);
    _controller = YoutubePlayerController(
      initialVideoId: videoId.toString(),
      flags: YoutubePlayerFlags(
        autoPlay: false,
        mute: false,
        showLiveFullscreenButton: false
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    return OrientationBuilder(
      builder: (context, orientation) {
        bool isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;
        return Container(
          padding:  EdgeInsets.symmetric(vertical: 8.h),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AspectRatio(
                aspectRatio: isPortrait ? 16/9 : 16 / 7,
                child: YoutubePlayer(
                  controller: _controller,
                  aspectRatio : isPortrait ? 16/9 : 16 / 7,
                  showVideoProgressIndicator: true,
                  onReady: () {
                    print('Player is ready.');
                  },
                  onEnded: (meta)
                  {
                    print("data : ${meta.title}");
                  },
                ),
              ),
              Padding(
                padding:  EdgeInsets.symmetric(horizontal: 8.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 5.h,),
                    Text(widget.video.videoTitle, style: TextStyle(fontSize: 14.sp ,fontWeight: FontWeight.bold),)
                  ],
                ),
              )
            ],
          ),
        );
      }
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}