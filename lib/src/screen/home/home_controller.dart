import 'dart:async';

import 'package:escape_anchovy/src/util/shared_preferences_util.dart';
import 'package:flutter/material.dart';

class HomeController with ChangeNotifier {
  List<Map<String, dynamic>> dataList = [];

  void initDataList() {
    dataList = SharedPreferencesUtil.getJsonList('dataList');
  }

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
}
