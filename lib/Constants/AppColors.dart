import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppColors extends GetxController{

  static Color primaryColor = Colors.purple;

  bool _isPurple = true;
  bool get isPurple => _isPurple;


  toggleThemeColor(){
    if(_isPurple)
      {
        primaryColor = Colors.red;
        _isPurple = false;
      }
    else
      {
        primaryColor = Colors.purple;
        _isPurple = true;
      }
    update();
  }

}