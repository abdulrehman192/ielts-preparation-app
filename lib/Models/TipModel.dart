class Tip
{
  final int? id;
  final String? title;
  final String? subTitle;
  final String? description;

  Tip({this.id, this.title, this.subTitle, this.description});

  factory Tip.fromMap(Map data)
  {
    return Tip(
      id: data['id'],
      title: data['title'],
      subTitle: data['subTitle'],
      description: data['description'],
    );
  }
}