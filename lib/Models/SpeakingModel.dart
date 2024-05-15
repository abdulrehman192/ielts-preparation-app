class Speaking
{
  final int? id;
  final String? title;
  final String? data;
  final String? suggestion;
  final bool? favorite;

  Speaking({this.id, this.title, this.suggestion, this.data, this.favorite});

  factory Speaking.fromMap(Map data)
  {
    return Speaking(
      id: data['id'],
      title: data['title'],
      suggestion: data['suggestion'],
      data: data['data'],
      favorite: data['favorite'] == true || data['favorite'] == 1? true : false,
    );
  }
}