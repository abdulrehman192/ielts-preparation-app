import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ielts_app/Views/DefaultView.dart';
import 'package:ielts_app/Views/ListeningView.dart';
import 'package:ielts_app/Views/QuizView.dart';
import 'package:ielts_app/Views/ReadingView.dart';
import 'package:ielts_app/Views/SpeakingView.dart';
import 'package:ielts_app/Views/VocabularyView.dart';
import 'package:ielts_app/Views/WritingView.dart';

import '../Views/TestView.dart';

class DashboardController extends GetxController
{
  late TabController tabController;
  final pages = const [
    DefaultView(),
    VocabularyView(),
    ListeningView(),
    ReadingView(),
    WritingView(isDashboard: false,),
    SpeakingView(),
    IELTSTestView()
  ];
}