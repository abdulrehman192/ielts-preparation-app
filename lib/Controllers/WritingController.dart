import 'package:get/get.dart';
import 'package:ielts_app/Models/WritingModel.dart';
import 'package:ielts_app/Services/SQLiteService.dart';
import '../Models/SpeakingModel.dart';

class WritingController extends GetxController
{
  final _db = SqliteService.instance;
  List<Writing> _lessons = [];
  bool loading = false;
  List<Writing> get lessons => _lessons;


  @override
  void onInit() {
    super.onInit();
    getLessons();
  }

  getLessons() async
  {
    loading = true;
    update();
    String query = "Select * from writing";
    var data = await _db.getAllRows(query);
    _lessons = data.map((e) => Writing.fromMap(e)).toList();
    loading = false;
    update();
  }

  toggleLessonFavorite(Writing writing) async
  {
    int index = _lessons.indexOf(writing);
    Writing s = Writing(
      id: writing.id,
      title: writing.title,
      data: writing.data,
      favorite: writing.favorite == false ? true : false
    );
    _lessons[index] = s;
    String query = "Update speaking set favorite = '${writing.favorite == false ? 1 : 0 }' where id = '${writing.id}'";
    await _db.update(query);
    await getLessons();
  }
}