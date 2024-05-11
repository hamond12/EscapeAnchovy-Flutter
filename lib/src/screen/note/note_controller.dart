import 'package:escape_anchovy/src/util/shared_preferences_util.dart';
import 'package:flutter/material.dart';

class NoteController with ChangeNotifier {
  List<Map<String, dynamic>> dataList = [];

  void initDataList() {
    dataList = SharedPreferencesUtil.getJsonList('dataList');
  }
}
