class AudioFile
{
  final int? id;
  final String? fileName;
  final int? seconds;
  final String? path;
  final DateTime? recordingDate;


  AudioFile({this.id, this.fileName, this.seconds, this.path, this.recordingDate});

  factory AudioFile.fromMap(Map data)
  {
    return AudioFile(
      id: data['id'],
      fileName: data['fileName'],
      seconds: data['seconds'],
      path: data['path'],
      recordingDate: data['recording_date'],
    );
  }
}