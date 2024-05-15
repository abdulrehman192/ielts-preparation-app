import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:ielts_app/Models/AmericanSlang.dart';
import 'package:ielts_app/Models/IrregularVerb.dart';
import 'package:ielts_app/Services/SQLiteService.dart';

import '../Models/EssayModel.dart';
import '../Models/WordModel.dart';

class ReadingController extends GetxController
{
  final searchController = TextEditingController();
  final db = SqliteService.instance;
  List<Essay> _essays = [];
  List<Essay> _searchEssays = [];
  List<Essay> _stories = [];
  List<Essay> _searchStories = [];

  List<Essay> _articles = [];
  List<Essay> _searchArticles = [];
  List<IrregularVerb> _irregularVerbs = [];
  List<IrregularVerb> _searchIrregularVerbs = [];
  List<AmericanSlang> _slangs = [];
  List<AmericanSlang> _searchSlangs = [];
  bool loading = false;
  List<Essay> get stories => _stories;
  List<Essay> get searchStories => _searchStories;
  List<Essay> get essays => _essays;
  List<Essay> get articles => _articles;
  List<Essay> get searchArticles => _searchArticles;
  List<Essay> get searchEssays => _searchEssays;
  List<IrregularVerb> get irregularVerbs => _irregularVerbs;
  List<IrregularVerb> get searchIrregularVerbs => _searchIrregularVerbs;
  List<AmericanSlang> get slangs => _slangs;
  List<AmericanSlang> get searchSlangs => _searchSlangs;

  @override
  onInit()
  {
    super.onInit();
    getEssays();
    getStories();
    getVerbs();
    getSlangs();
    getArticles();
  }

  getEssays() async
  {
    loading = true;
    update();
    String query = "Select * from Essays";
    var data = await db.getAllRows(query);
    _essays = data.map((e) => Essay.fromMap(e)).toList();
    loading = false;
    update();
  }

  getArticles() async
  {
    loading = true;
    update();
    String query = "Select * from articles";
    var data = await db.getAllRows(query);
    _articles = data.map((e) => Essay.fromMap(e)).toList();
    loading = false;
    update();
  }

  getStories() async
  {
    loading = true;
    update();
    String query = "Select * from Stories";
    var data = await db.getAllRows(query);
    _stories = data.map((e) => Essay.fromMap(e)).toList();
    loading = false;
    update();
  }

  getVerbs() async
  {
    loading = true;
    update();
    String query = "Select * from irregular_verbs";
    var data = await db.getAllRows(query);
    _irregularVerbs = data.map((e) => IrregularVerb.fromMap(e)).toList();
    loading = false;
    update();
  }

  getSlangs() async
  {
    loading = true;
    update();
    String query = "Select * from slangs";
    var data = await db.getAllRows(query);
    _slangs = data.map((e) => AmericanSlang.fromMap(e)).toList();
    loading = false;
    update();
  }

  Future<void> toggleVerbFavorite(IrregularVerb item, {required bool isSearch,}) async{

    IrregularVerb w = IrregularVerb(
        verb: item.verb,
        definition: item.definition,
        pastPart: item.pastPart,
        pastSimple: item.pastSimple,
        gerund: item.gerund,
        thirdPerson: item.thirdPerson,
        favorite:  item.favorite == true ? false : true
    );
    if(isSearch )
    {
      int index = _searchIrregularVerbs.indexOf(item);
      _searchIrregularVerbs[index] = w;
    }
    else
    {
      int index = _irregularVerbs.indexOf(item);
      _irregularVerbs[index] = w;
    }
    String query = "Update irregular_verbs set favorite = '${item.favorite == true ? 0 : 1}' where id = '${item.id}'";
    await db.update(query);
    update();
  }

  Future<void> toggleSlangFavorite(AmericanSlang item, {required bool isSearch,}) async{

    AmericanSlang w = AmericanSlang(
        title: item.title,
        description: item.description,
        example: item.example,
        etymology: item.etymology,
        synonyms: item.synonyms,
        antonyms: item.antonyms,
        favorite:  item.favorite == true ? false : true
    );
    if(isSearch )
    {
      int index = _searchSlangs.indexOf(item);
      _searchSlangs[index] = w;
    }
    else
    {
      int index = _slangs.indexOf(item);
      _slangs[index] = w;
    }
    String query = "Update slangs set favorite = '${item.favorite == true ? 0 : 1}' where id = '${item.id}'";
    await db.update(query);
    update();
  }

  Future<void> toggleEssayOrStoryFavorite(Essay item, {required bool isSearch, required bool isStory, required bool isEssay, required bool isArticle}) async{

    Essay w = Essay(
        title: item.title,
        data: item.data,
        favorite:  item.favorite == true ? false : true
    );
    String query = "Update Essays set favorite = '${item.favorite == true ? 0 : 1}' where id = '${item.id}'";
    if(isSearch && isEssay)
    {
      int index = _searchEssays.indexOf(item);
      _searchEssays[index] = w;
      query = "Update Essays set favorite = '${item.favorite == true ? 0 : 1}' where id = '${item.id}'";
    }
    else if(!isSearch && isEssay)
    {
      int index = _essays.indexOf(item);
      _essays[index] = w;
      query = "Update Essays set favorite = '${item.favorite == true ? 0 : 1}' where id = '${item.id}'";
    }
    if(isSearch && isStory)
    {
      int index = _searchStories.indexOf(item);
      _searchStories[index] = w;
      query = "Update Stories set favorite = '${item.favorite == true ? 0 : 1}' where id = '${item.id}'";
    }
    else if(!isSearch && isStory)
    {
      int index = _stories.indexOf(item);
      _stories[index] = w;
      query = "Update Stories set favorite = '${item.favorite == true ? 0 : 1}' where id = '${item.id}'";
    }

    if(isSearch && isArticle)
    {
      int index = _searchArticles.indexOf(item);
      _searchArticles[index] = w;
      query = "Update articles set favorite = '${item.favorite == true ? 0 : 1}' where id = '${item.id}'";
    }
    else if(!isSearch && isArticle)
    {
      int index = _articles.indexOf(item);
      _articles[index] = w;
      query = "Update articles set favorite = '${item.favorite == true ? 0 : 1}' where id = '${item.id}'";
    }

    await db.update(query);
    update();
  }

  getSearchVerbs() async
  {
    loading = true;
    update();
    String query = "Select * from irregular_verbs where verb like '%${searchController.text.trim()}%'";
    var data = await db.getAllRows(query);
    _searchIrregularVerbs = data.map((e) => IrregularVerb.fromMap(e)).toList();
    loading = false;
    update();
  }

  getSearchSlangs() async
  {
    loading = true;
    update();
    String query = "Select * from slangs where title like '%${searchController.text.trim()}%'";
    var data = await db.getAllRows(query);
    _searchSlangs = data.map((e) => AmericanSlang.fromMap(e)).toList();
    loading = false;
    update();
  }


  getSearchEssays() async
  {
    loading = true;
    update();
    String query = "Select * from Essays where title like '%${searchController.text.trim()}%'";
    var data = await db.getAllRows(query);
    _searchEssays = data.map((e) => Essay.fromMap(e)).toList();
    loading = false;
    update();
  }

  getSearchArticles() async
  {
    loading = true;
    update();
    String query = "Select * from articles where title like '%${searchController.text.trim()}%'";
    var data = await db.getAllRows(query);
    _searchArticles = data.map((e) => Essay.fromMap(e)).toList();
    loading = false;
    update();
  }

  getSearchStories() async
  {
    loading = true;
    update();
    String query = "Select * from Stories where title like '%${searchController.text.trim()}%'";
    var data = await db.getAllRows(query);
    _searchStories = data.map((e) => Essay.fromMap(e)).toList();
    loading = false;
    update();
  }
}