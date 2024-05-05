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
}
