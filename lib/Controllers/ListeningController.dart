import 'package:get/get.dart';
import 'package:ielts_app/Models/ListeningQuestion.dart';
import 'package:ielts_app/Models/YouTubeVideo.dart';
import 'package:ielts_app/Services/SQLiteService.dart';

import '../Models/ListeningLesson.dart';

class ListeningController extends GetxController
{
  final db = SqliteService.instance;
  List<ListeningLesson> _lessons = [];
  List<ListeningLesson> _beginnerLessons = [];
  List<ListeningLesson> _intermediateLessons = [];
  List<ListeningLesson> _advancedLessons = [];
  List<ListeningLesson> _conversationsLessons = [];
  List<ListeningQuestion> _answeredQuestions = [];
  List<YouTubeVideo> videoUrls = [];
  bool  loading = false;
  List<ListeningLesson> get lessons => _lessons;
  List<ListeningLesson> get beginnerLessons => _beginnerLessons;
  List<ListeningLesson> get intermediateLessons => _intermediateLessons;
  List<ListeningLesson> get advancedLessons => _advancedLessons;
  List<ListeningLesson> get conversationsLessons => _conversationsLessons;
  List<ListeningQuestion> get answeredQuestions => _answeredQuestions;
  @override
  void onInit() {
    super.onInit();
    getVideosUrls();
    getLessons();
  }

  getLessons() async
  {
    loading = true;
    update();
    String query = "Select * from Listening_Lessons";
    var data = await db.getAllRows(query);
    _lessons = data.map((e) => ListeningLesson.fromMap(e)).toList();
    _beginnerLessons = _lessons.where((element) => element.level == "Beginner").toList();
    _intermediateLessons = _lessons.where((element) => element.level == "Intermediate").toList();
    _advancedLessons = _lessons.where((element) => element.level == "Advanced").toList();
    _conversationsLessons = _lessons.where((element) => element.level == "Conversation").toList();
    loading = false;
    update();
  }

  addToAnsweredQuestions(ListeningLesson lesson,)
  {
    _answeredQuestions.clear();
    for(int i = 0 ; i < lesson.questions!.length; i++)
      {
        ListeningQuestion q = ListeningQuestion(
          question: lesson.questions![i].question,
          option1: lesson.questions![i].option1,
          option2: lesson.questions![i].option2,
          option3: lesson.questions![i].option3,
          option4: lesson.questions![i].option4,
          answer: ""
        );
        _answeredQuestions.add(q);
      }
    update();
  }

  toggleListen(ListeningLesson val) async
  {
    int index = _getLessonIndex(val);
    ListeningLesson lesson = ListeningLesson(
      id: _lessons[index].id,
      title: _lessons[index].title,
      data: _lessons[index].data,
      level: _lessons[index].level,
      questions: _lessons[index].questions,
      listen:  true,
      favorite: _lessons[index].favorite
    );
    _lessons[index] = lesson;
    String query = "Update Listening_Lessons set listen = '1' where id = '${val.id}'";
    await db.update(query);
    await getLessons();
    update();
  }


  getVideosUrls() async{
    String query = "Select * from videoUrls";
    var data  = await db.getAllRows(query);
    videoUrls = data.map((e) => YouTubeVideo.fromMap(e)).toList();
    update();
  }

  toggleAnswer(int index, String val)
  {
    ListeningQuestion q = ListeningQuestion(
        question: _answeredQuestions[index].question,
        option1: _answeredQuestions[index].option1,
        option2: _answeredQuestions[index].option2,
        option3: _answeredQuestions[index].option3,
        option4: _answeredQuestions[index].option4,
        answer: val
    );
    _answeredQuestions[index] = q;
    update();
  }

  int getResult(ListeningLesson lesson)
  {
    int count = 0;
    for(int i = 0; i < _answeredQuestions.length; i++)
      {
        var x = lesson.questions!.where((element) => element.answer == _answeredQuestions[i].answer).toList();
        if(x.isNotEmpty)
          {
            count++;
          }
      }
    return count;
  }

  tryAgain()
  {
    for(int i = 0 ; i < _answeredQuestions.length; i++)
      {
        ListeningQuestion q = ListeningQuestion(
            question: _answeredQuestions[i].question,
            option1: _answeredQuestions[i].option1,
            option2: _answeredQuestions[i].option2,
            option3: _answeredQuestions[i].option3,
            option4: _answeredQuestions[i].option4,
            answer: ""
        );
        _answeredQuestions[i] = q;
      }
    update();
  }


  int _getLessonIndex(ListeningLesson lesson)
  {
    int i = -1;
    for(int x = 0; x < _lessons.length; x++)
      {
        if(lesson.id == _lessons[x].id)
          {
            i = x;
          }
      }
    return i;
  }

  void toggleFavorite(ListeningLesson lesson)async {
    int index = _getLessonIndex(lesson);
    ListeningLesson l = ListeningLesson(
        id: _lessons[index].id,
        title: _lessons[index].title,
        data: _lessons[index].data,
        questions: _lessons[index].questions,
        level: _lessons[index].level,
        listen:  _lessons[index].listen,
        favorite: _lessons[index].favorite == true ? false : true
    );

    String query = "Update Listening_Lessons set favorite = '${_lessons[index].favorite == true ? 0 : 1}' where id = '${lesson.id}'";
    await db.update(query);
    await getLessons();
    _lessons[index] = l;
    update();
  }


  bool isAllQuestionsAnswered()
  {
    bool yes = false;
    var list = _answeredQuestions.where((element) => element.answer == "").toList();
    if(list.isEmpty)
      {
        yes = true;
      }
    return yes;
  }

}