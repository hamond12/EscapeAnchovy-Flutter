import 'package:escape_anchovy/src/util/shared_preferences_util.dart';
import 'package:flutter/material.dart';

class HomeController with ChangeNotifier {
  String loadUserName() {
    final userName = SharedPreferencesUtil.getString('name');
    return userName!;
  }
}
