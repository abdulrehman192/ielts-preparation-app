import 'package:get/get.dart';
import 'package:ielts_app/Services/SQLiteService.dart';

import '../Models/ListeningQuestion.dart';
import '../Models/Test.dart';

class TestController extends GetxController
{
  final _db = SqliteService.instance;
  List<Test> _tests = [];
  int items = 0;
  List<Test> test1 = [];
  List<Test> test2 = [];
  List<Test> test3 = [];
  bool highlightAnswers = false;
  List<ListeningQuestion> _answeredQuestions = [];

  List<ListeningQuestion> get answeredQuestions => _answeredQuestions;

  onInit(){
    super.onInit();
    getAllTests();
  }

  getAllTests() async{
    String query = "Select * from tests";
    var data = await _db.getAllRows(query);
    _tests = data.map((e) {
      return Test.fromMap(e);
    }).toList();
    test1 = _tests.where((element) => (element.id ?? 0) <= 30).toList();
    test2 = _tests.where((element) => (element.id ?? 0) > 30 && (element.id ?? 0) <= 60).toList();
    test3 = _tests.where((element) => (element.id ?? 0) > 60 && (element.id ?? 0) <= 90).toList();
    update();
  }


  addToAnsweredQuestions(Test lesson,)
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

  _updateScore(Test lesson, int score) async{
    int index = _getTestIndex(lesson);
    String query = "Update Tests set score = '$score' where id = '${lesson.id}'";
    _tests[index] = Test(
      id: lesson.id,
      questions: lesson.questions,
      score: score
    );
    await _db.update(query);
    await getAllTests();
  }

  int getResult(Test lesson)
  {
    highlightAnswers = true;
    update();
    int count = 0;
    for(int i = 0; i < _answeredQuestions.length; i++)
    {
      var x = lesson.questions!.where((element) => element.answer == _answeredQuestions[i].answer).toList();
      if(x.isNotEmpty)
      {
        count++;
      }
    }
    _updateScore(lesson, count);
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
    highlightAnswers = false;
    update();
  }

  int _getTestIndex(Test lesson)
  {
    int i = -1;
    for(int x = 0; x < _tests.length; x++)
    {
      if(lesson.id == _tests[x].id)
      {
        i = x;
      }
    }
    return i;
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

  String getAnswer(Test test, int index)
  {
    int i = _getTestIndex(test);
    return _tests[i].questions![index].answer.toString();
  }

}