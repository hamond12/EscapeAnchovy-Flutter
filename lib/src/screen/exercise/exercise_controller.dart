import 'dart:async';

import 'package:escape_anchovy/src/screen/exercise/exercise_screen1.dart';
import 'package:escape_anchovy/src/screen/exercise/exercise_screen2.dart';
import 'package:escape_anchovy/src/util/shared_preferences_util.dart';
import 'package:flutter/material.dart';

class ExerciseController with ChangeNotifier {

  List<Map<String, dynamic>> dataList = [];

  void initDataList() {
    dataList = SharedPreferencesUtil.getJsonList('dataList');
  }

  int set = 1;

  String num1 = '';
  String num2 = '';

  List<int> ex1 = [];
  List<int> ex2 = [];

  int seconds = 3;

  String formatTime(int second) {
    int minutes = second ~/ 60;
    int seconds = second % 60;
    return '$minutes:${seconds.toString().padLeft(2, '0')}';
  }

  void moveScreen(context, set) {
    Timer.periodic(const Duration(seconds: 1), (Timer timer) {
      if (seconds == 0) {
        timer.cancel();
        if (set % 2 != 0) {
          Navigator.pushNamed(context, ExerciseScreen1.routeName);
        } else {
          Navigator.pushNamed(context, ExerciseScreen2.routeName);
        }
      } else {
        seconds--;
        notifyListeners();
      }
    });
  }

  void addData(data) {
    dataList.add(data);
    SharedPreferencesUtil.setJsonList('dataList', dataList);
  }

  void initExData(){
    set = 1;
    ex1 = [];
    ex2 = [];
  }
}