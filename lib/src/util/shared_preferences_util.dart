import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesUtil {
  static SharedPreferencesUtil? _singleton;
  static SharedPreferences? _prefs;

  static Future<SharedPreferencesUtil?> getInstance() async {
    if (_singleton == null) {
      var singleton = SharedPreferencesUtil._();
      await singleton._init();
      _singleton = singleton;
    }
    return _singleton;
  }

  SharedPreferencesUtil._();

  Future _init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  static String? getString(String key, {String? defValue = ''}) {
    return _prefs?.getString(key) ?? defValue;
  }

  static Future<bool>? setString(String key, String value) {
    return _prefs?.setString(key, value);
  }

  static bool? getBool(String key, {bool? defValue = false}) {
    return _prefs?.getBool(key) ?? defValue;
  }

  static Future<bool>? setBool(String key, bool value) {
    return _prefs?.setBool(key, value);
  }

  static List<Map<String, dynamic>> getJsonList(String key) {
    List<String>? dataList = _prefs?.getStringList(key);
    return dataList
            ?.map((value) => json.decode(value) as Map<String, dynamic>)
            .toList() ??
        [];
  }

  static Future<bool> setJsonList(String key, List<Map<String, dynamic>> list) {
    List<String> dataList = list.map((map) => json.encode(map)).toList();
    return _prefs!.setStringList(key, dataList);
  }

  static Future<bool> remove(String key) async {
    return await _prefs!.remove(key);
  }
}
