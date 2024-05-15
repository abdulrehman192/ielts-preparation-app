class FAQ
{
  final int? id;
  final String? question;
  final String? answer;

  FAQ({this.id, this.question, this.answer});

  factory FAQ.fromMap(Map data)
  {
    return FAQ(
      id: data['id'],
      question: data['question'],
      answer: data['answer'],
    );
  }
}