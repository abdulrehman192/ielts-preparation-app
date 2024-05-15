class IrregularVerb
{
  final int? id;
  final String? verb;
  final String? pastSimple;
  final String? pastPart;
  final String? thirdPerson;
  final String? gerund;
  final String? definition;
  final bool? favorite;

  IrregularVerb({this.id, this.verb, this.pastSimple, this.pastPart, this.gerund, this.thirdPerson, this.definition, this.favorite});

  factory IrregularVerb.fromMap(Map data)
  {
    return IrregularVerb(
      id: data['id'],
      verb: data['verb'],
      pastSimple: data['pastSimple'],
      pastPart: data['pastPart'],
      thirdPerson: data['thirdPerson'],
      gerund: data['gerund'],
      definition: data['definition'],
      favorite: data['favorite'] == true || data['favorite'] == 1? true : false,
    );
  }

}