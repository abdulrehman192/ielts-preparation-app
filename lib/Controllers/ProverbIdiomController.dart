import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ielts_app/Services/SQLiteService.dart';

import '../Models/ProverIdiomModel.dart';

class ProverbIdiomController extends GetxController
{
  final db = SqliteService.instance;

  ScrollController scrollController = ScrollController();
  final searchController = TextEditingController();
    List<ProverbIdiom> _items = [];
    List<ProverbIdiom> _searchItems = [];
    String _type = "Proverbs";
  int _pageSize = 15;
  int _currentMax = 0;
  bool loadingMore = false;
  bool loading = false;


    List<ProverbIdiom> get items => _items;
    List<ProverbIdiom> get searchItems => _searchItems;

    set type(String val)
    {
      _type = val;
      update();
    }

    @override
  void onInit() {
    getItems();
    super.onInit();
    scrollController.addListener(() {
      if(loadingMore) return;
      if(scrollController.position.pixels == scrollController.position.maxScrollExtent)
      {
        _getMoreItems();
      }
    });
  }

  Future<void> getItems()async {
    loading = true;
    update();
    _items.clear();
    _currentMax = 0;
    loadingMore = false;
      String query = "Select * from proverbs_and_idioms where type = '$_type' limit $_pageSize";
      var data = await db.getAllRows(query);
      _items = data.map((e) => ProverbIdiom.fromMap(e)).toList();
    if(_items.isNotEmpty)
    {
      _currentMax = _items.last.id!;
    }
    Future.delayed(const Duration(seconds: 1), (){
      loading = false;
      update();
    });
  }

  Future<void> _getMoreItems()async {
    loadingMore = true;
    update();
    String query = "Select * from proverbs_and_idioms where type = '$_type' and id between '$_currentMax' and '${_currentMax + _pageSize}' limit $_pageSize";
    var data = await db.getAllRows(query);
    List<ProverbIdiom>  list= data.map((e) => ProverbIdiom.fromMap(e)).toList();
    _currentMax += _pageSize +1;
    for(int i = 0; i < list.length; i++)
    {
      _items.add(list[i]);
    }
    Future.delayed(const Duration(seconds: 1), (){
      loadingMore = false;
      update();
    });
  }

  Future<void> toggleFavorite(ProverbIdiom item, {required bool isSearch,}) async{

    ProverbIdiom w = ProverbIdiom(
        title: item.title,
        description: item.description,
        type: item.type,
        favorite:  item.favorite == true ? false : true
    );
    if(isSearch)
      {
        int index = _searchItems.indexOf(item);
        _searchItems[index] = w;
      }
    else
      {
        int index = _items.indexOf(item);
        _items[index] = w;
      }
    String query = "Update proverbs_and_idioms set favorite = '${item.favorite == true ? 0 : 1}' where id = '${item.id}'";
    await db.update(query);
    update();
  }


  Future<void> getSearchItems() async {
    loading = true;
    update();
    String query = "Select * from proverbs_and_idioms where type = '$_type' and title Like '%${searchController.text.trim()}%' ";
    var data = await db.getAllRows(query);
    _searchItems = data.map((e) => ProverbIdiom.fromMap(e)).toList();
    loading = false;
    update();
  }

}