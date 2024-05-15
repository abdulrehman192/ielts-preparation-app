class ListeningQuestion
{
  final String? question;
  final String? option1;
  final String? option2;
  final String? option3;
  final String? option4;
  final String? answer;

  ListeningQuestion({this.question, this.option1, this.option2, this.option3,this.option4, this.answer});

  factory ListeningQuestion.fromMap(Map data)
  {
    return ListeningQuestion(
      question: data['question'],
      option1: data['option1'],
      option2: data['option2'],
      option3: data['option3'],
      option4: data['option4'],
      answer: data['answer'],
    );
  }
}

class QuestionsList
{
  final List<ListeningQuestion> questions;

  QuestionsList(this.questions);

  factory QuestionsList.fromMap(List list)
  {
    List<ListeningQuestion> temp = [];
    temp = list.map((e) => ListeningQuestion.fromMap(e)).toList();
    return QuestionsList(temp);
  }

}