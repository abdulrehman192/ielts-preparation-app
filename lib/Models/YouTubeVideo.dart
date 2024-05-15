class YouTubeVideo
{
  final String videoUrl;
  final String videoTitle;

  YouTubeVideo({required this.videoUrl, required this.videoTitle});

  factory YouTubeVideo.fromMap(Map data)
  {
    return YouTubeVideo(
        videoUrl: data['url'],
        videoTitle: data['title']
    );
  }
}