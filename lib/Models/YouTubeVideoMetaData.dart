class YouTubeVideoMetaData {
  final String title;
  final String channelName;
  final String description;
  final int viewCount;
  final int likeCount;
  final int dislikeCount;
  final String thumbnailUrl;
  final Duration duration;
  final bool isLive;

  YouTubeVideoMetaData({
    required this.title,
    required this.channelName,
    required this.description,
    required this.viewCount,
    required this.likeCount,
    required this.dislikeCount,
    required this.thumbnailUrl,
    required this.duration,
    required this.isLive
  });
}