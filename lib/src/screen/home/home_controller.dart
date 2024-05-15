import 'dart:async';

import 'package:escape_anchovy/src/util/shared_preferences_util.dart';
import 'package:flutter/material.dart';

class HomeController with ChangeNotifier {

  // 운동기록 가져오기

  List<Map<String, dynamic>> dataList = [];

  void initDataList() {
    dataList = SharedPreferencesUtil.getJsonList('dataList');
  }

  // 데이터 추가, 삭제

  void addData(data) {
    dataList.add(data);
    notifyListeners();

    SharedPreferencesUtil.setJsonList('dataList', dataList);
  }

  void deleteData() {
    dataList.clear();
    notifyListeners();

    SharedPreferencesUtil.remove('dataList');
  }

  // 리스트뷰 높이 지정

  double returnListViewHeight() {
    if (dataList.length == 1) {
      return 63;
    } else if (dataList.length == 2) {
      return 140;
    } else {
      return 217;
    }
  }

   // 일지 자동 초기화 관련

  late Timer timer;

  DateTime noteInitTime() {
    return DateTime.parse(dataList.last['time']).add(const Duration(days: 7));
  }

  String formatDuration(Duration duration) {
    String twoDigits(int n) {
      if (n >= 10) return "$n";
      return "0$n";
    }

    String twoDigitHours = twoDigits(duration.inHours);
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));

    return "$twoDigitHours:$twoDigitMinutes:$twoDigitSeconds";
  }

  void checkTimeDifference(BuildContext context) {
    if (dataList.isNotEmpty) {
      if (DateTime.now().difference(DateTime.parse(dataList.last['time'])).inDays >= 7) {
        deleteData();
      }
    }
    notifyListeners();
  }

  // 운동항목 다이얼로그 관련

  late bool isSelected1; // 풀업
  late bool isSelected2; // 친업
  late bool isSelected3; // 푸쉬업
  late bool isSelected4; // 너클 푸쉬업


  void initCategory() {
    isSelected1 = SharedPreferencesUtil.getBool('category1') ?? true;
    isSelected2 = SharedPreferencesUtil.getBool('category2') ?? false;
    isSelected3 = SharedPreferencesUtil.getBool('category3') ?? true;
    isSelected4 = SharedPreferencesUtil.getBool('category4') ?? false;
    notifyListeners();
  }

  void saveCategory(bool c1, bool c2, bool c3, bool c4)  {
    SharedPreferencesUtil.setBool('category1', c1);
    SharedPreferencesUtil.setBool('category2', c2);
    SharedPreferencesUtil.setBool('category3', c3);
    SharedPreferencesUtil.setBool('category4', c4);
  }
}
