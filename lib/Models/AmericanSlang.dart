class AmericanSlang
{
  final int? id;
  final String? title;
  final String? description;
  final String? example;
  final String? etymology;
  final String? synonyms;
  final String? antonyms;
  final bool? favorite;

  AmericanSlang({this.id, this.title, this.description, this.example, this.etymology, this.synonyms, this.antonyms, this.favorite});

  factory AmericanSlang.fromMap(Map data)
  {
    return AmericanSlang(
      id: data['id'],
      title: data['title'],
      description: data['description'],
      example: data['example'],
      etymology: data['etymology'],
      synonyms: data['synonyms'],
      antonyms: data['antonyms'],
      favorite: data['favorite'] == true || data['favorite'] == 1? true : false,
    );
  }
}