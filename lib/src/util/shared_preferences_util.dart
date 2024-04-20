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
}
