class Essay
{
  final int? id;
  final String? title;
  final String? data;
  final bool? favorite;

  Essay({this.id, this.title, this.data, this.favorite});

  factory Essay.fromMap(Map data)
  {
    return Essay(
      id: data['id'],
      title: data['title'],
      data: data['data'],
      favorite: data['favorite'] == true || data['favorite'] == 1? true : false,
    );
  }
}