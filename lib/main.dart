import 'package:escape_anchovy/src/app.dart';
import 'package:flutter/material.dart';

class SettingController with ChangeNotifier {
  ThemeMode themeMode = ThemeMode.system;
  String theme = '';

  Future<void> updateThemeMode(ThemeMode? newThemeMode, String newTheme) async {
    themeMode = newThemeMode!;
    theme = newTheme;
    notifyListeners();
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final settingController = SettingController();

  runApp(MyApp(settingController: settingController));
}
