class ProverbIdiom
{
  final int? id;
  final String? title;
  final String? description;
  final String? type;
  final bool? favorite;

  ProverbIdiom({this.id, this.title, this.description, this.type, this.favorite});

  factory ProverbIdiom.fromMap(Map map)
  {
    return ProverbIdiom(
      id: map['id'],
      title: map['title'],
      description: map['description'],
      type: map['type'],
      favorite: map['favorite'] == true || map['favorite'] == 1 ? true : false,
    );
  }


}