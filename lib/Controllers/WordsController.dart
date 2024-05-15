import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ielts_app/Models/WordModel.dart';
import 'package:ielts_app/Services/SQLiteService.dart';

class WordsController extends GetxController
{
  ScrollController scrollController = ScrollController();
  final searchController = TextEditingController();

  final db = SqliteService.instance;
  List<Word> _words = [];
  List<Word> _importantWords = [];
  List<Word> _searchWords = [];
  final int _pageSize = 10;
  int _currentMax = 0;
  String _letter = 'a';
  bool loadingMore = false;
  bool loading = false;
  set letter(String val)
  {
    _letter = val.toLowerCase();
    update();
    getWords();

  }
  List<Word> get words => _words;
  List<Word> get importantWords => _importantWords;
  List<Word> get searchWords  => _searchWords;

  final List<String> characters = [
    'A',
    'B',
    'C',
    'D',
    'E',
    'F',
    'G',
    'H',
    'I',
    'J',
    'K',
    'L',
    'M',
    'N',
    'O',
    'P',
    'Q',
    'R',
    'S',
    'T',
    'U',
    'V',
    'W',
    'X',
    'Y',
    'Z',
  ];

  Future<void> toggleFavorite(Word word, {required bool isSearch, required bool isImportant}) async {

    Word w = Word(
      word: word.word,
      description: word.description,
      type: word.type,
      favorite:  word.favorite == true ? false : true
    );

    if(isSearch)
      {
        int index = _searchWords.indexOf(word);
        _searchWords[index] = w;
      }
    else if(isImportant)
      {
        int index = _importantWords.indexOf(word);
        _importantWords[index] = w;
      }
    else
      {
        int index = _words.indexOf(word);
        _words[index] = w;
      }
    String query = "Update words set favorite = '${word.favorite == true ? 0 : 1}' where id = '${word.id}'";
    await db.update(query);
    update();
  }


  @override
  onInit(){
    super.onInit();
    getWords();
    getImportantWords();
    getSearchWords();
    scrollController.addListener(() {
      if(loadingMore) return;
      if(scrollController.position.pixels == scrollController.position.maxScrollExtent)
        {
          _loadMoreWords();
        }
    });
  }

  getWords() async
  {
    loading = true;
    update();
    _words.clear();
    _currentMax = 0;
    loadingMore = false;
    String query = "Select * from words where word like '$_letter%' limit $_pageSize";
    var data = await db.getAllRows(query);
    _words = data.map((e) => Word.fromMap(e)).toList();
    if(_words.isNotEmpty)
      {
        _currentMax = _words.last.id!;
      }
    Future.delayed(const Duration(seconds: 1), (){
      loading = false;
      update();
    });
  }

  _loadMoreWords()async
  {
    loadingMore = true;
    update();
    String query = "Select * from words where word like '$_letter%' and id between '$_currentMax' and '${_currentMax + _pageSize}' limit $_pageSize";
    var data = await db.getAllRows(query);
    List<Word> list = data.map((e) => Word.fromMap(e)).toList();
    _currentMax += _pageSize +1;
    for(int i = 0; i < list.length; i++)
      {
        _words.add(list[i]);
      }
    Future.delayed(const Duration(seconds: 1), (){
      loadingMore = false;
      update();
    });
  }
  
  String getWordTypeLetter(String word)
  {
    if(word.contains("Verb"))
      {
        return "V.";
      }
    else if(word.contains("Adjective"))
    {
      return "A.";
    }
    else if(word.contains("Noun"))
    {
      return "N.";
    }
    else
      {
        return "P.";
      }
  }

  getSearchWords()async
  {
    loading = true;
    update();
    String query = "Select * from words where word like '%${searchController.text}%'";
    var data = await db.getAllRows(query);
    _searchWords = data.map((e) => Word.fromMap(e)).toList();
    loading = false;
    update();
  }

  getImportantWords()async
  {
    loading = true;
    update();
    String query = "Select * from words ORDER BY RANDOM() LIMIT 500;";
    var data = await db.getAllRows(query);
    _importantWords = data.map((e) => Word.fromMap(e)).toList();
    _importantWords.sort((a, b) => a.word.toString().compareTo(b.word.toString()));
    loading = false;
    update();
  }
}