import 'package:escape_anchovy/src/screen/home/home_screen.dart';
import 'package:escape_anchovy/src/util/shared_preferences_util.dart';
import 'package:flutter/material.dart';

class UserNameController with ChangeNotifier {
  void savedName(BuildContext context) {
    SharedPreferencesUtil.setBool('inputName', true);
    SharedPreferencesUtil.setString('name', nameController.text);

    Navigator.pushReplacementNamed(context, HomeScreen.routeName);
  }

  final nameController = TextEditingController();
  final nameFocus = FocusNode();
  bool isNameInputting = false;
  bool isNameValid = false;

  final nameKey = GlobalKey<FormState>();

  void checkNameValidation(String value) {
    isNameValid = value.isNotEmpty;
    notifyListeners();
  }
}
