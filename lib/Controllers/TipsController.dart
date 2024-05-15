import 'package:get/get.dart';
import 'package:ielts_app/Models/FAQModel.dart';
import 'package:ielts_app/Services/SQLiteService.dart';

import '../Models/TipModel.dart';

class TipsAndFAQController extends GetxController
{
  final _db = SqliteService.instance;
  List<Tip> _tips = [];
  List<FAQ> _faqs = [];
  List<Tip> get tips => _tips;
  List<FAQ> get faqs => _faqs;

  @override
  void onInit() {
    super.onInit();
    getTips();
    getFAQ();
  }

  void getTips()async {
    String query = "Select * from tips";
    var data = await _db.getAllRows(query);
    _tips = data.map((e) => Tip.fromMap(e)).toList();
    update();
  }

  void getFAQ()async {
    String query = "Select * from faqs";
    var data = await _db.getAllRows(query);
    _faqs = data.map((e) => FAQ.fromMap(e)).toList();
    update();
  }
}