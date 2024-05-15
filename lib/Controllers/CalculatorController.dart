import 'package:get/get.dart';
import 'package:ielts_app/Utils/CommonFunctions.dart';

import '../Models/BandModel.dart';

class CalculatorController extends GetxController
{
  String _listeningBandValue = "Select Listening Band";
  String _readingBandValue = "Select Reading Band";
  String _writingBandValue = "Select Writing Band";
  String _speakingBandValue = "Select Speaking Band";
  List<Band> bands = [
    Band(
        band: "Band 9",
        pronunciation: "Uses a wide range of pronunciation features.\nSustains flexible use of features, with only occasional lapses.\nIs easy to understand throughout, 1 accent has minimal effect on intelligibility.",
        grammaticalRange: "Uses a wide range of structures flexibly.\nProduces a majority of error-free sentences with only very occasional inappropriateness or basic/unsystematic errors.",
        lexicalResource: "Uses a wide vocabulary resource readily and flexibly to convey precise meaning.\nUses less common and idiomatic vocabulary skillfully, with occasional inaccuracies.\nUses paraphrase effectively as required.",
        fluencyAndCoherence: "Speaks fluently with only occasional repetition or selfcorrection, hesitation is usually content related and only rarely to search for language.\nDevelops topics coherently and appropriately."
    ),
    Band(
        band: "Band 8",
        pronunciation: "Uses a wide range of pronunciation features.\nSustains flexible use of features, with only occasional lapses.\nIs easy to understand throughout, 1 accent has minimal effect on intelligibility.",
        grammaticalRange: "Uses a wide range of structures flexibly.\nProduces a majority of error-free sentences with only very occasional inappropriateness or basic/unsystematic errors.",
        lexicalResource: "Uses a wide vocabulary resource readily and flexibly to convey precise meaning.\nUses less common and idiomatic vocabulary skillfully, with occasional inaccuracies.\nUses paraphrase effectively as required.",
        fluencyAndCoherence: "Speaks fluently with only occasional repetition or selfcorrection, hesitation is usually content related and only rarely to search for language.\nDevelops topics coherently and appropriately."
    ),
    Band(
        band: "Band 7",
        pronunciation: "Shows all the positive features of band 6 and some, but not all, of the positive features of band 8.",
        grammaticalRange: "Uses a range of complex structures with some flexibility.\nFrequently produces error-free sentences, though some grammatical mistakes persist.",
        lexicalResource: "Uses vocabulary resource flexibly to discuss a variety of topics.\nUses some less common and idiomatic vocabulary and shows some awareness of style and collocation, with some inappropriate choices.\nUses paraphrase effectively.",
        fluencyAndCoherence: "Speaks at length without noticeable effort or loss of coherence.\nMay demonstrate language-related hesitation at times, or some repetition and/or self-correction.\nUses a range of connectives and discourse markers with some flexibility."
    ),

  ];
  double _result = 0;

  double get result => _result;

  List<String> listeningItems = [
    '9 (39-40)',
    '8.5 (37-38)',
    '8 (35-36)',
    '7.5 (32-34)',
    '7 (30-31)',
    '6.5 (26-29)',
    '6 (23-25)',
    '5.5 (18-22)',
    '5 (16-17)',
    '4.5 (13-15)',
    '4 (10-12)',
    '3.5 (8-9)',
    '3 (6-7)',
    '2.5 (4-5)',
  ];
  List<String> readingItems = [
    '9 (40)',
    '8.5 (39)',
    '8 (37-38)',
    '7.5 (36)',
    '7 (34-35)',
    '6.5 (32-33)',
    '6 (30-31)',
    '5.5 (27-29)',
    '5 (23-26)',
    '4.5 (19-22)',
    '4 (15-18)',
    '3.5 (12-14)',
    '3 (9-11)',
  ];
  List<String> writingItems = [
    '9',
    '8.5',
    '8',
    '7.5',
    '7',
    '6.5',
    '6',
    '5.5',
    '5',
    '4.5',
    '4',
    '3.5',
    '3',
    '2.5',
    '2',
  ];
  List<String> speakingItems = [
    '9',
    '8.5',
    '8',
    '7.5',
    '7',
    '6.5',
    '6',
    '5.5',
    '5',
    '4.5',
    '4',
    '3.5',
    '3',
    '2.5',
    '2',
  ];


  String get listeningBandValue => _listeningBandValue;
  String get readingBandValue => _readingBandValue;
  String get writingBandValue => _writingBandValue;
  String get speakingBandValue => _speakingBandValue;


  set listeningBandValue(String val)
  {
    _listeningBandValue = val;
    update();
  }

  set readingBandValue(String val)
  {
    _readingBandValue = val;
    update();
  }

  set writingBandValue(String val)
  {
    _writingBandValue = val;
    update();
  }

  set speakingBandValue(String val)
  {
    _speakingBandValue = val;
    update();
  }


  calculateBands() async
  {
    if(_validate())
      {
        double sum = _parseValue(_listeningBandValue) + _parseValue(_speakingBandValue) + _parseValue(_readingBandValue) + _parseValue(_writingBandValue);
        _result = sum / 4;
        String x = result.toStringAsFixed(1);
        int i = x.indexOf(".");
        double number = double.parse(x.substring(0, i));
        int decimal = int.parse(x.substring(i+1));
        if(decimal < 5)
          {
            _result = number;
          }
        else if(decimal == 5)
          {
            _result = number + 0.5;
          }
        else
          {
            _result = number + 1;
          }
        update();
      }
  }

  double _parseValue(String val)
  {
    double a = 0;
    try
    {
      if(val.contains("("))
      {
        int i = val.indexOf("(");
        var x = val.substring(0, i);
        a = double.parse(x.trim());
      }
      else
      {
        a = double.parse(val.trim());
      }
    }
    catch(e)
    {
      a = 0;
    }
    return a;
  }

  bool _validate()
  {
    bool check = true;
    if(_listeningBandValue == "Select Listening Band")
      {
        check = false;
        CommonFunctions.showSnackBar("Data Required", "Please Select Listening Band");
      }
    else if(_readingBandValue == "Select Reading Band")
    {
      check = false;
      CommonFunctions.showSnackBar("Data Required", "Please Select Reading Band");
    }
    else if(_speakingBandValue == "Select Speaking Band")
    {
      check = false;
      CommonFunctions.showSnackBar("Data Required", "Please Select Speaking Band");
    }
    else if(_writingBandValue == "Select Writing Band")
    {
      check = false;
      CommonFunctions.showSnackBar("Data Required", "Please Select Writing Band");
    }
    return check;
  }

}