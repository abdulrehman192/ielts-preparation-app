import 'dart:convert';

import 'ListeningQuestion.dart';

class ListeningLesson
{
  final int? id;
  final String? title;
  final String? data;
  final bool? listen;
  final String? level;
  final List<ListeningQuestion>? questions;
  final bool? favorite;


  ListeningLesson({this.id, this.title, this.data, this.listen, this.questions, this.level, this.favorite});

  factory ListeningLesson.fromMap(Map data)
  {
    List<ListeningQuestion> temp = [];
    String x = data['questions'];
    QuestionsList list = QuestionsList.fromMap(json.decode(x));
    temp = list.questions;
    return ListeningLesson(
      id: data['id'],
      title: data['title'],
      data: data['data'],
      level: data['level'],
      listen: data['listen'] == 1 || data['listen'] == true ? true : false,
      favorite: data['favorite'] == 1 || data['favorite'] == true ? true : false,
      questions: temp
    );
  }
}