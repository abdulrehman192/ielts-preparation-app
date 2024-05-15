class Word
{
  final int? id;
  final String? word;
  final String? type;
  final String? description;
  final bool? favorite;

  Word({this.id, this.type, this.word, this.description, this.favorite});

  factory Word.fromMap(Map data)
  {
    return Word(
      id: data['id'],
      word: data['word'],
      type: data['type'],
      description: data['description'],
      favorite: data['favorite'] == true || data['favorite'] == 1 ? true : false,
    );
  }
}