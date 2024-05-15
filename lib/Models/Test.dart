import 'dart:convert';

import 'ListeningQuestion.dart';

class Test
{
  final int? id;
  final List<ListeningQuestion>? questions;
  final int? score;

  Test({this.id, this.score, this.questions});

  factory Test.fromMap(Map data)
  {
    List<ListeningQuestion> temp = [];
    String x = data['questions'];
    QuestionsList list = QuestionsList.fromMap(json.decode(x));
    temp = list.questions;
    return Test(
      id: data['id'],
      questions: temp,
      score: data['score']
    );
  }

}