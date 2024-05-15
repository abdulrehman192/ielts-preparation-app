import 'dart:async';
import 'dart:io';
import 'package:audioplayers/audioplayers.dart';
import 'package:get/get.dart';
import 'package:ielts_app/Services/SQLiteService.dart';
import 'package:path_provider/path_provider.dart';
import 'package:record/record.dart';
import '../Models/AudioFile.dart';
import '../Models/SpeakingModel.dart';

class SpeakingController extends GetxController
{
  final _db = SqliteService.instance;
  Timer _timer = Timer(Duration.zero, (){});
  final player = AudioPlayer();
  final record = Record();
  bool isPaused = false;
  bool isPlaying = false;
  bool isRecording = false;
  late File file;
  int seconds = 0;
  int playedSeconds = 0;
  int playingIndex = -1;
  String _fileName = "audio_recording.mp3";
  String _path = "";
  String _savedFilePath = "";
  List<Speaking> _lessons = [];
  List<AudioFile> _audioFiles = [];
  bool loading = false;

  List<Speaking> get lessons => _lessons;
  List<AudioFile> get audioFiles => _audioFiles;

  String get fileName => _fileName;
  String get savedFilePath => _savedFilePath;

  set fileName(String val)
  {
    _fileName = "$val";
    update();
  }


  @override
  void onInit()async {
    super.onInit();
    getLessons();
    _getAudioFiles();
   Directory appDocDir = await getApplicationDocumentsDirectory();
   _path = "${appDocDir.path}";
  }

  getLessons() async
  {
    loading = true;
    update();
    String query = "Select * from speaking";
    var data = await _db.getAllRows(query);
    _lessons = data.map((e) => Speaking.fromMap(e)).toList();
    loading = false;
    update();
  }

  toggleLessonFavorite(Speaking speaking) async
  {
    int index = _lessons.indexOf(speaking);
    Speaking s = Speaking(
      id: speaking.id,
      title: speaking.title,
      data: speaking.data,
      favorite: speaking.favorite == false ? true : false
    );
    _lessons[index] = s;
    String query = "Update speaking set favorite = '${speaking.favorite == false ? 1 : 0 }' where id = '${speaking.id}'";
    await _db.update(query);
    await getLessons();
  }

  Future<void> startRecording() async {
    isRecording = true;
    seconds = 0;
    update();
    if (await record.hasPermission()) {
      // Start recording
      var data = await _db.getAllRows("Select * from audioFiles where fileName like '%$fileName%'");
      await record.start(
        path: "$_path/$fileName ${data.length + 1}.mp3",
        encoder: AudioEncoder.aacLc, // by default
        bitRate: 128000, // by default
        samplingRate: 44100, // by default
      );
      _timer = Timer.periodic(const Duration(seconds: 1), (timer)async {
        seconds++;
        update();
      });
    }

  }

  Future<void> stopRecording() async {
    isRecording = await record.isRecording();
    _timer.cancel();
    if(isRecording)
    {
      _savedFilePath = await record.stop() ?? "";
      print(_savedFilePath);
      await _addFileToDB();
      isRecording = false;
      update();
    }

  }

  pauseOrResumeRecording()async{
    if(isPaused)
      {
        await record.resume();
        isPaused = false;
        update();
        _timer = Timer.periodic(const Duration(seconds: 1), (timer)async {
          seconds++;
          update();
        });
      }
    else
      {
        await record.pause();
        _timer.cancel();
        isPaused = true;
        update();
      }
  }

  playAudio(String path, int index, int seconds)async
  {
    playedSeconds = 0;
    if(isPlaying)
      {
        await player.stop();
        playingIndex = -1;
        update();
      }
    if(isPaused){
      isPaused = false;
      update();
    }
    _timer.cancel();
    if(File("$path").existsSync())
      {
        await player.play(DeviceFileSource("$path"));
        isPlaying = true;
        playingIndex = index;
        update();
      }
    
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) async{
      if(timer.tick == seconds)
        {
          _timer.cancel();
          player.stop();
          playingIndex = -1;
          isPlaying = false;
          isPaused = false;
          playedSeconds = 0;
          update();
        }
      playedSeconds++;
      update();
    });

  }

  togglePauseOrResume(int seconds) async
  {

    if(player.state == PlayerState.playing)
      {
        await player.pause();
        _timer.cancel();
        isPlaying = false;
        isPaused = true;
        update();
      }
    else if(player.state == PlayerState.paused)
      {
        print("Hello");
        await player.resume();
        isPlaying = true;
        isPaused = false;
        update();
        _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
          if(playedSeconds == seconds)
            {
              _timer.cancel();
              player.stop();
              playingIndex = -1;
              isPlaying = false;
              isPaused = false;
              playedSeconds = 0;
              update();
            }
          playedSeconds++;
          update();
        });


      }
  }

  stopPlaying()async
  {
    if(isPlaying)
    {
      await player.stop();
      playingIndex = -1;
      isPlaying = false;
      isPaused = false;
      update();
    }
  }

  deleteFile(String path) async{

    var file = File("$path");
    if(file.existsSync())
      {
        await file.delete();
      }
    await _db.delete("Delete from audioFiles where path = '$path'");
    await _getAudioFiles();
  }

  _addFileToDB() async
  {
    var data = await _db.getAllRows("Select * from audioFiles where fileName like '%$fileName%'");
    String query = "Insert into audioFiles (fileName, seconds, path) values('$fileName ${data.length + 1}', '$seconds', '$_savedFilePath')";
    await _db.insert(query);
    await _getAudioFiles();
  }


  _getAudioFiles() async
  {
    String query = "Select * from audioFiles";
    var data = await _db.getAllRows(query);
    _audioFiles = data.map((e) => AudioFile.fromMap(e)).toList();
    update();
  }

}